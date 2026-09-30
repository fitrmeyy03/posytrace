import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/parent/presentation/pages/growth_page.dart';

Widget _app() =>
    const MaterialApp(home: Scaffold(body: GrowthPage()));

void main() {
  testWidgets('Modul KMS tampil default + ganti metrik', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    expect(find.text('Kurva Pertumbuhan Balita'), findsOneWidget);
    expect(find.text('Mark Kalandra'), findsOneWidget);

    await tester.tap(find.text('Tinggi'));
    await tester.pumpAndSettle();
    expect(find.text('Mark: 118 cm'), findsOneWidget);
  });

  testWidgets('Tab vaksin + obat berganti modul', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Riwayat Vaksin'));
    await tester.pumpAndSettle();
    expect(find.text('Riwayat & Jadwal Vaksin'), findsOneWidget);
    expect(find.text('Vaksin MMR (Campak/Rubella)'), findsOneWidget);

    await tester.tap(find.text('Obat & Nutrisi'));
    await tester.pumpAndSettle();
    expect(find.text('Obat & Nutrisi Harian'), findsOneWidget);
    expect(find.textContaining('Vitamin A (Kapsul Merah'),
        findsOneWidget);
  });
}
