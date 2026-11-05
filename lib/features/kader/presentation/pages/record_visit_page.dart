import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/models/growth_status.dart';
import '../../../../core/theme/app_layout.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Pencatatan Kunjungan — isi BB/TB, Z-Score terhitung otomatis.
class RecordVisitPage extends StatefulWidget {
  final String? childName;
  const RecordVisitPage({super.key, this.childName});

  @override
  State<RecordVisitPage> createState() => _RecordVisitPageState();
}

class _RecordVisitPageState extends State<RecordVisitPage> {
  late ChildRecord _child;
  late final TextEditingController _weight;
  late final TextEditingController _height;

  @override
  void initState() {
    super.initState();
    _child = widget.childName == null
        ? DemoData.aisyah
        : DemoData.byName(widget.childName!);
    _weight = TextEditingController(
      text: _child.weight.toStringAsFixed(1).replaceAll('.', ','),
    );
    _height = TextEditingController(
      text: _child.height.toStringAsFixed(1).replaceAll('.', ','),
    );
    _weight.addListener(() => setState(() {}));
    _height.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _weight.dispose();
    _height.dispose();
    super.dispose();
  }

  double get _bb => double.tryParse(_weight.text.replaceAll(',', '.')) ??
      _child.weight;
  double get _tb => double.tryParse(_height.text.replaceAll(',', '.')) ??
      _child.height;

  double get _zbb => _child.zWeightAge + (_bb - _child.weight);
  double get _ztb => _child.zHeightAge + (_tb - _child.height);
  double get _zbbtb => _child.zWeightHeight + (_bb - _child.weight);


  void _save() {
    showAppSnackBar(
      context,
      'Kunjungan ${_child.name.split(' ').first} tersimpan — notifikasi terkirim ke orang tua.',
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final status = GrowthStatus.fromZ(_zbb);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarHeader(title: 'Pencatatan Kunjungan'),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          AppCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                AppAvatar(initial: _child.initial),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_child.name, style: AppText.title),
                      Text(
                        '${_child.ageMonths} bulan · ${_child.parentName}',
                        style: AppText.caption,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.unfold_more_rounded,
                    color: AppColors.textMuted, size: 20),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gapLg),
          AppTextField(
            label: 'Berat Badan (kg)',
            hint: '9,8',
            controller: _weight,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            suffix: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Center(
                widthFactor: 1,
                child: Text('kg', style: AppText.caption),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          AppTextField(
            label: 'Tinggi / Panjang Badan (cm)',
            hint: '86,5',
            controller: _height,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            suffix: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Center(
                widthFactor: 1,
                child: Text('cm', style: AppText.caption),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.gapLg),
          Text(
            'Hasil Z-Score (WHO)',
            style: AppText.label.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.gapSm),
          Row(
            children: [
              Expanded(
                child: ZScoreBox(
                  label: 'BB/U',
                  value: _zbb,
                  status: status,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ZScoreBox(
                  label: 'TB/U',
                  value: _ztb,
                  status: GrowthStatus.fromZ(_ztb),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ZScoreBox(
                  label: 'BB/TB',
                  value: _zbbtb,
                  status: GrowthStatus.fromZ(_zbbtb),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.gapMd),
          AppCard(
            color: status.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      status == GrowthStatus.normal
                          ? Icons.check_circle_rounded
                          : Icons.error_outline_rounded,
                      size: 18,
                      color: status.color,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Status Gizi: ${status.label}',
                        style: AppText.title.copyWith(
                          color: status.color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  switch (status) {
                    GrowthStatus.normal => 'Pertumbuhan sesuai kurva WHO.',
                    GrowthStatus.under =>
                      'Berat badan di bawah rentang normal — perlu pemantauan tambahan.',
                    GrowthStatus.severe =>
                      'Berat badan sangat di bawah normal — rujuk ke bidan/puskesmas.',
                    GrowthStatus.over =>
                      'Berat badan di atas rentang normal — konsultasikan pola makan.',
                  },
                  style: AppText.caption.copyWith(color: status.color),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gapLg),
          AppButton('Simpan Kunjungan', expanded: true, onPressed: _save),
          const SizedBox(height: AppSpacing.gapSm),
          Center(
            child: Text(
              'Orang tua otomatis menerima notifikasi hasil.',
              style: AppText.caption,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
