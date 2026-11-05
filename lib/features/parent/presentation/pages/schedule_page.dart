import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Jadwal Posyandu — jadwal berikutnya, jadwal mendatang, dan riwayat.
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final upcoming = DemoData.schedules;

    return AppScaffold(
      children: [
        const PageHeading(
          title: 'Jadwal posyandu',
          subtitle: 'Jadwal penimbangan dan penyuluhan',
        ),
        const SizedBox(height: AppSpacing.gapMd),
        _NextScheduleCard(schedule: upcoming.first),
        const SizedBox(height: AppSpacing.gapLg),
        Row(
          children: [
            Text('Jadwal mendatang', style: AppText.h3),
            const Spacer(),
            Text(
              '${upcoming.length} JADWAL',
              style: AppText.label.copyWith(
                fontSize: 10,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.gapSm),
        ...upcoming.map(
          (schedule) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _UpcomingRow(schedule: schedule),
          ),
        ),
        const SizedBox(height: AppSpacing.gapMd),
        Text('Riwayat jadwal', style: AppText.h3),
        const SizedBox(height: AppSpacing.gapSm),
        ...DemoData.pastSchedules.map(
          (schedule) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _PastRow(schedule: schedule),
          ),
        ),
      ],
    );
  }
}

/// Kartu oranye jadwal terdekat.
class _NextScheduleCard extends StatelessWidget {
  final ScheduleRecord schedule;

  const _NextScheduleCard({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.deepOrange,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'JADWAL BERIKUTNYA',
                  style: AppText.label.copyWith(
                    fontSize: 10,
                    color: const Color(0xFFFFE3CC),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _longDate(schedule.date),
                  style: AppText.h3.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_timeRange(schedule.time)}  ·  ${schedule.place}',
                  style: AppText.caption.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFFFE9D8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFE3CC),
            ),
            child: Text(
              _day(schedule.date),
              style: AppText.h2.copyWith(color: const Color(0xFF9A390B)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Baris jadwal mendatang dengan lencana tanggal.
class _UpcomingRow extends StatelessWidget {
  final ScheduleRecord schedule;

  const _UpcomingRow({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.tint,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _day(schedule.date),
                  style: AppText.title.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.deepOrange,
                    height: 1.1,
                  ),
                ),
                Text(
                  _month(schedule.date),
                  style: AppText.label.copyWith(
                    fontSize: 8,
                    color: const Color(0xFF9A390B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _longDate(schedule.date),
                  style: AppText.caption.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${_timeRange(schedule.time)}  ·  ${schedule.place}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.caption.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const _Badge(
            label: 'TERJADWAL',
            color: Color(0xFF9A390B),
            background: Color(0xFFFFE8D6),
          ),
        ],
      ),
    );
  }
}

/// Baris riwayat jadwal yang sudah berlangsung.
class _PastRow extends StatelessWidget {
  final ScheduleRecord schedule;

  const _PastRow({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: AppColors.statusNormal,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _longDate(schedule.date),
                  style: AppText.caption.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Sudah dilaksanakan',
                  style: AppText.caption.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const _Badge(
            label: 'SELESAI',
            color: AppColors.statusNormal,
            background: AppColors.statusNormalBg,
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  final Color background;

  const _Badge({
    required this.label,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        label,
        style: AppText.label.copyWith(
          fontSize: 8,
          letterSpacing: 0.3,
          color: color,
        ),
      ),
    );
  }
}

const _months = {
  'Jan': 'Januari',
  'Feb': 'Februari',
  'Mar': 'Maret',
  'Apr': 'April',
  'Mei': 'Mei',
  'Jun': 'Juni',
  'Jul': 'Juli',
  'Agu': 'Agustus',
  'Sep': 'September',
  'Okt': 'Oktober',
  'Nov': 'November',
  'Des': 'Desember',
};

String _longDate(String date) {
  final parts = date.split(' ');
  if (parts.length < 4) return date;
  return '${parts[0]} ${parts[1]} ${_months[parts[2]] ?? parts[2]} ${parts[3]}';
}

String _day(String date) {
  final parts = date.split(' ');
  return parts.length > 1 ? parts[1] : '';
}

String _month(String date) {
  final parts = date.split(' ');
  return parts.length > 2 ? parts[2].substring(0, 3).toUpperCase() : '';
}

String _timeRange(String time) => time.replaceAll('–', ' – ');
