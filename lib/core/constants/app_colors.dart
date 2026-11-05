import 'package:flutter/material.dart';

/// Palet PosyTrace — diambil persis dari spesifikasi desain "Oranye Posyandu".
///
/// Aturan pakai:
/// - [primary]      (#F97316) hanya untuk ikon aktif, aksen, grafik, FAB.
/// - [primaryDark]  (#EA580C) untuk tombol utama berteks putih & teks oranye.
///   Jangan taruh teks putih di atas [primary] — kontrasnya cuma ±2,8:1.
/// - [deepOrange]   (#C2410C) untuk judul aksen, badge peran, teks oranye kecil.
/// - [softOrange]   (#FB923C) untuk ilustrasi & highlight.
/// - [tint]         (#FFEDD5) untuk latar chip, avatar, kartu lembut.
/// - [background]   (#FFF7ED) latar layar, [surface] (#FFFFFF) kartu & form.
class AppColors {
  AppColors._();

  // ---- Brand ----
  static const Color primary = Color(0xFFF97316);
  static const Color primaryDark = Color(0xFFEA580C);
  static const Color deepOrange = Color(0xFFC94F0B);
  static const Color softOrange = Color(0xFFFB923C);
  static const Color tint = Color(0xFFFFF2E5);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // ---- Latar & teks ----
  static const Color background = Color(0xFFFFFEFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color subtle = Color(0xFFFFF8F1);
  static const Color segmentTrack = Color(0xFFF8F2EA);
  static const Color textPrimary = Color(0xFF28231F);
  static const Color textSecondary = Color(0xFF776C61);
  static const Color textMuted = Color(0xFF8A7D71);
  static const Color border = Color(0xFFEEE5DB);
  static const Color divider = Color(0xFFF0E7DD);

  // ---- Status gizi (Z-Score, Permenkes No. 2/2020) ----
  // Selalu dipakai bersama label teks, jangan warna saja.
  static const Color statusSevere = Color(0xFFDC2626); // Z < -3 SD
  static const Color statusSevereBg = Color(0xFFFEE2E2);
  static const Color statusUnder = Color(0xFFD97706); // -3 s.d. < -2 SD
  static const Color statusUnderBg = Color(0xFFFEF3C7);
  static const Color statusNormal = Color(0xFF247347); // -2 s.d. +1/+2 SD
  static const Color statusNormalBg = Color(0xFFE9F6EC);
  static const Color statusOver = Color(0xFF2563EB); // di atas ambang atas
  static const Color statusOverBg = Color(0xFFDBEAFE);

  // ---- Aksi berbahaya (selalu merah, bukan oranye) ----
  static const Color danger = Color(0xFFDC2626);
  static const Color dangerBg = Color(0xFFFEE2E2);

  // ---- Netral pendukung ----
  static const Color white = Color(0xFFFFFFFF);
  static const Color overlay = Color(0x14000000);

  static final BoxShadow cardShadow = BoxShadow(
    color: deepOrange.withValues(alpha: 0.06),
    blurRadius: 18,
    offset: const Offset(0, 6),
  );

  static final BoxShadow fabShadow = BoxShadow(
    color: primary.withValues(alpha: 0.35),
    blurRadius: 16,
    offset: const Offset(0, 6),
  );
}
