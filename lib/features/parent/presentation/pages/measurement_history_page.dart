import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_mascot.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Riwayat Kunjungan — semua pengukuran anak dari waktu ke waktu.
class MeasurementHistoryPage extends StatelessWidget {
  final String childName;
  const MeasurementHistoryPage({super.key, this.childName = 'Aisyah Putri'});

  @override
  Widget build(BuildContext context) {
    final child = DemoData.byName(childName);
    final visits = child.visits;
    final firstName = child.name.split(' ').first;
    final latestGain =
        visits.length > 1 ? visits.first.weight - visits[1].weight : 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarHeader(title: 'Riwayat Kunjungan'),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          AppCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                AppAvatar(initial: child.initial),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(child.name, style: AppText.title),
                      Text(
                        '${child.gender} · ${child.ageMonths} bulan',
                        style: AppText.caption,
                      ),
                    ],
                  ),
                ),
                StatusChip(child.status, compact: true),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          MascotSpeech(
            mood: latestGain > 0 ? MascotMood.normal : MascotMood.greeting,
            message: latestGain > 0
                ? '$firstName naik '
                    '${latestGain.toStringAsFixed(1).replaceAll('.', ',')} kg '
                    'sejak kunjungan terakhir. Pertahankan, ya!'
                : 'Yuk pantau pertumbuhan $firstName dengan kunjungan rutin '
                    'ke posyandu.',
          ),
          const SizedBox(height: AppSpacing.gapMd),
          ...List.generate(visits.length, (i) {
            final v = visits[i];
            final gain = i + 1 < visits.length ? v.weight - visits[i + 1].weight : 0.0;
            final mood = gain > 0
                ? MascotMood.normal
                : (gain < 0 ? MascotMood.attention : MascotMood.greeting);
            final mascot = AppMascot(
              mood: mood,
              size: 36,
              semanticLabel: gain > 0
                  ? 'Maskot ceria, berat badan naik'
                  : gain < 0
                      ? 'Maskot sedih, berat badan turun'
                      : 'Maskot memantau pertumbuhan',
            );
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  if (i.isEven) ...[
                    mascot,
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: AppCard(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${v.date} · ${v.ageMonths} bln',
                                  style: AppText.title.copyWith(fontSize: 14),
                                ),
                              ),
                              StatusChip(v.status, compact: true),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'BB ${v.weight.toStringAsFixed(1).replaceAll('.', ',')} kg · '
                            'TB ${v.height.toStringAsFixed(1).replaceAll('.', ',')} cm'
                            '${gain > 0 ? ' · naik ${gain.toStringAsFixed(1).replaceAll('.', ',')} kg' : ''}',
                            style: AppText.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (i.isOdd) ...[
                    const SizedBox(width: 6),
                    mascot,
                  ],
                ],
              ),
            );
          }),
          const SizedBox(height: AppSpacing.gapXs),
          InfoNote(
            '${child.name.split(' ').first} tercatat ${visits.length} kali kunjungan '
            'dalam ${visits.length} bulan terakhir. Kunjungan berikutnya: '
            '${DemoData.nextSchedule}.',
          ),
        ],
      ),
    );
  }
}
