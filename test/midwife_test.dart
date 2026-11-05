import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/midwife/presentation/pages/midwife_articles_page.dart';
import 'package:posytrace_skripsi/features/midwife/presentation/pages/midwife_main_shell.dart';
import 'package:posytrace_skripsi/features/midwife/presentation/pages/posyandu_list_page.dart';

void main() {
  testWidgets('Beranda bidan: ringkasan & balita perlu pantauan',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MidwifeMainShell()));
    await tester.pumpAndSettle();

    expect(find.text('Halo, Bidan Ratna'), findsOneWidget);
    expect(find.text('Posyandu'), findsOneWidget);
    expect(find.text('Balita'), findsWidgets);
    expect(find.text('Balita Perlu Pemantauan'), findsOneWidget);

    // Tab Balita -> Pantauan Balita
    await tester.tap(find.text('Balita').last);
    await tester.pumpAndSettle();
    expect(find.text('Pantauan Balita'), findsOneWidget);

    await tester.tap(find.text('Kurang').first);
    await tester.pumpAndSettle();
    expect(find.text('Nadia Safitri'), findsOneWidget);
  });

  testWidgets('Posyandu binaan menampilkan 3 posyandu', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PosyanduListPage()));
    await tester.pumpAndSettle();

    expect(find.text('Posyandu Melati'), findsOneWidget);
    expect(find.text('Posyandu Mawar'), findsOneWidget);
    expect(find.text('Posyandu Anggrek'), findsOneWidget);
  });

  testWidgets('Artikel saya: terbit & draf', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MidwifeArticlesPage()));
    await tester.pumpAndSettle();

    expect(find.text('Artikel Saya'), findsOneWidget);
    expect(find.text('Terbit'), findsWidgets);
    expect(find.text('Draf'), findsOneWidget);
  });
}
