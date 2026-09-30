import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary (#FF6B35 Sharp Orange)
  static const Color primary = Color(0xFFFF6B35);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFFE8DD);
  static const Color onPrimaryContainer = Color(0xFF2D1600);

  // Secondary (Coral Orange)
  static const Color secondary = Color(0xFFFF8C42);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFFF0E5);
  static const Color onSecondaryContainer = Color(0xFF2E1500);

  // Tertiary (Golden)
  static const Color tertiary = Color(0xFFFFD23F);
  static const Color onTertiary = Color(0xFF2E1500);
  static const Color tertiaryContainer = Color(0xFFFFF8E1);
  static const Color onTertiaryContainer = Color(0xFF2E1500);

  // Error
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Surface (Warm White)
  static const Color surface = Color(0xFFFFFBF9);
  static const Color onSurface = Color(0xFF1F1200);

  // Surface Containers
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF9F3EE);
  static const Color surfaceContainer = Color(0xFFF3EDE8);
  static const Color surfaceContainerHigh = Color(0xFFEDE7E2);
  static const Color surfaceContainerHighest = Color(0xFFE7E1DC);

  // Surface Variant
  static const Color onSurfaceVariant = Color(0xFF51443A);

  // Outline
  static const Color outline = Color(0xFF837468);
  static const Color outlineVariant = Color(0xFFD5C9BD);

  // Inverse
  static const Color inverseSurface = Color(0xFF352010);
  static const Color inverseOnSurface = Color(0xFFFFF0E5);
  static const Color inversePrimary = Color(0xFFFF6B35);

  // Shared BoxShadow
  static final BoxShadow cardShadow = BoxShadow(
    color: const Color(0x0DFFA259),
    blurRadius: 20,
    offset: const Offset(0, 4),
  );
}
