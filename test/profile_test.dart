import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/core/models/user_role.dart';
import 'package:posytrace_skripsi/core/shared/pages/change_password_page.dart';
import 'package:posytrace_skripsi/core/shared/pages/profile_page.dart';
import 'package:posytrace_skripsi/features/auth/presentation/pages/login_page.dart';

Widget _app(UserRole role) => MaterialApp(
      home: ProfilePage(role: role),
      routes: {'/login': (_) => const LoginPage()},
    );

void main() {
  testWidgets('Profil kader menampilkan data akun', (tester) async {
    await tester.pumpWidget(_app(UserRole.kader));
    await tester.pumpAndSettle();

    expect(find.text('Profil'), findsOneWidget);
    expect(find.text('Ibu Sari Wulandari'), findsOneWidget);
    expect(find.text('Edit Profil'), findsOneWidget);
    expect(find.text('Ganti Kata Sandi'), findsOneWidget);
  });

  testWidgets('Profil orang tua menampilkan anak terhubung', (tester) async {
    await tester.pumpWidget(_app(UserRole.parent));
    await tester.pumpAndSettle();

    expect(find.text('Ibu Dewi Lestari'), findsOneWidget);
    expect(find.text('Anak terhubung:'), findsOneWidget);
    expect(find.text('Aisyah'), findsOneWidget);
    expect(find.text('Bima'), findsOneWidget);
  });

  testWidgets('Logout kembali ke login', (tester) async {
    await tester.pumpWidget(_app(UserRole.kader));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Keluar'), 200);
    await tester.tap(find.text('Keluar'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Keluar').last);
    await tester.pumpAndSettle();
    expect(find.text('Masuk'), findsOneWidget);
  });

  testWidgets('Ganti kata sandi memvalidasi konfirmasi', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ChangePasswordPage()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(1), 'abc123');
    await tester.enterText(find.byType(TextField).at(2), 'beda');
    await tester.tap(find.text('Simpan Kata Sandi Baru'));
    await tester.pumpAndSettle();

    expect(find.text('Konfirmasi kata sandi belum sama.'), findsOneWidget);
  });
}
