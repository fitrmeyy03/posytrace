import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/auth/presentation/pages/login_page.dart';
import 'package:posytrace_skripsi/features/auth/presentation/pages/register_page.dart';
import 'package:posytrace_skripsi/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:posytrace_skripsi/features/parent/presentation/pages/main_shell.dart';
import 'package:posytrace_skripsi/features/midwife/presentation/pages/midwife_main_shell.dart';

Widget _app() => MaterialApp(
      home: const LoginPage(),
      routes: {
        '/home': (_) => const MainShell(),
        '/midwife-home': (_) => const MidwifeMainShell(),
        '/register': (_) => const RegisterPage(),
        '/forgot-password': (_) => const ForgotPasswordPage(),
      },
    );

Future<void> _fillValid(WidgetTester tester) async {
  await tester.enterText(
      find.byType(TextFormField).at(0), '08123456789');
  await tester.enterText(
      find.byType(TextFormField).at(1), 'rahasia123');
  await tester.pump();
}

void main() {
  testWidgets('Login ortu masuk ke beranda parent', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    expect(find.text('Selamat Datang, Ayah & Bunda!'),
        findsOneWidget);

    await _fillValid(tester);
    await tester.tap(find.text('Masuk ke Akun PosyTrace'));
    await tester.pumpAndSettle();
    expect(find.text('Hai, Ibu Agnes'), findsOneWidget);
  });

  testWidgets('Tab Daftar buka halaman registrasi', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();
    expect(find.text('REGISTRASI DIGITAL POSYANDU'), findsOneWidget);
  });

  testWidgets('Login bidan masuk ke beranda bidan', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bidan'));
    await tester.pump();
    await _fillValid(tester);
    await tester.tap(find.text('Masuk ke Akun PosyTrace'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Bidan Ratna'), findsWidgets);
  });
}
