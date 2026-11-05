import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/demo_data.dart';
import '../../theme/app_layout.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

/// Notifikasi — hasil kunjungan, pengingat jadwal, dan artikel baru.
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final List<NotificationRecord> _items = [...DemoData.notifications];

  void _open(NotificationRecord item) {
    setState(() {
      final i = _items.indexOf(item);
      _items[i] = NotificationRecord(
        item.title,
        item.body,
        isNew: false,
        kind: item.kind,
      );
    });
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _icon(item.kind),
                const SizedBox(width: 12),
                Expanded(child: Text(item.title, style: AppText.h3)),
              ],
            ),
            const SizedBox(height: AppSpacing.gapSm),
            Text(item.body, style: AppText.body.copyWith(
              color: AppColors.textSecondary,
            )),
            const SizedBox(height: AppSpacing.gapLg),
            AppButton(
              'Tutup',
              variant: AppButtonVariant.secondary,
              expanded: true,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon(NotificationKind kind) {
    final (icon, color, bg) = switch (kind) {
      NotificationKind.result => (
          Icons.check_circle_outline_rounded,
          AppColors.statusNormal,
          AppColors.statusNormalBg
        ),
      NotificationKind.article => (
          Icons.menu_book_outlined,
          AppColors.deepOrange,
          AppColors.tint
        ),
      NotificationKind.schedule => (
          Icons.event_available_outlined,
          AppColors.primary,
          AppColors.tint
        ),
    };
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final newItems = _items.where((n) => n.isNew).toList();
    final oldItems = _items.where((n) => !n.isNew).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarHeader(title: 'Notifikasi'),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          Row(
            children: [
              Text(
                '${newItems.length} baru',
                style: AppText.caption.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.gapSm),
          if (newItems.isNotEmpty) ...[
            Text('BARU', style: AppText.label),
            const SizedBox(height: AppSpacing.gapXs),
            ...newItems.map((n) => _tile(n)),
          ],
          if (oldItems.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.gapMd),
            Text('SEBELUMNYA', style: AppText.label),
            const SizedBox(height: AppSpacing.gapXs),
            ...oldItems.map((n) => _tile(n)),
          ],
        ],
      ),
    );
  }

  Widget _tile(NotificationRecord n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        padding: const EdgeInsets.all(14),
        onTap: () => _open(n),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _icon(n.kind),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(n.title, style: AppText.title),
                      ),
                      if (n.isNew)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(n.body, style: AppText.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
