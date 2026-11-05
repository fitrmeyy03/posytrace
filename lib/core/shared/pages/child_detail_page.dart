import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/demo_data.dart';
import '../../models/growth_status.dart';
import '../../models/user_role.dart';
import '../../theme/app_layout.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_mascot.dart';
import '../../widgets/app_widgets.dart';
import '../../../features/kader/presentation/pages/record_visit_page.dart';
import 'growth_chart_page.dart';

/// Detail Balita — dipakai Kader & Bidan (bidan hanya membaca).
class ChildDetailPage extends StatelessWidget {
  final String childName;
  final UserRole role;

  const ChildDetailPage({
    super.key,
    required this.childName,
    this.role = UserRole.kader,
  });

  @override
  Widget build(BuildContext context) {
    final child = DemoData.byName(childName);
    final readOnly = role == UserRole.bidan;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarHeader(title: 'Detail Balita'),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    AppAvatar(initial: child.initial, size: 56),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(child.name, style: AppText.h2),
                          const SizedBox(height: 3),
                          Text(
                            '${child.gender} · lahir ${child.birthDate}',
                            style: AppText.caption,
                          ),
                        ],
                      ),
                    ),
                    StatusChip(child.status, compact: true),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gapSm),
          AppCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                AppAvatar(
                  initial: child.parentInitial,
                  size: 38,
                  background: AppColors.background,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(child.parentName, style: AppText.title),
                      Text(
                        'Orang tua · ${child.parentPhone}',
                        style: AppText.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gapLg),
          SectionTitle('Z-Score Terakhir · ${child.lastVisit}'),
          const SizedBox(height: AppSpacing.gapSm),
          Row(
            children: [
              Expanded(
                child: ZScoreBox(
                  label: 'BB/U',
                  value: child.zWeightAge,
                  status: GrowthStatus.fromZ(child.zWeightAge),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ZScoreBox(
                  label: 'TB/U',
                  value: child.zHeightAge,
                  status: GrowthStatus.fromZ(child.zHeightAge),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ZScoreBox(
                  label: 'BB/TB',
                  value: child.zWeightHeight,
                  status: GrowthStatus.fromZ(child.zWeightHeight),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.gapMd),
          MascotStatusNote(status: child.status, childName: child.name),
          const SizedBox(height: AppSpacing.gapMd),
          AppCard(
            color: AppColors.tint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PENGUKURAN TERAKHIR',
                  style: AppText.label.copyWith(
                    fontSize: 11,
                    color: AppColors.deepOrange,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'BB ${child.weight.toStringAsFixed(1).replaceAll('.', ',')} kg · '
                  'TB ${child.height.toStringAsFixed(1).replaceAll('.', ',')} cm',
                  style: AppText.h3,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          Row(
            children: [
              if (!readOnly) ...[
                Expanded(
                  child: AppButton(
                    'Catat Kunjungan',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecordVisitPage(childName: child.name),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: AppButton.secondary(
                  'Lihat Grafik',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GrowthChartPage(
                        childName: child.name,
                        role: role,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.gapLg),
          const SectionTitle('Riwayat Singkat'),
          const SizedBox(height: AppSpacing.gapSm),
          ...child.visits.take(3).map(
                (visit) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${visit.date} · ${visit.ageMonths} bln',
                                style: AppText.title.copyWith(fontSize: 14),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'BB ${visit.weight.toStringAsFixed(1).replaceAll('.', ',')} kg · '
                                'TB ${visit.height.toStringAsFixed(1).replaceAll('.', ',')} cm',
                                style: AppText.caption,
                              ),
                            ],
                          ),
                        ),
                        StatusChip(visit.status, compact: true),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
