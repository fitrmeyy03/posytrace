import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Detail Orang Tua — anak terhubung & reset kata sandi.
class ParentDetailPage extends StatelessWidget {
  final ParentRecord parent;
  const ParentDetailPage({super.key, required this.parent});

  @override
  Widget build(BuildContext context) {
    final children = DemoData.children
        .where((c) => c.parentName == parent.name)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarHeader(title: 'Detail Orang Tua'),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          AppCard(
            child: Row(
              children: [
                AppAvatar(initial: parent.initial, size: 56),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(parent.name, style: AppText.h2),
                      const SizedBox(height: 2),
                      Text(parent.phone, style: AppText.caption),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.tint,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusPill),
                  ),
                  child: Text(
                    '${parent.childCount} anak',
                    style: AppText.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepOrange,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gapLg),
          const SectionTitle('Balita Terhubung'),
          const SizedBox(height: AppSpacing.gapSm),
          ...children.map(
            (child) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ChildTile(
                name: child.name,
                meta: '${child.ageMonths} bulan',
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
          AppButton.secondary(
            'Hubungkan Balita Lain',
            icon: Icons.add_rounded,
            expanded: true,
            onPressed: () => showAppSnackBar(
              context,
              'Pilih balita yang akan dihubungkan.',
            ),
          ),
          const SizedBox(height: AppSpacing.gapLg),
          const SectionTitle('Keamanan Akun'),
          const SizedBox(height: AppSpacing.gapSm),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Orang tua lupa kata sandi? Buat kata sandi sementara baru dan sampaikan langsung kepadanya.',
                  style: AppText.caption.copyWith(height: 1.6),
                ),
                const SizedBox(height: AppSpacing.gapSm),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  runSpacing: 2,
                  children: [
                    Text('Kata sandi sementara baru:',
                        style: AppText.caption),
                    Text(
                      'posy2026',
                      style: AppText.title.copyWith(
                        color: AppColors.deepOrange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.gapMd),
                AppButton(
                  'Reset Kata Sandi',
                  variant: AppButtonVariant.danger,
                  expanded: true,
                  onPressed: () => showAppSnackBar(
                    context,
                    'Kata sandi ${parent.name} direset ke posy2026.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
