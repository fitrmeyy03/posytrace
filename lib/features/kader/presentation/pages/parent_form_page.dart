import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Tambah Orang Tua & Bind Balita — satu form untuk akun + anaknya.
class ParentFormPage extends StatefulWidget {
  const ParentFormPage({super.key});

  @override
  State<ParentFormPage> createState() => _ParentFormPageState();
}

class _ParentFormPageState extends State<ParentFormPage> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _childName = TextEditingController();
  final _birth = TextEditingController();
  int _gender = 0;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _childName.dispose();
    _birth.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2024, 10, 12),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (picked == null) return;
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    setState(() {
      _birth.text = '${picked.day} ${months[picked.month - 1]} ${picked.year}';
    });
  }

  void _save() {
    if (_name.text.trim().isEmpty ||
        _phone.text.trim().isEmpty ||
        _childName.text.trim().isEmpty ||
        _birth.text.isEmpty) {
      setState(() =>
          _error = 'Lengkapi nama, nomor HP, nama balita, dan tanggal lahir.');
      return;
    }
    setState(() => _error = null);
    showAppSnackBar(context, 'Akun orang tua dibuat & balita terhubung.');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarHeader(title: 'Tambah Orang Tua'),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          Text(
            'DATA ORANG TUA',
            style: AppText.label.copyWith(color: AppColors.deepOrange),
          ),
          const SizedBox(height: AppSpacing.gapSm),
          AppTextField(
            label: 'Nama Orang Tua',
            hint: 'Contoh: Ibu Dewi Lestari',
            controller: _name,
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: AppSpacing.gapMd),
          AppTextField(
            label: 'Nomor HP (untuk login)',
            hint: 'Contoh: 0812 3456 7890',
            controller: _phone,
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppSpacing.gapSm),
          const InfoNote(
            'Kata sandi sementara dibuat otomatis: posy2026 — wajib diganti saat login pertama.',
          ),
          const SizedBox(height: AppSpacing.gapLg),
          Text(
            'DATA BALITA — DIHUBUNGKAN (BIND)',
            style: AppText.label.copyWith(color: AppColors.deepOrange),
          ),
          const SizedBox(height: AppSpacing.gapSm),
          AppTextField(
            label: 'Nama Balita',
            hint: 'Contoh: Aisyah Putri',
            controller: _childName,
            icon: Icons.child_care_outlined,
          ),
          const SizedBox(height: AppSpacing.gapMd),
          FieldLabel('Tanggal Lahir'),
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            child: Container(
              height: AppSpacing.touch,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: AppColors.border, width: 1.2),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      size: 18, color: AppColors.primary),
                  const SizedBox(width: 10),
                  Text(
                    _birth.text.isEmpty ? 'Pilih tanggal' : _birth.text,
                    style: _birth.text.isEmpty
                        ? AppText.bodySm.copyWith(color: AppColors.textMuted)
                        : AppText.bodySm,
                  ),
                  const Spacer(),
                  const Icon(Icons.expand_more_rounded,
                      color: AppColors.textMuted),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          FieldLabel('Jenis Kelamin'),
          SegmentTabs(
            labels: const ['Perempuan', 'Laki-laki'],
            index: _gender,
            onChanged: (i) => setState(() => _gender = i),
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.gapSm),
            Text(
              _error!,
              style: AppText.caption.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: AppSpacing.gapLg),
          AppButton('Simpan & Hubungkan', expanded: true, onPressed: _save),
        ],
      ),
    );
  }
}
