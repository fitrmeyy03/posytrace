import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/models/growth_status.dart';
import '../../../../core/models/user_role.dart';
import '../../../../features/shared/presentation/pages/growth_chart_page.dart';
import '../../../../features/shared/presentation/pages/notifications_page.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_mascot.dart';
import '../../../../core/widgets/app_widgets.dart';
import 'measurement_history_page.dart';

/// Beranda Orang Tua â€” kartu anak digeser seperti kartu bank.
class DashboardPage extends StatefulWidget {
  final void Function(int)? onTabChange;
  const DashboardPage({super.key, this.onTabChange});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PageController _controller = PageController(viewportFraction: 0.96);
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openHistory(String childName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MeasurementHistoryPage(childName: childName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = DemoData.dewiChildren;
    final child = children[_index.clamp(0, children.length - 1)];

    return AppScaffold(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'PosyTrace',
                style: AppText.h2.copyWith(color: AppColors.deepOrange),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsPage()),
              ),
              icon: const Icon(Icons.notifications_none_rounded, size: 24),
              color: AppColors.textPrimary,
              tooltip: 'Notifikasi',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.gapXs),
        Text(
          'Halo, ${UserRole.parent.firstName}',
          style: AppText.h1.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 2),
        Text('Pantau tumbuh kembang anak Anda', style: AppText.caption),
        const SizedBox(height: AppSpacing.gapMd),
        Row(
          children: [
            Text(
              'ANAK SAYA',
              style: AppText.label.copyWith(fontSize: 10),
            ),
            const Spacer(),
            Text(
              '${children.length} ANAK  Â·  GESER',
              style: AppText.label.copyWith(
                fontSize: 10,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.gapSm),
        SizedBox(
          height: 226,
          child: PageView.builder(
            controller: _controller,
            padEnds: false,
            itemCount: children.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(right: 14),
              child: _ChildCard(
                child: children[i],
                onChart: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GrowthChartPage(
                      childName: children[i].name,
                      role: UserRole.parent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.gapSm),
        Text(
          'â€¹   Geser kartu untuk melihat anak berikutnya   â€º',
          textAlign: TextAlign.center,
          style: AppText.caption.copyWith(fontSize: 11),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < children.length; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == _index ? AppColors.primary : AppColors.border,
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.gapMd),
        const _ScheduleCard(),
        const SizedBox(height: AppSpacing.gapMd),
        SectionTitle(
          'Kunjungan terakhir',
          actionLabel: 'Lihat riwayat  â€º',
          onAction: () => _openHistory(child.name),
        ),
        const SizedBox(height: AppSpacing.gapXs),
        AppCard(
          padding: const EdgeInsets.all(14),
          onTap: () => _openHistory(child.name),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${child.lastVisit}  Â·  ${child.ageLabel}',
                      style: AppText.caption.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'BB ${_num(child.weight)} kg   Â·   '
                      'TB ${_num(child.height)} cm',
                      style: AppText.caption.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (child.weightGain > 0)
                Text(
                  'â†‘ ${_num(child.weightGain)} kg',
                  style: AppText.caption.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.statusNormal,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

String _num(double value) => value.toStringAsFixed(1).replaceAll('.', ',');

/// Kartu anak â€” header oranye dengan maskot, diikuti ringkasan BB/TB.
class _ChildCard extends StatelessWidget {
  final ChildRecord child;
  final VoidCallback onChart;

  const _ChildCard({required this.child, required this.onChart});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg + 2),
        border: Border.all(color: AppColors.border),
        boxShadow: [AppColors.cardShadow],
      ),
      child: Column(
        children: [
          Container(
            height: 78,
            color: AppColors.primaryDark,
            padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        child.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.h3.copyWith(
                          color: AppColors.white,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${child.gender}  Â·  ${child.ageLabel}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.caption.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFFFE7D5),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _StatusBadge(child.status),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const AppMascot(size: 54),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _Metric(
                        value: _num(child.weight),
                        unit: 'kg',
                        label: 'BERAT BADAN',
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _Metric(
                        value: _num(child.height),
                        unit: 'cm',
                        label: 'TINGGI BADAN',
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _Metric(
                        value: child.lastVisit.split(' ').take(2).join(' '),
                        unit: '',
                        label: 'KUNJUNGAN',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _ChartButton(onPressed: onChart),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final GrowthStatus status;

  const _StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE8D6),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        'GIZI ${status.shortLabel.toUpperCase()}',
        style: AppText.label.copyWith(
          fontSize: 8,
          letterSpacing: 0.3,
          color: const Color(0xFF9A390B),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String value;
  final String unit;
  final String label;

  const _Metric({required this.value, required this.unit, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.subtle,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm + 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: AppText.title.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (unit.isNotEmpty) ...[
                  const SizedBox(width: 2),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Text(
                      unit,
                      style: AppText.caption.copyWith(fontSize: 10),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.label.copyWith(
              fontSize: 8,
              letterSpacing: 0.2,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ChartButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryDark,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm + 1),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm + 1),
        child: SizedBox(
          height: 38,
          child: Center(
            child: Text(
              'Lihat grafik pertumbuhan  â€º',
              style: AppText.button.copyWith(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}

/// Kartu jadwal posyandu berikutnya.
class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard();

  @override
  Widget build(BuildContext context) {
    final parts = DemoData.nextSchedule.split(' ');
    final day = parts.length > 1 ? parts[1] : '';

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
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
                  'KUNJUNGAN BERIKUTNYA',
                  style: AppText.label.copyWith(
                    fontSize: 10,
                    color: const Color(0xFFFFE3CC),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DemoData.nextSchedule,
                  style: AppText.h3.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  DemoData.posyanduAddress,
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withValues(alpha: 0.18),
            ),
            child: Text(
              day,
              style: AppText.h2.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
