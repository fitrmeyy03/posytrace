import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/models/growth_status.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';
import 'parent_detail_page.dart';
import 'parents_page.dart';
import 'record_visit_page.dart';

/// Daftar Balita — cari & saring per status gizi, plus tab Orang Tua.
class ChildrenPage extends StatefulWidget {
  const ChildrenPage({super.key});

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  int _segment = 0;
  int _filter = 0;
  String _query = '';

  static const _filters = ['Semua', 'Normal', 'Kurang', 'Buruk'];

  List<ChildRecord> get _children {
    final q = _query.toLowerCase();
    return DemoData.children.where((c) {
      final matchQuery = c.name.toLowerCase().contains(q);
      final matchStatus = switch (_filter) {
        1 => c.status == GrowthStatus.normal,
        2 => c.status == GrowthStatus.under,
        3 => c.status == GrowthStatus.severe,
        _ => true,
      };
      return matchQuery && matchStatus;
    }).toList();
  }

  List<ParentRecord> get _parents => DemoData.parents
      .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      fab: AppFab(
        semanticsLabel: 'Catat kunjungan',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RecordVisitPage()),
        ),
      ),
      children: [
        PageHeading(
          title: 'Data Balita',
          action: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.tint,
              borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            ),
            child: Text(
              '48 anak',
              style: AppText.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.deepOrange,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.gapMd),
        AppSearchField(
          hint: _segment == 0 ? 'Cari nama balita…' : 'Cari nama orang tua…',
          onChanged: (v) => setState(() => _query = v),
        ),
        const SizedBox(height: AppSpacing.gapSm),
        SegmentTabs(
          labels: const ['Balita', 'Orang Tua'],
          index: _segment,
          onChanged: (i) => setState(() => _segment = i),
        ),
        const SizedBox(height: AppSpacing.gapSm),
        if (_segment == 0) ...[
          FilterChips(
            labels: _filters,
            index: _filter,
            onChanged: (i) => setState(() => _filter = i),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          ..._children.map(
            (child) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ChildTile(
                name: child.name,
                meta: '${child.gender} · ${child.ageMonths} bulan',
                status: child.status,
                onTap: () => Navigator.pushNamed(
                  context,
                  '/child-detail',
                  arguments: child.name,
                ),
              ),
            ),
          ),
        ] else ...[
          AppButton.secondary(
            'Kelola Akun Orang Tua',
            icon: Icons.manage_accounts_outlined,
            expanded: true,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ParentsPage()),
            ),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          ..._parents.map(
            (parent) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ParentDetailPage(parent: parent),
                  ),
                ),
                padding: const EdgeInsets.all(14),
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
        ],
      ],
    );
  }
}
