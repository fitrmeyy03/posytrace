import 'package:flutter_test/flutter_test.dart';

import 'package:posytrace_skripsi/main.dart';

void main() {
  testWidgets('App boot: splash berpindah ke onboarding', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Splash memakai Timer 3,5 detik — majukan waktu eksplisit.
    await tester.pump(const Duration(seconds: 4));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Pantau Tumbuh Kembang Balita'), findsOneWidget);
    expect(find.text('Lanjut'), findsOneWidget);
  });
}
