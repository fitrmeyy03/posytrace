import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/core/shared/pages/notifications_page.dart';

void main() {
  testWidgets('Tap notif vaksin membuka detail pengingat',
      (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: NotificationsPage()));
    await tester.pumpAndSettle();

    expect(find.text('Notifikasi'), findsOneWidget);
    await tester.tap(find.text('Vaksin MMR Mark 3 Hari Lagi'));
    await tester.pumpAndSettle();

    expect(find.text('Detail Pengingat'), findsOneWidget);
    expect(find.text('Mark Kalandra'), findsOneWidget);
    expect(find.text('Imunisasi Campak, Gondongan & Rubella'),
        findsOneWidget);
    expect(find.text('Rabu, 14 Mei 2026'), findsOneWidget);
  });

  testWidgets('Tombol alarm di detail menampilkan toast',
      (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: NotificationsPage()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Vaksin MMR Mark 3 Hari Lagi'));
    await tester.pumpAndSettle();

    final scrollable = find.byType(CustomScrollView).first;
    await tester.dragUntilVisible(
      find.text('Pasang Alarm'),
      scrollable,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pasang Alarm'));
    await tester.pump();
    expect(find.text('Alarm pengingat MMR dipasang'),
        findsOneWidget);
  });
}
