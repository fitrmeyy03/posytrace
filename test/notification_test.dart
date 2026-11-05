import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/core/shared/pages/notifications_page.dart';

void main() {
  testWidgets('Notifikasi: daftar baru & sebelumnya', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: NotificationsPage()));
    await tester.pumpAndSettle();

    expect(find.text('Notifikasi'), findsOneWidget);
    expect(find.text('BARU'), findsOneWidget);
    expect(find.text('Hasil kunjungan Aisyah'), findsWidgets);
  });

  testWidgets('Tap notifikasi membuka detail', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: NotificationsPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pengingat posyandu').first);
    await tester.pumpAndSettle();

    expect(find.text('Tutup'), findsOneWidget);
    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    expect(find.text('Tutup'), findsNothing);
  });
}
