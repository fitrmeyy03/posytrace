import 'package:flutter/material.dart';

/// Satu sumber spacing & radius untuk seluruh aplikasi.
///
/// Mengikuti spesifikasi desain: sudut membulat 12–16px, padding halaman 20,
/// target sentuh minimal 48px.
abstract final class AppSpacing {
  // Halaman
  static const EdgeInsets pagePadding = EdgeInsets.fromLTRB(20, 8, 20, 24);

  // Irama vertikal
  static const double gapXs = 8;
  static const double gapSm = 12;
  static const double gapMd = 16;
  static const double gapLg = 20;
  static const double gapXl = 24;

  // Radius — sesuai spesifikasi (12–16, pill hanya untuk chip/badge)
  static const double radiusSm = 10; // chip kecil, badge
  static const double radiusMd = 12; // input, tile, tombol
  static const double radiusLg = 16; // kartu utama, hero
  static const double radiusPill = 999;

  // Komponen
  static const double touch = 48; // target sentuh minimal
  static const double avatar = 44;
  static const double iconBox = 40;
  static const double bottomNavHeight = 64;
}
