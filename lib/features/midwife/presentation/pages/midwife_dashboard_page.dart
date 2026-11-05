import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/models/user_role.dart';
import '../../../../features/shared/presentation/pages/notifications_page.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_mascot.dart';
import '../../../../core/widgets/app_widgets.dart';
import 'add_article_page.dart';
import 'posyandu_list_page.dart';

/// Beranda Bidan â€” ringkasan lintas posyandu & balita perlu pantauan.
class MidwifeDashboardPage extends StatelessWidget {
  final void Function(int)? onTabChange;
  const MidwifeDashboardPage({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      children: [
        PageHeading(
          title: 'Halo, ${UserRole.bidan.firstName}',
          subtitle: UserRole.bidan.unitLabel,
          leading: const AppAvatar(initial: 'R', size: 44),
          mascot: const AppMascot(size: 56),
          action: IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsPage()),
            ),
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifikasi',
          ),
        ),
        const SizedBox(height: AppSpacing.gapLg),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: StatTile(value: '3', label: 'Posyandu')),
              SizedBox(width: 10),
              Expanded(child: StatTile(value: '128', label: 'Balita')),
              SizedBox(width: 10),
              Expanded(
                child: StatTile(
                  value: '6',
                  label: 'Perlu pantauan',
                  valueColor: AppColors.danger,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.gapLg),
        SectionTitle(
          'Balita Perlu Pemantauan',
          actionLabel: 'Lihat semua',
          onAction: () => onTabChange?.call(1),
        ),
        const SizedBox(height: AppSpacing.gapSm),
        ...DemoData.needAttention.take(3).map(
              (child) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ChildTile(
                  name: child.name,
                  meta: '${child.posyandu} Â· BB/U '
                      '${child.zWeightAge.toStringAsFixed(1).replaceAll('.', ',')}',
                  status: child.status,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/child-detail',
                    arguments: child.name,
                  ),
                ),
              ),
            ),
        const SizedBox(height: AppSpacing.gapXs),
        SectionTitle(
          'Posyandu Binaan',
          actionLabel: 'Kelola',
          onAction: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PosyanduListPage()),
          ),
        ),
        const SizedBox(height: AppSpacing.gapSm),
        ...DemoData.posyandu.take(2).map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppCard(
                  padding: const EdgeInsets.all(14),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PosyanduListPage()),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.tint,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.location_on_outlined,
                            size: 20, color: AppColors.deepOrange),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.name, style: AppText.title),
                            const SizedBox(height: 2),
                            Text(
                              '${p.children} balita Â· ${p.cadres} kader',
                              style: AppText.caption,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${p.needAttention} perlu',
                        style: AppText.caption.copyWith(
                          color: AppColors.deepOrange,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        const SizedBox(height: AppSpacing.gapXs),
        SectionTitle(
          'Artikel Edukasi',
          actionLabel: 'Semua',
          onAction: () => onTabChange?.call(2),
        ),
        const SizedBox(height: AppSpacing.gapSm),
        AppCard(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DemoData.articles.first.title, style: AppText.title),
              const SizedBox(height: 4),
              Text(
                'Terbit Â· ${DemoData.articles.first.date} Â· dibaca '
                '${DemoData.articles.first.readers} orang tua',
                style: AppText.caption,
              ),
              const SizedBox(height: AppSpacing.gapSm),
              AppButton.secondary(
                'Tulis Artikel Baru',
                icon: Icons.add_rounded,
                expanded: true,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddArticlePage()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
