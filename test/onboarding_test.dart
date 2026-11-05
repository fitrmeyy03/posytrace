import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/onboarding/presentation/pages/onboarding_page.dart';

Widget _app() => MaterialApp(
      home: const OnboardingPage(),
      routes: {
        '/login': (_) => const Scaffold(body: Text('Login')),
      },
    );

void main() {
  testWidgets('Onboarding 3 slide + Mulai ke login', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.text('Pantau Tumbuh Kembang Balita'), findsOneWidget);

    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();
    expect(find.text('Status Gizi Terhitung Otomatis'), findsOneWidget);

    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();
    expect(find.text('Edukasi & Pengingat untuk Orang Tua'), findsOneWidget);

    await tester.tap(find.text('Mulai'));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Lewati langsung ke login', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Lewati'));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
  });
}
