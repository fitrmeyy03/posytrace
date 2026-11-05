import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';
import 'article_detail_page.dart';

/// Daftar Artikel — edukasi dari bidan, bisa dicari dan disaring kategori.
class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  int _filter = 0;
  final _searchController = TextEditingController();
  static const _filters = ['Semua', 'Gizi', 'PMT', 'Imunisasi'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _open(ArticleRecord article) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ArticleDetailPage(article: article)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final articles = DemoData.articles.where((article) {
      if (!article.published) return false;
      if (_filter != 0 && article.category != _filters[_filter]) return false;
      if (query.isEmpty) return true;
      return article.title.toLowerCase().contains(query) ||
          article.excerpt.toLowerCase().contains(query);
    }).toList();

    return AppScaffold(
      children: [
        const PageHeading(
          title: 'Artikel edukasi',
          subtitle: 'Panduan praktis untuk tumbuh kembang anak',
        ),
        const SizedBox(height: AppSpacing.gapMd),
        _SearchField(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacing.gapSm),
        FilterChips(
          labels: _filters,
          index: _filter,
          onChanged: (i) => setState(() => _filter = i),
        ),
        const SizedBox(height: AppSpacing.gapMd),
        if (articles.isEmpty)
          const InfoNote(
            'Belum ada artikel untuk pencarian ini. Coba kata kunci atau '
            'kategori lain.',
            tinted: true,
          )
        else ...[
          _FeaturedCard(
            article: articles.first,
            onTap: () => _open(articles.first),
          ),
          if (articles.length > 1) ...[
            const SizedBox(height: AppSpacing.gapMd),
            SectionTitle(
              'Pilihan untuk keluarga',
              actionLabel: 'Lihat semua  ›',
              onAction: () {
                _searchController.clear();
                setState(() => _filter = 0);
              },
            ),
            const SizedBox(height: AppSpacing.gapSm),
            ...articles.skip(1).map(
                  (article) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _ArticleRow(
                      article: article,
                      onTap: () => _open(article),
                    ),
                  ),
                ),
          ],
        ],
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.segmentTrack,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppText.caption.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Cari topik gizi, MP-ASI...',
                hintStyle: AppText.caption.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final ArticleRecord article;
  final VoidCallback onTap;

  const _FeaturedCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cover = article.banner ?? article.image;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.tint,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 180,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    cover == null
                        ? const ColoredBox(color: Color(0xFFF8C48F))
                        : Image.asset(
                            cover,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            cacheWidth: 720,
                            filterQuality: FilterQuality.medium,
                            errorBuilder: (_, _, _) => const ColoredBox(
                              color: Color(0xFFF8C48F),
                            ),
                          ),
                    if (cover == null)
                      const Positioned(
                        right: 40,
                        top: 9,
                        child: _Plate(size: 78),
                      ),
                    if (cover != null)
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        height: 76,
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
                    Positioned(
                      left: 18,
                      top: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusPill,
                          ),
                        ),
                        child: Text(
                          'PILIHAN BIDAN',
                          style: AppText.label.copyWith(
                            fontSize: 9,
                            color: AppColors.deepOrange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${article.category.toUpperCase()}  ·  '
                      '${article.readMinutes} MENIT BACA',
                      style: AppText.label.copyWith(
                        fontSize: 9,
                        color: AppColors.deepOrange,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.h3.copyWith(fontSize: 17),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Bidan Ratna  ·  ${article.date}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.caption.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _ReadButton(onTap: onTap),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReadButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ReadButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryDark,
      borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          child: Text(
            'Baca  ›',
            style: AppText.label.copyWith(
              fontSize: 10,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _ArticleRow extends StatelessWidget {
  final ArticleRecord article;
  final VoidCallback onTap;

  const _ArticleRow({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final (color, icon) = _visualFor(article.category);
    final thumb = article.image ?? article.banner;

    return AppCard(
      padding: const EdgeInsets.all(12),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.border),
            ),
            child: SizedBox(
              width: 62,
              height: 62,
              child: thumb == null
                  ? ColoredBox(
                      color: color,
                      child: Icon(icon, color: AppColors.white, size: 26),
                    )
                  : Image.asset(
                      thumb,
                      fit: BoxFit.cover,
                      cacheWidth: 160,
                      errorBuilder: (_, _, _) => ColoredBox(
                        color: color,
                        child: Icon(icon, color: AppColors.white, size: 26),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.category.toUpperCase(),
                  style: AppText.label.copyWith(
                    fontSize: 9,
                    color: AppColors.deepOrange,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.caption.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bidan Ratna  ·  ${article.readMinutes} menit',
                  style: AppText.caption.copyWith(fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Piring ilustrasi pada sampul artikel unggulan.
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
        ],
      ),
    );
  }
}

(Color, IconData) _visualFor(String category) {
  return switch (category) {
    'Gizi' => (const Color(0xFFE99A62), Icons.restaurant_rounded),
    'PMT' => (const Color(0xFFE7B94F), Icons.rice_bowl_rounded),
    'Stimulasi' => (const Color(0xFF77A77D), Icons.child_care_rounded),
    'Imunisasi' => (const Color(0xFFB08968), Icons.vaccines_rounded),
    _ => (AppColors.softOrange, Icons.menu_book_rounded),
  };
}
