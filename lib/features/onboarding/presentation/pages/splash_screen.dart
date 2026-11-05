import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_mascot.dart';
import '../../../../core/widgets/brand_logo.dart';

/// Splash Screen — logo di atas latar oranye penuh, sebelum login.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 3500), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.deepOrange.withValues(alpha: 0.28),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const AppMascot(size: 132),
                ),
                const SizedBox(height: AppSpacing.gapLg),
                const BrandWordmark(fontSize: 30, light: true),
                const SizedBox(height: AppSpacing.gapXs),
                Text(
                  'Pemantauan tumbuh kembang balita',
                  textAlign: TextAlign.center,
                  style: AppText.bodySm.copyWith(
                    color: AppColors.surface.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: AppSpacing.gapXl),
                Text(
                  'Posyandu Tracking & Growth Monitoring System',
                  textAlign: TextAlign.center,
                  style: AppText.caption.copyWith(
                    color: AppColors.surface.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'PosyTrace v1.0',
                  textAlign: TextAlign.center,
                  style: AppText.caption.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.surface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
