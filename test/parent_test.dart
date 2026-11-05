import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/parent/presentation/pages/main_shell.dart';

void main() {
  testWidgets('Beranda orang tua: anak & jadwal berikutnya', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainShell()));
    await tester.pumpAndSettle();

    expect(find.text('Halo, Ibu Dewi'), findsOneWidget);
    expect(find.text('Aisyah Putri'), findsOneWidget);
    expect(find.textContaining('Lihat grafik pertumbuhan'), findsWidgets);

    await tester.scrollUntilVisible(
      find.textContaining('KUNJUNGAN BERIKUTNYA'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.textContaining('KUNJUNGAN BERIKUTNYA'), findsOneWidget);
  });

  testWidgets('Geser kartu anak mengganti data aktif', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainShell()));
    await tester.pumpAndSettle();

    final aisyahBefore = tester.getTopLeft(find.text('Aisyah Putri')).dx;
    final bimaBefore = tester.getTopLeft(find.text('Bima Aditya')).dx;
    expect(aisyahBefore, lessThan(bimaBefore));

    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    final aisyahAfter = tester.getTopLeft(find.text('Aisyah Putri')).dx;
    final bimaAfter = tester.getTopLeft(find.text('Bima Aditya')).dx;
    expect(aisyahAfter, lessThan(0));
    expect(bimaAfter, greaterThan(0));
  });

  testWidgets('Tab Jadwal menampilkan jadwal posyandu', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainShell()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Jadwal'));
    await tester.pumpAndSettle();
    expect(find.text('Jadwal posyandu'), findsOneWidget);
    expect(find.text('JADWAL BERIKUTNYA'), findsOneWidget);
    expect(find.text('Riwayat jadwal'), findsOneWidget);
  });

  testWidgets('Tombol grafik membuka halaman grafik', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainShell()));
    await tester.pumpAndSettle();

    await tester.tap(find.textContaining('Lihat grafik pertumbuhan').first);
    await tester.pumpAndSettle();
    expect(find.textContaining('PENGUKURAN TERAKHIR'), findsOneWidget);
    expect(find.text('BB (kg)'), findsOneWidget);
  });

  testWidgets('Tab Artikel menampilkan daftar edukasi', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainShell()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Artikel'));
    await tester.pumpAndSettle();
    expect(find.text('Artikel edukasi'), findsOneWidget);
    expect(
      find.text('MP-ASI Kaya Protein untuk Cegah Stunting'),
      findsOneWidget,
    );
  });
}
