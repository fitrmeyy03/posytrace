import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/models/user_role.dart';
import '../../../../core/shared/pages/notifications_page.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_mascot.dart';
import '../../../../core/widgets/app_widgets.dart';
import 'record_visit_page.dart';

/// Beranda Kader — jadwal hari ini, ringkasan, balita perlu perhatian.
class KaderDashboardPage extends StatelessWidget {
  final void Function(int)? onTabChange;

  const KaderDashboardPage({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      fab: AppFab(
        semanticsLabel: 'Mulai pencatatan kunjungan',
        onTap: () => _startVisit(context),
      ),
      children: [
        PageHeading(
          title: 'Halo, ${UserRole.kader.firstName}',
          subtitle: UserRole.kader.unitLabel,
          leading: const AppAvatar(initial: 'S', size: 44),
          mascot: const AppMascot(size: 56),
          action: _NotificationBell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsPage()),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.gapLg),
        HeroCard(
          label: 'Posyandu hari ini',
          title: DemoData.today,
          subtitle: '${DemoData.posyanduAddress} · 08.00–11.00',
          action: HeroOutlinedButton(
            'Mulai Pencatatan',
            onPressed: () => _startVisit(context),
          ),
        ),
        const SizedBox(height: AppSpacing.gapMd),
        const Row(
          children: [
            Expanded(
              child: StatTile(value: '48', label: 'Balita terdaftar'),
            ),
            SizedBox(width: 12),
            Expanded(
              child: StatTile(value: '36', label: 'Kunjungan bulan ini'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.gapLg),
        const SectionTitle('Perlu Perhatian'),
        const SizedBox(height: AppSpacing.gapSm),
        ...DemoData.needAttention.take(3).map(
              (child) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ChildTile(
                  name: child.name,
                  meta: '${child.ageMonths} bulan · BB/U '
                      '${child.zWeightAge.toStringAsFixed(1).replaceAll('.', ',')}',
                  status: child.status,
                  onTap: () => _openChild(context, child.name),
                ),
              ),
            ),
        const SizedBox(height: AppSpacing.gapXs),
        const SectionTitle('Terakhir Dicatat', actionLabel: 'Lihat semua'),
        const SizedBox(height: AppSpacing.gapSm),
        ...DemoData.children.take(2).map(
              (child) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ChildTile(
                  name: child.name,
                  meta: '${child.gender} · ${child.ageMonths} bulan',
                  status: child.status,
                  onTap: () => _openChild(context, child.name),
                ),
              ),
            ),
      ],
    );
  }

  void _startVisit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RecordVisitPage()),
    );
  }

  void _openChild(BuildContext context, String name) {
    Navigator.pushNamed(context, '/child-detail', arguments: name);
  }
}

class _NotificationBell extends StatelessWidget {
  final VoidCallback onTap;
  const _NotificationBell({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.notifications_none_rounded, size: 24),
          tooltip: 'Notifikasi',
        ),
        Positioned(
          right: 10,
          top: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
