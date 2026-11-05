import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/growth_status.dart';
import '../theme/app_theme.dart';
import 'app_widgets.dart';

/// Maskot PosyTrace — karakter jeruk oranye yang mewakili pertumbuhan sehat.
///
/// Tiga pose dipakai sesuai konteks:
/// - [MascotMood.greeting]  : menyapa di splash, onboarding, login, dan beranda.
/// - [MascotMood.normal]    : status gizi baik / pertumbuhan sesuai kurva.
/// - [MascotMood.attention] : ada ukuran yang perlu dipantau.
enum MascotMood { greeting, normal, attention }

class AppMascot extends StatelessWidget {
  final MascotMood mood;
  final double size;
  final bool circular;
  final String? semanticLabel;

  const AppMascot({
    super.key,
    this.mood = MascotMood.greeting,
    this.size = 72,
    this.circular = true,
    this.semanticLabel,
  });

  static const Map<MascotMood, String> _assets = {
    MascotMood.greeting: 'assets/maskot/beranda-maskot.webp',
    MascotMood.normal: 'assets/maskot/normal-maskot.webp',
    MascotMood.attention: 'assets/maskot/risiko-maskot.webp',
  };

  static const Map<MascotMood, String> _labels = {
    MascotMood.greeting: 'Maskot PosyTrace melambai',
    MascotMood.normal: 'Maskot PosyTrace mengacungkan jempol',
    MascotMood.attention: 'Maskot PosyTrace mengingatkan untuk memantau',
  };

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      _assets[mood]!,
      width: size,
      height: size,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.medium,
      semanticLabel: semanticLabel ?? _labels[mood],
      errorBuilder: (_, _, _) => Container(
        width: size,
        height: size,
        color: AppColors.tint,
        alignment: Alignment.center,
        child: Icon(
          Icons.sentiment_satisfied_alt_rounded,
          size: size * 0.5,
          color: AppColors.primaryDark,
        ),
      ),
    );

    if (!circular) {
      final radius = BorderRadius.circular(size * 0.22);
      return Container(
        width: size,
        height: size,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.tint,
          borderRadius: radius,
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: AppColors.border),
        ),
        child: image,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.tint,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.border,
          width: size >= 64 ? 2 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: image,
    );
  }
}

/// Maskot kecil dengan balon percakapan — dipakai untuk tips singkat.
class MascotSpeech extends StatelessWidget {
  final String message;
  final MascotMood mood;
  final double mascotSize;

  const MascotSpeech({
    super.key,
    required this.message,
    this.mood = MascotMood.greeting,
    this.mascotSize = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppMascot(mood: mood, size: mascotSize),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: AppColors.tint,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
                bottomRight: Radius.circular(14),
                bottomLeft: Radius.circular(4),
              ),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              message,
              style: AppText.caption.copyWith(
                color: AppColors.deepOrange,
                fontWeight: FontWeight.w600,
                height: 1.45,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Ringkasan status gizi dengan maskot yang menyesuaikan kondisi anak.
class MascotStatusNote extends StatelessWidget {
  final GrowthStatus status;
  final String childName;
  final String? message;

  const MascotStatusNote({
    super.key,
    required this.status,
    required this.childName,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isNormal = status == GrowthStatus.normal;
    final firstName = childName.split(' ').first;
    final note = message ??
        (isNormal
            ? 'Tumbuh kembang $firstName baik. Pertahankan pola makan bergizi '
                'dan jadwal posyandu rutin, ya!'
            : 'Ada ukuran yang perlu dipantau. Yuk konsultasikan $firstName '
                'ke bidan atau puskesmas terdekat.');

    return AppCard(
      child: Row(
        children: [
          AppMascot(
            mood: isNormal ? MascotMood.normal : MascotMood.attention,
            size: 80,
            circular: false,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        isNormal ? 'Status gizi baik' : 'Perlu perhatian',
                        style: AppText.title.copyWith(
                          fontWeight: FontWeight.w700,
                          color: status.color,
                        ),
                      ),
                    ),
                    StatusChip(status, compact: true),
                  ],
                ),
                const SizedBox(height: 4),
                Text(note, style: AppText.caption.copyWith(height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
