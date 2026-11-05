import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/models/growth_status.dart';
import '../../../../core/models/user_role.dart';
import '../../../../features/shared/presentation/pages/child_detail_page.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Pantauan Balita â€” semua balita binaan, terurut dari yang paling berisiko.
class SurveillancePage extends StatefulWidget {
  const SurveillancePage({super.key});

  @override
  State<SurveillancePage> createState() => _SurveillancePageState();
}

class _SurveillancePageState extends State<SurveillancePage> {
  int _filter = 0;
  static const _filters = ['Semua', 'Buruk', 'Kurang', 'Lebih'];

  int _rank(GrowthStatus s) => switch (s) {
        GrowthStatus.severe => 0,
        GrowthStatus.under => 1,
        GrowthStatus.over => 2,
        GrowthStatus.normal => 3,
      };

  @override
  Widget build(BuildContext context) {
    final children = DemoData.children.where((c) {
      return switch (_filter) {
        1 => c.status == GrowthStatus.severe,
        2 => c.status == GrowthStatus.under,
        3 => c.status == GrowthStatus.over,
        _ => true,
      };
    }).toList()
      ..sort((a, b) => _rank(a.status).compareTo(_rank(b.status)));

    return AppScaffold(
      children: [
        PageHeading(
          title: 'Pantauan Balita',
          action: Text(
            '128 anak',
            style: AppText.caption.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.deepOrange,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.gapMd),
        FilterChips(
          labels: _filters,
          index: _filter,
          onChanged: (i) => setState(() => _filter = i),
        ),
        const SizedBox(height: AppSpacing.gapMd),
        ...children.map(
          (child) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ChildTile(
              name: child.name,
              meta: '${child.posyandu} Â· BB/U '
                  '${child.zWeightAge.toStringAsFixed(1).replaceAll('.', ',')}',
              status: child.status,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChildDetailPage(
                    childName: child.name,
                    role: UserRole.bidan,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.gapXs),
        const InfoNote(
          'Daftar terurut dari status paling berisiko, lintas semua posyandu binaan.',
        ),
      ],
    );
  }
}
