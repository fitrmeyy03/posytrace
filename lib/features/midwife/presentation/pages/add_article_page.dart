import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Tulis / Edit Artikel — judul, kategori, sampul, isi.
class AddArticlePage extends StatefulWidget {
  const AddArticlePage({super.key});

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  final _title = TextEditingController(
    text: 'Tips Menyiapkan PMT dari Bahan Lokal',
  );
  final _body = TextEditingController(
    text:
        'Bahan lokal seperti telur, ikan lele, tempe, dan daun kelor adalah sumber gizi yang terjangkau dan mudah didapat di sekitar kita…',
  );
  final _categories = ['PMT', 'Gizi', 'Stimulasi', 'Imunisasi'];
  int _category = 0;
  String? _error;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  void _publish({required bool draft}) {
    if (_title.text.trim().isEmpty) {
      setState(() => _error = 'Judul artikel wajib diisi.');
      return;
    }
    setState(() => _error = null);
    showAppSnackBar(
      context,
      draft
          ? 'Draf tersimpan.'
          : 'Artikel terbit & notifikasi terkirim ke orang tua.',
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarHeader(
        title: 'Tulis Artikel',
        action: TextButton(
          onPressed: () => _publish(draft: false),
          child: const Text('Terbitkan'),
        ),
      ),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          AppTextField(
            label: 'Judul Artikel',
            controller: _title,
            hint: 'Judul yang jelas dan singkat',
          ),
          const SizedBox(height: AppSpacing.gapMd),
          const FieldLabel('Kategori'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_categories.length, (i) {
              final active = i == _category;
              return GestureDetector(
                onTap: () => setState(() => _category = i),
                child: Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: active ? AppColors.tint : AppColors.surface,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusPill),
                    border: Border.all(
                      color: active ? AppColors.tint : AppColors.border,
                    ),
                  ),
                  child: Center(
                    widthFactor: 1,
                    child: Text(
                      _categories[i],
                      style: AppText.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: active
                            ? AppColors.deepOrange
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          const FieldLabel('Gambar Sampul'),
          InkWell(
            onTap: () => showAppSnackBar(
              context,
              'Pemilih gambar dibuka (demo).',
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            child: Container(
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.tint.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(
                  color: AppColors.softOrange,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image_outlined,
                      color: AppColors.deepOrange, size: 24),
                  const SizedBox(height: 6),
                  Text(
                    'Tambah gambar sampul',
                    style: AppText.caption.copyWith(
                      color: AppColors.deepOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          const FieldLabel('Isi Artikel'),
          TextField(
            controller: _body,
            maxLines: 8,
            style: AppText.bodySm,
            decoration: const InputDecoration(
              hintText: 'Tulis isi artikel edukasi…',
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.gapXs),
            Text(
              _error!,
              style: AppText.caption.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: AppSpacing.gapLg),
          Row(
            children: [
              Expanded(
                child: AppButton.secondary(
                  'Simpan Draf',
                  onPressed: () => _publish(draft: true),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppButton(
                  'Terbitkan Artikel',
                  onPressed: () => _publish(draft: false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
