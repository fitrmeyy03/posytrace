import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/demo_data.dart';
import '../../models/user_role.dart';
import '../../theme/app_layout.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';
import 'change_password_page.dart';

/// Profil — data akun, unit terikat, ganti kata sandi, keluar.
class ProfilePage extends StatelessWidget {
  final UserRole role;
  const ProfilePage({super.key, this.role = UserRole.parent});

  @override
  Widget build(BuildContext context) {
    final children = switch (role) {
      UserRole.parent => DemoData.dewiChildren,
      _ => const <ChildRecord>[],
    };

    return AppScaffold(
      children: [
        const PageHeading(title: 'Profil'),
        const SizedBox(height: AppSpacing.gapLg),
        AppCard(
          child: Column(
            children: [
              Row(
                children: [
                  AppAvatar(initial: role.initial, size: 60),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(role.fullName, style: AppText.h2),
                        const SizedBox(height: 2),
                        Text(role.label, style: AppText.caption.copyWith(
                          color: AppColors.deepOrange,
                          fontWeight: FontWeight.w600,
                        )),
                        Text(
                          '${role.unit} · ${role.phone}',
                          style: AppText.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (children.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.gapMd),
                Row(
                  children: [
                    Text('Anak terhubung:', style: AppText.caption),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: children
                            .map((c) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.tint,
                                    borderRadius: BorderRadius.circular(
                                        AppSpacing.radiusPill),
                                  ),
                                  child: Text(
                                    c.name.split(' ').first,
                                    style: AppText.caption.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.deepOrange,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.gapLg),
        _MenuTile(
          icon: Icons.edit_outlined,
          title: 'Edit Profil',
          onTap: () => showAppSnackBar(context, 'Form edit profil dibuka.'),
        ),
        _MenuTile(
          icon: Icons.lock_outline_rounded,
          title: 'Ganti Kata Sandi',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChangePasswordPage()),
          ),
        ),
        _MenuTile(
          icon: Icons.location_on_outlined,
          title: role == UserRole.bidan ? 'Puskesmas Saya' : 'Posyandu Saya',
          trailing: role.unit,
          onTap: () => showAppSnackBar(context, role.unit),
        ),
        _MenuTile(
          icon: Icons.info_outline_rounded,
          title: 'Tentang PosyTrace',
          trailing: 'v1.0',
          onTap: () => showAppSnackBar(
            context,
            'PosyTrace v1.0 — Posyandu Tracking & Growth Monitoring System.',
          ),
        ),
        const SizedBox(height: AppSpacing.gapSm),
        _MenuTile(
          icon: Icons.logout_rounded,
          title: 'Keluar',
          danger: true,
          onTap: () => _confirmLogout(context),
        ),
        const SizedBox(height: AppSpacing.gapLg),
        Center(
          child: Text('PosyTrace v1.0', style: AppText.caption),
        ),
      ],
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        title: const Text('Keluar dari akun?'),
        content: Text(
          'Anda perlu masuk kembali untuk membuka data posyandu.',
          style: AppText.caption,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Keluar',
              style: AppText.bodySm.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;
  final bool danger;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.danger : AppColors.textPrimary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AppCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: danger ? AppColors.danger : AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: AppText.bodySm.copyWith(color: color)),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: AppText.caption.copyWith(fontSize: 12),
              ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded,
                size: 20, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
