import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/features/kader/presentation/pages/children_page.dart';
import 'package:posytrace_skripsi/features/kader/presentation/pages/kader_main_shell.dart';

Widget _shell() => MaterialApp(
      home: const KaderMainShell(),
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (_) => const Scaffold(body: Text('Detail')),
      ),
    );

void main() {
  testWidgets('Beranda kader: jadwal hari ini & balita perlu perhatian',
      (tester) async {
    await tester.pumpWidget(_shell());
    await tester.pumpAndSettle();

    expect(find.text('Halo, Ibu Sari'), findsOneWidget);
    expect(find.text('POSYANDU HARI INI'), findsOneWidget);
    expect(find.text('Mulai Pencatatan'), findsOneWidget);
    expect(find.text('Perlu Perhatian'), findsOneWidget);
  });

  testWidgets('Daftar balita: cari & saring status', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ChildrenPage()));
    await tester.pumpAndSettle();

    expect(find.text('Aisyah Putri'), findsOneWidget);

    await tester.tap(find.text('Buruk'));
    await tester.pumpAndSettle();
    expect(find.text('Rizky Pratama'), findsOneWidget);
    expect(find.text('Aisyah Putri'), findsNothing);

    await tester.tap(find.text('Semua'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'sinta');
    await tester.pumpAndSettle();
    expect(find.text('Sinta Maharani'), findsOneWidget);
    expect(find.text('Rizky Pratama'), findsNothing);
  });

  testWidgets('Segment Orang Tua menampilkan akun orang tua', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ChildrenPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Orang Tua'));
    await tester.pumpAndSettle();
    expect(find.text('Ibu Dewi Lestari'), findsOneWidget);
    expect(find.text('Ibu Maya Kusuma'), findsOneWidget);
  });
}
