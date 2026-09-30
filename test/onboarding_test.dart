import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:posytrace_skripsi/features/auth/presentation/pages/login_page.dart';

Widget _app() => MaterialApp(
      home: const OnboardingPage(),
      routes: {'/login': (_) => const LoginPage()},
    );

/// Animasi float berulang selamanya -> pakai pump durasi eksplisit.
Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
}

void main() {
  testWidgets('Carousel 3 slide + CTA ke login', (tester) async {
    await tester.pumpWidget(_app());
    await _settle(tester);

    // Slide 1
    expect(find.text('Pantau Tumbuh Kembang & KMS Digital'),
        findsOneWidget);
    expect(find.text('Lanjut'), findsOneWidget);

    // CTA Lanjut -> slide 2
    await tester.tap(find.text('Lanjut'));
    await _settle(tester);
    expect(find.text('Jadwal Vaksinasi & Notifikasi Posyandu'),
        findsOneWidget);

    // Swipe (fling) -> slide 3
    await tester.fling(
        find.byType(PageView), const Offset(-400, 0), 1200);
    await _settle(tester);
    expect(find.text('Edukasi Parenting Tepercaya'), findsOneWidget);
    expect(find.text('Mulai Sekarang'), findsOneWidget);

    // Mulai -> login
    await tester.tap(find.text('Mulai Sekarang'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));
    await tester.pump();
    expect(find.textContaining('Selamat Datang, Ayah'),
        findsWidgets);
  });

  testWidgets('Lewati langsung ke slide 3', (tester) async {
    await tester.pumpWidget(_app());
    await _settle(tester);
    await tester.tap(find.text('Lewati'));
    await _settle(tester);
    expect(find.text('Edukasi Parenting Tepercaya'), findsOneWidget);
  });
}
