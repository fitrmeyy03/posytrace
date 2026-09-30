import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/parent/presentation/pages/main_shell.dart';
import 'package:posytrace_skripsi/features/parent/presentation/pages/articles_page.dart';

void main() {
  testWidgets('Dock Edukasi membuka halaman edukasi', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainShell()));
    await tester.pumpAndSettle();

    // Dashboard warm tampil
    expect(find.text('Layanan & Fitur'), findsOneWidget);

    // Tap tombol Edukasi di floating dock (label semantik)
    await tester.tap(find.bySemanticsLabel('Edukasi'));
    await tester.pumpAndSettle();

    // Halaman edukasi harus tampil
    expect(find.text('Edukasi & Panduan'), findsOneWidget);
  });

  testWidgets('Halaman edukasi: filter + buka detail', (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ArticlesPage())));
    await tester.pumpAndSettle();

    expect(find.text('Edukasi & Panduan'), findsOneWidget);

    // Pilih filter Gizi & MPASI
    await tester.tap(find.text('Gizi & MPASI'));
    await tester.pumpAndSettle();
    expect(find.textContaining('MPASI 4 Bintang'), findsWidgets);

    // Buka artikel sorotan -> masuk ke detail
    final scrollable = find.byType(CustomScrollView).first;
    await tester.dragUntilVisible(
      find.textContaining('MPASI 4 Bintang').first,
      scrollable,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('MPASI 4 Bintang').first);
    await tester.pumpAndSettle();
    expect(find.text('dr. Tiara Anindita, Sp.A'), findsOneWidget);

    // Toolbar baca: besarkan font + putar audio
    await tester.tap(find.text('A+'));
    await tester.pump();
    await tester.tap(find.text('Dengarkan'));
    await tester.pump();
    expect(find.text('04:12 Jeda'), findsOneWidget);
  });

  testWidgets('Search ter-debounce 300ms', (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ArticlesPage())));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'tidur');
    await tester.pump(const Duration(milliseconds: 100));
    // Belum terfilter: kartu MPASI masih ada
    expect(find.textContaining('MPASI 4 Bintang'), findsWidgets);

    await tester.pump(const Duration(milliseconds: 300));
    // Sudah terfilter: hanya artikel tidur
    expect(find.textContaining('MPASI 4 Bintang'), findsNothing);
    expect(find.textContaining('Tanpa Rewel'), findsOneWidget);
  });
}
