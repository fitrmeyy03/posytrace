import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posytrace_skripsi/core/data/demo_data.dart';
import 'package:posytrace_skripsi/core/models/user_role.dart';
import 'package:posytrace_skripsi/features/shared/presentation/pages/change_password_page.dart';
import 'package:posytrace_skripsi/features/shared/presentation/pages/child_detail_page.dart';
import 'package:posytrace_skripsi/features/shared/presentation/pages/growth_chart_page.dart';
import 'package:posytrace_skripsi/features/kader/presentation/pages/kader_schedule_page.dart';
import 'package:posytrace_skripsi/features/kader/presentation/pages/parent_detail_page.dart';
import 'package:posytrace_skripsi/features/kader/presentation/pages/parent_form_page.dart';
import 'package:posytrace_skripsi/features/kader/presentation/pages/parents_page.dart';
import 'package:posytrace_skripsi/features/kader/presentation/pages/record_visit_page.dart';
import 'package:posytrace_skripsi/features/midwife/presentation/pages/add_article_page.dart';
import 'package:posytrace_skripsi/features/midwife/presentation/pages/manage_kader_page.dart';
import 'package:posytrace_skripsi/features/parent/presentation/pages/article_detail_page.dart';
import 'package:posytrace_skripsi/features/parent/presentation/pages/articles_page.dart';
import 'package:posytrace_skripsi/features/parent/presentation/pages/measurement_history_page.dart';
import 'package:posytrace_skripsi/features/parent/presentation/pages/schedule_page.dart';

/// Smoke test semua layar pada ukuran ponsel â€” memastikan tidak ada overflow.
void main() {
  Future<void> pumpPhone(WidgetTester tester, Widget page) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        home: page,
        onGenerateRoute: (_) =>
            MaterialPageRoute(builder: (_) => const SizedBox.shrink()),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  }

  testWidgets('Detail balita (kader)', (t) async {
    await pumpPhone(
      t,
      const ChildDetailPage(childName: 'Aisyah Putri', role: UserRole.kader),
    );
    expect(find.text('Detail Balita'), findsOneWidget);
  });

  testWidgets('Detail balita (bidan, baca saja)', (t) async {
    await pumpPhone(
      t,
      const ChildDetailPage(childName: 'Rizky Pratama', role: UserRole.bidan),
    );
    expect(find.text('Catat Kunjungan'), findsNothing);
  });

  testWidgets('Pencatatan kunjungan', (t) async {
    await pumpPhone(t, const RecordVisitPage());
    expect(find.text('Hasil Z-Score (WHO)'), findsOneWidget);
  });

  testWidgets('Manajemen orang tua', (t) async {
    await pumpPhone(t, const ParentsPage());
    expect(find.text('Manajemen Orang Tua'), findsOneWidget);
  });

  testWidgets('Tambah orang tua', (t) async {
    await pumpPhone(t, const ParentFormPage());
    expect(find.text('Simpan & Hubungkan'), findsOneWidget);
  });

  testWidgets('Detail orang tua', (t) async {
    await pumpPhone(t, ParentDetailPage(parent: DemoData.parents.first));
    expect(find.text('Keamanan Akun'), findsOneWidget);
  });

  testWidgets('Jadwal posyandu', (t) async {
    await pumpPhone(t, const KaderSchedulePage());
    expect(find.text('Jadwal Posyandu'), findsOneWidget);
  });

  testWidgets('Tulis artikel', (t) async {
    await pumpPhone(t, const AddArticlePage());
    expect(find.text('Terbitkan Artikel'), findsOneWidget);
  });

  testWidgets('Kelola akun kader', (t) async {
    await pumpPhone(t, const ManageKaderPage());
    expect(find.text('Kelola Akun Kader'), findsOneWidget);
  });

  testWidgets('Grafik pertumbuhan', (t) async {
    await pumpPhone(t, const GrowthChartPage());
    expect(find.text('Grafik pertumbuhan'), findsOneWidget);
  });

  testWidgets('Riwayat kunjungan', (t) async {
    await pumpPhone(t, const MeasurementHistoryPage());
    expect(find.text('Riwayat Kunjungan'), findsOneWidget);
  });

  testWidgets('Jadwal posyandu', (t) async {
    await pumpPhone(t, const SchedulePage());
    expect(find.text('Jadwal posyandu'), findsOneWidget);
  });

  testWidgets('Daftar artikel', (t) async {
    await pumpPhone(t, const ArticlesPage());
    expect(find.text('Artikel edukasi'), findsOneWidget);
  });

  testWidgets('Gambar artikel terbaca dari bundle', (t) async {
    for (final article in DemoData.articles) {
      for (final path in [article.image, article.banner]) {
        if (path == null) continue;
        final data = await rootBundle.load(path);
        expect(data.lengthInBytes, greaterThan(0), reason: path);
      }
    }
  });

  testWidgets('Baca artikel', (t) async {
    await pumpPhone(t, ArticleDetailPage(article: DemoData.articles.first));
    expect(find.textContaining('MP-ASI'), findsWidgets);
  });

  testWidgets('Ganti kata sandi (pertama masuk)', (t) async {
    await pumpPhone(t, const ChangePasswordPage(firstLogin: true));
    expect(find.text('Simpan Kata Sandi Baru'), findsOneWidget);
  });
}
