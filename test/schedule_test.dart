import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/parent/presentation/pages/schedule_page.dart';

Widget _app() =>
    const MaterialApp(home: Scaffold(body: SchedulePage()));

void main() {
  testWidgets('Hero sesi + tab riwayat berganti', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.text('Jadwal Posyandu'), findsOneWidget);
    expect(find.text('Rabu, 14 Mei 2026'), findsOneWidget);

    final scrollable = find.byType(CustomScrollView).first;
    await tester.dragUntilVisible(
      find.text('Checklist Kunjungan'),
      scrollable,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    expect(find.text('3/4 Siap'), findsOneWidget);

    // Kembali ke atas lalu pindah ke tab riwayat
    await tester.dragUntilVisible(
      find.text('Riwayat Kunjungan'),
      scrollable,
      const Offset(0, 300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Riwayat Kunjungan'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.text('12 April 2026'),
      scrollable,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    expect(find.text('12 April 2026'), findsOneWidget);

    // Kembali ke jadwal mendatang
    await tester.dragUntilVisible(
      find.text('Jadwal Mendatang'),
      scrollable,
      const Offset(0, 300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Jadwal Mendatang'));
    await tester.pumpAndSettle();
    expect(find.text('Rabu, 14 Mei 2026'), findsOneWidget);
  });

  testWidgets('Checklist mengubah counter siap', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    final scrollable = find.byType(CustomScrollView).first;
    await tester.dragUntilVisible(
      find.text('Cek Suhu Tubuh (Tidak Demam)'),
      scrollable,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();

    // Centang item terakhir -> 4/4
    await tester.tap(find.text('Cek Suhu Tubuh (Tidak Demam)'));
    await tester.pumpAndSettle();
    expect(find.text('4/4 Siap'), findsOneWidget);
  });
}
