import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Baca Artikel — sampul, penulis, isi bacaan, dan tips praktis.
class ArticleDetailPage extends StatelessWidget {
  final ArticleRecord article;
  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final paragraphs = article.body
        .split('\n\n')
        .map((paragraph) => paragraph.trim())
        .where((paragraph) =>
            paragraph.isNotEmpty && paragraph != article.excerpt.trim())
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarHeader(title: 'Artikel'),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          _Cover(article: article),
          const SizedBox(height: AppSpacing.gapMd),
          Text(
            '${article.category.toUpperCase()}  ·  '
            '${article.readMinutes} MENIT BACA',
            style: AppText.label.copyWith(
              fontSize: 9,
              color: AppColors.deepOrange,
            ),
          ),
          const SizedBox(height: 6),
          Text(article.title, style: AppText.h1.copyWith(fontSize: 22)),
          const SizedBox(height: AppSpacing.gapMd),
          _AuthorCard(article: article),
          const SizedBox(height: AppSpacing.gapMd),
          Text(
            article.excerpt,
            style: AppText.bodySm.copyWith(
              fontSize: 13,
              height: 1.65,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          Container(
            width: 42,
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          ...paragraphs.map(
            (paragraph) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                paragraph,
                style: AppText.bodySm.copyWith(
                  fontSize: 13,
                  height: 1.7,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          if (article.tips.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.gapXs),
            Text('Pilihan yang mudah disajikan', style: AppText.h3),
            const SizedBox(height: AppSpacing.gapSm),
            ...List.generate(
              article.tips.length,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.tint,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${i + 1}',
                        style: AppText.label.copyWith(
                          fontSize: 9,
                          color: AppColors.deepOrange,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        article.tips[i],
                        style: AppText.caption.copyWith(
                          fontSize: 11,
                          height: 1.55,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.gapSm),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.tint,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg - 2),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              'Sesuaikan tekstur dan porsi dengan usia anak. Bila ada pantangan '
              'atau keluhan, konsultasikan kepada bidan.',
              style: AppText.caption.copyWith(
                fontSize: 11,
                height: 1.55,
                fontWeight: FontWeight.w500,
                color: AppColors.deepOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  final ArticleRecord article;

  const _Cover({required this.article});

  @override
  Widget build(BuildContext context) {
    final cover = article.banner ?? article.image;

    return Container(
      height: 180,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFF8C48F),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Stack(
        children: [
          if (cover == null)
            const Positioned(right: -6, top: 18, child: _Plate(size: 108))
          else ...[
            Positioned.fill(
              child: Image.asset(
                cover,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                cacheWidth: 720,
                filterQuality: FilterQuality.medium,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 88,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.22),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
          Positioned(
            left: 16,
            top: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
              ),
              child: Text(
                article.category.toUpperCase(),
                style: AppText.label.copyWith(
                  fontSize: 8,
                  color: AppColors.deepOrange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Plate extends StatelessWidget {
  final double size;

  const _Plate({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFF7ED),
              shape: BoxShape.circle,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: size * 0.56,
              height: size * 0.56,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: size * 0.29,
            top: size * 0.33,
            child: Container(
              width: size * 0.15,
              height: size * 0.15,
              decoration: const BoxDecoration(
                color: Color(0xFF60A56B),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: size * 0.31,
            bottom: size * 0.29,
            child: Container(
              width: size * 0.12,
              height: size * 0.12,
              decoration: const BoxDecoration(
                color: Color(0xFFF8D477),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: size * 0.36,
            top: size * 0.27,
            child: Container(
              width: size * 0.1,
              height: size * 0.1,
              decoration: const BoxDecoration(
                color: AppColors.deepOrange,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthorCard extends StatelessWidget {
  final ArticleRecord article;

  const _AuthorCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const AppAvatar(initial: 'R', size: 38),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bidan Ratna Sari',
                  style: AppText.caption.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${article.date}  ·  ${article.readMinutes} menit baca',
                  style: AppText.caption.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
