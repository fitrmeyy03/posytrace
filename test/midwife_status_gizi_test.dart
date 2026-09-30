import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/midwife/presentation/pages/midwife_schedule_page.dart';

void main() {
  testWidgets('Status gizi: ganti pasien + filter + simpan',
      (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: MidwifeSchedulePage()));
    await tester.pumpAndSettle();

    expect(find.text('Kenzo Alfarizi'), findsWidgets);

    // Tampilkan semua pasien dulu (default filter = Stunting)
    await tester.tap(find.text('Semua'));
    await tester.pumpAndSettle();

    // Ganti pasien via daftar horizontal
    final scroll = find.byType(Scrollable).first;
    await tester.dragUntilVisible(
      find.text('Dinda Humaira'),
      scroll,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dinda Humaira'));
    await tester.pumpAndSettle();
    expect(find.text('Dinda Humaira'), findsWidgets);

    // Filter underweight tetap menampilkan Dinda
    await tester.dragUntilVisible(
      find.text('Underweight'),
      scroll,
      const Offset(0, 300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Underweight'));
    await tester.pumpAndSettle();
    expect(find.text('Dinda Humaira'), findsWidgets);

    // Simpan rekomendasi
    final scrollable = find.byType(Scrollable).first;
    await tester.dragUntilVisible(
      find.text('Simpan Rekomendasi Medis'),
      scrollable,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan Rekomendasi Medis'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.text('Tersimpan'), findsOneWidget);
    // Biarkan timer toast 3 detik selesai agar tidak pending
    await tester.pump(const Duration(seconds: 4));
  });
}
