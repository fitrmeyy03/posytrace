import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/app_theme.dart';

/// Logo PosyTrace: kotak membulat + garis pertumbuhan, dipakai splash & login.
class BrandMark extends StatelessWidget {
  final double size;
  final bool onOrange;

  const BrandMark({super.key, this.size = 56, this.onOrange = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: onOrange ? AppColors.surface : AppColors.primary,
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: onOrange ? null : [AppColors.fabShadow],
      ),
      child: Icon(
        Icons.show_chart_rounded,
        size: size * 0.56,
        color: onOrange ? AppColors.primary : AppColors.surface,
      ),
    );
  }
}

class BrandWordmark extends StatelessWidget {
  final double fontSize;
  final bool light;

  const BrandWordmark({super.key, this.fontSize = 24, this.light = false});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppText.h1.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
          color: light ? AppColors.surface : AppColors.textPrimary,
        ),
        children: [
          const TextSpan(text: 'Posy'),
          TextSpan(
            text: 'Trace',
            style: TextStyle(
              color: light ? AppColors.surface : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
