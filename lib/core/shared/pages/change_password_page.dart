import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../theme/app_layout.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

/// Ganti Kata Sandi — wajib saat pertama masuk dengan kata sandi sementara.
class ChangePasswordPage extends StatefulWidget {
  final bool firstLogin;
  const ChangePasswordPage({super.key, this.firstLogin = false});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _old = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _old.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _save() {
    if (_new.text.length < 6) {
      setState(() => _error = 'Kata sandi baru minimal 6 karakter.');
      return;
    }
    if (_new.text != _confirm.text) {
      setState(() => _error = 'Konfirmasi kata sandi belum sama.');
      return;
    }
    setState(() => _error = null);
    showAppSnackBar(context, 'Kata sandi baru tersimpan.');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarHeader(
        title: widget.firstLogin ? 'Ganti Kata Sandi' : 'Ganti Kata Sandi',
      ),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          Text(
            widget.firstLogin
                ? 'Anda masuk dengan kata sandi sementara dari kader. Buat kata sandi baru untuk melanjutkan.'
                : 'Buat kata sandi baru yang mudah Anda ingat.',
            style: AppText.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.gapLg),
          AppTextField(
            label: 'Kata Sandi Sementara',
            hint: '••••••••',
            icon: Icons.lock_outline_rounded,
            obscure: true,
            controller: _old,
          ),
          const SizedBox(height: AppSpacing.gapMd),
          AppTextField(
            label: 'Kata Sandi Baru',
            hint: '••••••••••',
            icon: Icons.lock_reset_rounded,
            obscure: true,
            controller: _new,
          ),
          const SizedBox(height: AppSpacing.gapMd),
          AppTextField(
            label: 'Konfirmasi Kata Sandi Baru',
            hint: '••••••••••',
            icon: Icons.lock_reset_rounded,
            obscure: true,
            controller: _confirm,
          ),
          const SizedBox(height: AppSpacing.gapSm),
          Text(
            'Minimal 6 karakter. Gunakan kata sandi yang mudah Anda ingat.',
            style: AppText.caption,
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.gapXs),
            Text(
              _error!,
              style: AppText.caption.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: AppSpacing.gapLg),
          AppButton(
            'Simpan Kata Sandi Baru',
            expanded: true,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}
