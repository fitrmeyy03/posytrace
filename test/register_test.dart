import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/auth/presentation/pages/register_page.dart';

void main() {
  testWidgets('Meter kekuatan sandi mengikuti ketikan',
      (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: RegisterPage()));
    await tester.pumpAndSettle();

    expect(find.textContaining('Kekuatan Sandi: Lemah'),
        findsOneWidget);

    final fields = find.byType(TextFormField);
    // Field password = index 3 (nama, WA, NIK, sandi, konfirmasi)
    await tester.enterText(fields.at(3), 'abcdefghij');
    await tester.pump();
    expect(find.textContaining('Kekuatan Sandi: Kuat'),
        findsOneWidget);

    await tester.enterText(fields.at(3), 'abc');
    await tester.pump();
    expect(find.textContaining('Kekuatan Sandi: Lemah'),
        findsOneWidget);
  });
}
