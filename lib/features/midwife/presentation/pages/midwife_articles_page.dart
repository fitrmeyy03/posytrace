import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';
import 'add_article_page.dart';

/// Artikel Saya — artikel terbit & draf beserta jumlah pembaca.
class MidwifeArticlesPage extends StatelessWidget {
  const MidwifeArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      children: [
        PageHeading(
          title: 'Artikel Saya',
          action: TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddArticlePage()),
            ),
            child: const Text('+ Tulis'),
          ),
        ),
        const SizedBox(height: AppSpacing.gapMd),
        ...DemoData.articles.map(
          (article) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AppCard(
              padding: const EdgeInsets.all(14),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddArticlePage()),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(article.title, style: AppText.title),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _StatusTag(published: article.published),
                            const SizedBox(width: 8),
                            Text(
                              article.published
                                  ? '${article.date} · dibaca ${article.readers}'
                                  : article.date,
                              style: AppText.caption,
                            ),
                          ],
                        ),
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
        const SizedBox(height: AppSpacing.gapXs),
        const InfoNote(
          'Artikel terbit langsung muncul di beranda orang tua dan terkirim sebagai notifikasi.',
        ),
      ],
    );
  }
}

class _StatusTag extends StatelessWidget {
  final bool published;
  const _StatusTag({required this.published});

  @override
  Widget build(BuildContext context) {
    final color =
        published ? AppColors.statusNormal : AppColors.statusUnder;
    final bg = published
        ? AppColors.statusNormalBg
        : AppColors.statusUnderBg;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Text(
        published ? 'Terbit' : 'Draf',
        style: AppText.caption.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
