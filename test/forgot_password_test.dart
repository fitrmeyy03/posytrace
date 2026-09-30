import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/auth/presentation/pages/forgot_password_page.dart';

Widget _app() =>
    const MaterialApp(home: ForgotPasswordPage());

void main() {
  testWidgets('Tab Email ganti label + keyboard', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    expect(find.text('Lupa Kata Sandi Akun?'), findsOneWidget);
    expect(find.text('Nomor WhatsApp Terdaftar'), findsOneWidget);

    await tester.tap(find.text('Email'));
    await tester.pumpAndSettle();
    expect(find.text('Alamat Email Terdaftar'), findsOneWidget);
  });

  testWidgets('Accordion KIA + kirim OTP sukses', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    // Buka fallback KIA
    await tester.tap(find.text('Lupa Nomor WhatsApp & Email?'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Nomor Identitas Anak'),
        findsOneWidget);

    // Submit -> success
    await tester.dragUntilVisible(
      find.text('Kirim Kode Verifikasi (OTP)'),
      find.byType(Scrollable).first,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kirim Kode Verifikasi (OTP)'));
    await tester.pumpAndSettle();
    expect(find.text('Kode OTP Terkirim!'), findsOneWidget);
  });
}
