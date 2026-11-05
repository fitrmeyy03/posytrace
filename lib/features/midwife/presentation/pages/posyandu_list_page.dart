import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';
import 'manage_kader_page.dart';

/// Posyandu Binaan — daftar posyandu, kader, dan jumlah balita.
class PosyanduListPage extends StatelessWidget {
  const PosyanduListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarHeader(title: 'Posyandu Binaan'),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          Text(
            '3 posyandu',
            style: AppText.caption.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.deepOrange,
            ),
          ),
          const SizedBox(height: AppSpacing.gapSm),
          ...DemoData.posyandu.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManageKaderPage()),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(p.name, style: AppText.h3)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.dangerBg,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusPill),
                          ),
                          child: Text(
                            '${p.needAttention} perlu pantauan',
                            style: AppText.caption.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.danger,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${p.children} balita · ${p.cadres} kader · '
                      'Kunjungan terakhir ${p.lastVisit}',
                      style: AppText.caption,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.gapXs),
          const InfoNote(
            'Total 128 balita di 3 posyandu binaan. Ketuk satu posyandu untuk melihat kader dan balitanya.',
          ),
        ],
      ),
    );
  }
}
