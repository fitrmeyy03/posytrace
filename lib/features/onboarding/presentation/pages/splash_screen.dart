import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _C {
  static const bg = Color(0xFFFBF9F6);
  static const primary = Color(0xFF954A00);
  static const primaryContainer = Color(0xFFE8863A);
  static const primaryFixed = Color(0xFFFFDCC6);
  static const primaryFixedDim = Color(0xFFFFB786);
  static const secondaryFixed = Color(0xFFFFDCC5);
  static const secondaryContainer = Color(0xFFFEA45F);
  static const onSurface = Color(0xFF1B1C1A);
  static const onSurfaceVariant = Color(0xFF554338);
  static const outlineVariant = Color(0xFFDBC2B3);
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _dotsController;
  Timer? _navTimer;
  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat();

    _navTimer = Timer(
        const Duration(seconds: 3, milliseconds: 500), _navigate);
  }

  void _navigate() {
    if (!mounted || _navigating) return;
    _navigating = true;
    _dotsController.stop();
    Navigator.of(context).pushReplacementNamed('/onboarding');
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: _C.bg,
        child: Stack(
          children: [
            // Warm radial ambient glows
            Positioned(
              top: -96, left: -96,
              child: Container(
                width: 384, height: 384,
                decoration: BoxDecoration(
                  color: _C.primaryFixed.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3,
              right: -112,
              child: Container(
                width: 320, height: 320,
                decoration: BoxDecoration(
                  color: _C.secondaryFixed.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -80, left: 90,
              child: Container(
                width: 288, height: 288,
                decoration: BoxDecoration(
                  color: _C.primaryFixedDim
                      .withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 24),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          // Logo card
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 160, height: 160,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      _C.primaryContainer
                                          .withValues(
                                              alpha: 0.2),
                                      _C.secondaryContainer
                                          .withValues(
                                              alpha: 0.25),
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 144, height: 144,
                                padding:
                                    const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: _C.outlineVariant
                                          .withValues(
                                              alpha: 0.3)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                              0xFFA0785A)
                                          .withValues(
                                              alpha: 0.14),
                                      blurRadius: 32,
                                      offset:
                                          const Offset(0, 12),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    fit: BoxFit.contain,
                                    errorBuilder: (ctx, err, stack) =>
                                        const Icon(
                                      Icons.child_care_rounded,
                                      size: 64,
                                      color: _C.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 290,
                            child: Text(
                              'Pantau Tumbuh Kembang & Kesehatan Buah Hati dengan Kasih',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  height: 1.5,
                                  color:
                                      _C.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Footer
                    AnimatedBuilder(
                      animation: _dotsController,
                      builder: (ctx, child) => Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: List.generate(3, (i) {
                          final phase =
                              (_dotsController.value +
                                      i * 0.22) %
                                  1.0;
                          final bounce = math.sin(
                                  phase * math.pi * 2) *
                              0.5 +
                              0.5;
                          final scale =
                              0.65 + bounce * 0.5;
                          return Container(
                            margin:
                                const EdgeInsets.symmetric(
                                    horizontal: 4),
                            width: 10,
                            height: 10,
                            child: Transform.scale(
                              scale: scale,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _C.primaryContainer
                                      .withValues(
                                          alpha: 0.4 +
                                              bounce *
                                                  0.6),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: _C.primaryContainer
                                          .withValues(
                                              alpha: 0.4),
                                      blurRadius: 8,
                                      offset:
                                          const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      constraints:
                          const BoxConstraints(maxWidth: 340),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withValues(alpha: 0.9),
                        borderRadius:
                            BorderRadius.circular(16),
                        border: Border.all(
                            color: _C.outlineVariant
                                .withValues(alpha: 0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFB89678)
                                .withValues(alpha: 0.10),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32, height: 32,
                            decoration: BoxDecoration(
                                color: _C.primaryFixed
                                    .withValues(alpha: 0.6),
                                shape: BoxShape.circle),
                            child: const Icon(
                                Icons.verified,
                                size: 18,
                                color: _C.primary),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 12,
                                        height: 1.3,
                                        color: _C
                                            .onSurfaceVariant),
                                children: const [
                                  TextSpan(
                                      text:
                                          'Terintegrasi dengan '),
                                  TextSpan(
                                      text: 'Posyandu',
                                      style: TextStyle(
                                          fontWeight:
                                              FontWeight.w600,
                                          color: _C
                                              .onSurface)),
                                  TextSpan(
                                      text:
                                          ' & Layanan Kesehatan Keluarga'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                        width: 128, height: 4,
                        decoration: BoxDecoration(
                            color: _C.onSurface
                                .withValues(alpha: 0.2),
                            borderRadius:
                                BorderRadius.circular(2))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
