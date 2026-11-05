import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

/// Kerangka halaman standar: latar krem, padding 20, opsional nav bawah & FAB.
class AppScaffold extends StatelessWidget {
  final List<Widget> children;
  final Widget? appBar;
  final Widget? bottomNav;
  final Widget? fab;
  final EdgeInsets padding;
  final bool scrollable;

  const AppScaffold({
    super.key,
    required this.children,
    this.appBar,
    this.bottomNav,
    this.fab,
    this.padding = AppSpacing.pagePadding,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    // Beri ruang ekstra di bawah supaya FAB tidak menutupi item terakhir.
    final effectivePadding = fab == null
        ? padding
        : EdgeInsets.fromLTRB(padding.left, padding.top, padding.right, 88);
    final content = scrollable
        ? ListView(
            padding: effectivePadding,
            children: children,
          )
        : Padding(
            padding: effectivePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBar == null ? null : PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: appBar!,
      ),
      body: SafeArea(top: appBar == null, bottom: false, child: content),
      floatingActionButton: fab,
      bottomNavigationBar: bottomNav,
    );
  }
}

/// Header dengan chevron kiri + judul — dipakai hampir semua layar detail.
class AppBarHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? action;

  const AppBarHeader({
    super.key,
    required this.title,
    this.onBack,
    this.action,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack ?? () => Navigator.maybePop(context),
            icon: const Icon(Icons.chevron_left_rounded, size: 28),
            tooltip: 'Kembali',
            color: AppColors.textPrimary,
          ),
          Expanded(
            child: Text(
              title,
              style: AppText.h2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}

/// Judul besar di dalam body (Beranda/Profil), dengan aksi di kanan.
class PageHeading extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? mascot;
  final Widget? action;

  const PageHeading({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.mascot,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppText.h2),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle!, style: AppText.caption),
              ],
            ],
          ),
        ),
        if (mascot != null) ...[
          const SizedBox(width: 8),
          mascot!,
          const SizedBox(width: 4),
        ],
        ?action,
      ],
    );
  }
}

/// Kartu hero oranye (jadwal hari ini, ajakan, dsb).
class HeroCard extends StatelessWidget {
  final String label;
  final String title;
  final String subtitle;
  final Widget? action;

  const HeroCard({
    super.key,
    required this.label,
    required this.title,
    required this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [AppColors.fabShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: AppText.caption.copyWith(
              fontSize: 11,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w600,
              color: AppColors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: AppText.h2.copyWith(color: AppColors.white, fontSize: 19),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppText.caption.copyWith(
              color: AppColors.white.withValues(alpha: 0.9),
            ),
          ),
          if (action != null) ...[
            const SizedBox(height: 16),
            action!,
          ],
        ],
      ),
    );
  }
}

/// Tombol putih bergaris di atas kartu oranye.
class HeroOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const HeroOutlinedButton(this.label, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.white, width: 1.4),
        ),
        child: Text(
          label,
          style: AppText.button.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}

/// Baris label–nilai untuk ringkasan data.
class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? trailing;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppText.caption)),
          Text(value, style: AppText.bodySm.copyWith(fontWeight: FontWeight.w600)),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ],
        ],
      ),
    );
  }
}
