import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Jadwal Posyandu — kelola jadwal & kirim pengingat ke orang tua.
class KaderSchedulePage extends StatelessWidget {
  const KaderSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      children: [
        const PageHeading(title: 'Jadwal Posyandu'),
        const SizedBox(height: AppSpacing.gapLg),
        HeroCard(
          label: 'Posyandu berikutnya',
          title: DemoData.nextSchedule,
          subtitle: '${DemoData.posyanduAddress} · 08.00–11.00',
          action: HeroOutlinedButton(
            'Kirim Pengingat ke Orang Tua',
            onPressed: () => showAppSnackBar(
              context,
              'Pengingat dikirim ke 48 orang tua.',
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.gapLg),
        const SectionTitle('Jadwal Berikutnya'),
        const SizedBox(height: AppSpacing.gapSm),
        ...DemoData.schedules.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AppCard(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.tint,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.event_available_rounded,
                        size: 20, color: AppColors.deepOrange),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.title, style: AppText.title),
                        const SizedBox(height: 2),
                        Text(
                          '${s.date} · ${s.time}',
                          style: AppText.caption,
                        ),
                        Text(s.place, style: AppText.caption),
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
        AppButton(
          'Buat Jadwal Baru',
          icon: Icons.add_rounded,
          variant: AppButtonVariant.secondary,
          expanded: true,
          onPressed: () => showAppSnackBar(
            context,
            'Form jadwal baru belum tersedia di demo.',
          ),
        ),
      ],
    );
  }
}
