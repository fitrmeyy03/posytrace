import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/auth/presentation/pages/login_page.dart';
import 'package:posytrace_skripsi/features/kader/presentation/pages/kader_main_shell.dart';
import 'package:posytrace_skripsi/features/midwife/presentation/pages/midwife_main_shell.dart';
import 'package:posytrace_skripsi/features/parent/presentation/pages/main_shell.dart';

Widget _app() => MaterialApp(
      home: const LoginPage(),
      routes: {
        '/home': (_) => const MainShell(),
        '/kader-home': (_) => const KaderMainShell(),
        '/midwife-home': (_) => const MidwifeMainShell(),
      },
    );

Future<void> _fill(WidgetTester tester) async {
  await tester.enterText(find.byType(TextField).at(0), '081234567890');
  await tester.enterText(find.byType(TextField).at(1), 'rahasia123');
  await tester.pump();
  await tester.tap(find.text('Masuk'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Validasi nomor HP kosong ditolak', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();
    expect(find.text('Nomor HP minimal 10 digit'), findsOneWidget);
  });

  testWidgets('Login orang tua masuk ke beranda orang tua', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await _fill(tester);
    expect(find.text('Masuk sebagai'), findsOneWidget);

    await tester.tap(find.text('Orang Tua'));
    await tester.pumpAndSettle();
    expect(find.text('Halo, Ibu Dewi'), findsOneWidget);
  });

  testWidgets('Login kader masuk ke beranda kader', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await _fill(tester);
    await tester.tap(find.text('Kader'));
    await tester.pumpAndSettle();
    expect(find.text('Halo, Ibu Sari'), findsOneWidget);
  });

  testWidgets('Login bidan masuk ke beranda bidan', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await _fill(tester);
    await tester.tap(find.text('Bidan'));
    await tester.pumpAndSettle();
    expect(find.text('Halo, Bidan Ratna'), findsOneWidget);
  });
}
