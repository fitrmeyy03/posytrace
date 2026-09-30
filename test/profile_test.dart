import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/core/shared/pages/profile_page.dart';
import 'package:posytrace_skripsi/features/auth/presentation/pages/login_page.dart';

Widget _app() => MaterialApp(
      home: const ProfilePage(),
      routes: {'/login': (_) => const LoginPage()},
    );

void main() {
  testWidgets('Profil ortu tampil + QR dialog', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.text('Profil Saya'), findsOneWidget);
    expect(find.text('Bunda Agnes Safitri'), findsOneWidget);
    expect(find.text('Mark Kalandra'), findsOneWidget);

    await tester.tap(find.text('QR Anggota KIA'));
    await tester.pumpAndSettle();
    expect(find.text('QR Anggota KIA'), findsWidgets);
    expect(find.text('Tutup'), findsOneWidget);
    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
  });

  testWidgets('Logout kembali ke login', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    final scrollable = find.byType(CustomScrollView).first;
    await tester.dragUntilVisible(
      find.text('Keluar dari Akun'),
      scrollable,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Keluar dari Akun'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Keluar').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Selamat Datang, Ayah'),
        findsWidgets);
  });
}
