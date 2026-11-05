import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';
import 'parent_detail_page.dart';
import 'parent_form_page.dart';

/// Manajemen Orang Tua — daftar akun orang tua satu posyandu.
class ParentsPage extends StatefulWidget {
  const ParentsPage({super.key});

  @override
  State<ParentsPage> createState() => _ParentsPageState();
}

class _ParentsPageState extends State<ParentsPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final parents = DemoData.parents
        .where((p) =>
            p.name.toLowerCase().contains(_query.toLowerCase()) ||
            p.phone.contains(_query))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarHeader(title: 'Manajemen Orang Tua'),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          AppSearchField(
            hint: 'Cari nama / nomor HP…',
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          ...parents.map(
            (parent) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                padding: const EdgeInsets.all(14),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ParentDetailPage(parent: parent),
                  ),
                ),
                child: Row(
                  children: [
                    AppAvatar(initial: parent.initial),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(parent.name, style: AppText.title),
                          const SizedBox(height: 2),
                          Text(
                            '${parent.phone} · ${parent.childCount} anak',
                            style: AppText.caption,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded,
                        color: AppColors.textMuted),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.gapSm),
          const InfoNote(
            'Data orang tua dan balita disimpan terpisah — satu akun orang tua bisa terhubung ke banyak balita.',
          ),
          const SizedBox(height: AppSpacing.gapLg),
          AppButton(
            'Tambah Orang Tua',
            icon: Icons.add_rounded,
            expanded: true,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ParentFormPage()),
            ),
          ),
        ],
      ),
    );
  }
}
