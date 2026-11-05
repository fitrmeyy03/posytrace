import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Kelola Akun Kader — bidan membuat & menonaktifkan akun kader per posyandu.
class ManageKaderPage extends StatefulWidget {
  const ManageKaderPage({super.key});

  @override
  State<ManageKaderPage> createState() => _ManageKaderPageState();
}

class _ManageKaderPageState extends State<ManageKaderPage> {
  late final List<CadreRecord> _cadres = [...DemoData.cadres];

  void _toggle(int index) {
    final c = _cadres[index];
    setState(() {
      _cadres[index] = CadreRecord(c.name, c.posyandu, !c.active);
    });
    showAppSnackBar(
      context,
      c.active
          ? 'Akun ${c.name} dinonaktifkan.'
          : 'Akun ${c.name} diaktifkan kembali.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarHeader(title: 'Kelola Akun Kader'),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          const InfoNote(
            'Akun kader hanya dibuat oleh bidan, terikat ke satu posyandu, dan memakai kata sandi sementara.',
          ),
          const SizedBox(height: AppSpacing.gapMd),
          ...List.generate(_cadres.length, (i) {
            final c = _cadres[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    AppAvatar(initial: c.initial),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.name, style: AppText.title),
                          Text('Kader · ${c.posyandu}',
                              style: AppText.caption),
                        ],
                      ),
                    ),
                    _ActiveSwitch(
                      active: c.active,
                      onChanged: (_) => _toggle(i),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: AppSpacing.gapSm),
          AppButton(
            'Buat Akun Kader',
            icon: Icons.add_rounded,
            expanded: true,
            onPressed: () => showAppSnackBar(
              context,
              'Form akun kader baru dibuka.',
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveSwitch extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  const _ActiveSwitch({required this.active, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: active,
            onChanged: onChanged,
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.statusNormal,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.textMuted,
          ),
        ),
        Text(
          active ? 'Aktif' : 'Nonaktif',
          style: AppText.caption.copyWith(
            fontSize: 10,
            color: active ? AppColors.statusNormal : AppColors.textMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
