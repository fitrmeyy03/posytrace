import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Status gizi balita — warna mengikuti KMS/WHO (Permenkes No. 2/2020).
/// Warna TIDAK pernah dipakai sendirian: selalu ada label teks.
enum GrowthStatus {
  severe('Sangat Kurang', 'Z < −3 SD'),
  under('Kurang', '−3 SD s.d. < −2 SD'),
  normal('Normal', '−2 SD s.d. +2 SD'),
  over('Risiko Lebih', 'di atas ambang atas');

  const GrowthStatus(this.label, this.range);

  final String label;
  final String range;

  Color get color => switch (this) {
        GrowthStatus.severe => AppColors.statusSevere,
        GrowthStatus.under => AppColors.statusUnder,
        GrowthStatus.normal => AppColors.statusNormal,
        GrowthStatus.over => AppColors.statusOver,
      };

  Color get background => switch (this) {
        GrowthStatus.severe => AppColors.statusSevereBg,
        GrowthStatus.under => AppColors.statusUnderBg,
        GrowthStatus.normal => AppColors.statusNormalBg,
        GrowthStatus.over => AppColors.statusOverBg,
      };

  String get shortLabel => switch (this) {
        GrowthStatus.severe => 'Buruk',
        GrowthStatus.under => 'Kurang',
        GrowthStatus.normal => 'Baik',
        GrowthStatus.over => 'Lebih',
      };

  /// Ambang Z-Score standar WHO/Permenkes No. 2/2020.
  static GrowthStatus fromZ(double z) {
    if (z < -3) return GrowthStatus.severe;
    if (z < -2) return GrowthStatus.under;
    if (z > 2) return GrowthStatus.over;
    return GrowthStatus.normal;
  }
}
