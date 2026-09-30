import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _C {
  static const bg = Color(0xFFFBF9F6);
  static const primary = Color(0xFF954A00);
  static const primaryContainer = Color(0xFFE8863A);
  static const primaryFixedDim = Color(0xFFFFB786);
  static const secondary = Color(0xFF914C0D);
  static const secondaryContainer = Color(0xFFFEA45F);
  static const secondaryFixed = Color(0xFFFFDCC5);
  static const onSurface = Color(0xFF1B1C1A);
  static const outline = Color(0xFF887366);
  static const outlineVariant = Color(0xFFDBC2B3);
  static const surfaceLow = Color(0xFFF5F3F0);
  static const surfaceLowest = Colors.white;
  static const tertiary = Color(0xFF226A55);
  static const tertiaryFixed = Color(0xFFABF1D7);
  static const onTertiaryFixed = Color(0xFF002117);
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _anim;
  int _page = 0;
  bool _finishing = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _anim = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _anim.dispose();
    super.dispose();
  }

  void _go(int i) {
    if (i < 0 || i > 2) return;
    _pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _cta() {
    if (_finishing) return;
    if (_page < 2) {
      _go(_page + 1);
    } else {
      setState(() => _finishing = true);
      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed('/login');
      });
    }
  }

  /// Float offset ala gentleFloat / reverse (HTML 4s & 4.5s).
  double _float(double phase, {bool reverse = false}) {
    final t = (_anim.value + phase) % 1.0;
    final s = math.sin(t * math.pi * 2);
    return (reverse ? -s : s) * 7;
  }

  double _glow(double phase) {
    final t = (_anim.value + phase) % 1.0;
    return 0.35 + (math.sin(t * math.pi * 2) * 0.5 + 0.5) * 0.3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header: Lewati kanan
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => _go(2),
                    child: Row(
                      children: [
                        Text('Lewati',
                            style:
                                GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _C.outline)),
                        const Icon(Icons.chevron_right,
                            size: 16, color: _C.outline),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Carousel
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) =>
                    setState(() => _page = i),
                children: [
                  _slide1(),
                  _slide2(),
                  _slide3(),
                ],
              ),
            ),
            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                final active = i == _page;
                return GestureDetector(
                  onTap: () => _go(i),
                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 4),
                    width: active ? 28 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: active
                          ? _C.primaryContainer
                          : _C.outlineVariant,
                      borderRadius:
                          BorderRadius.circular(4),
                      boxShadow: active
                          ? [
                              BoxShadow(
                                  color: _C.primaryContainer
                                      .withValues(
                                          alpha: 0.4),
                                  blurRadius: 6,
                                  offset:
                                      const Offset(0, 2))
                            ]
                          : null,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            // CTA
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 22),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _cta,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _C.primaryContainer,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(28)),
                    elevation: 6,
                    shadowColor: _C.primaryContainer
                        .withValues(alpha: 0.5),
                  ),
                  child: _finishing && _page == 2
                      ? Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20, height: 20,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('Mempersiapkan PosyTrace...',
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight:
                                            FontWeight.w600,
                                        color: Colors.white)),
                          ],
                        )
                      : Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                                _page == 2
                                    ? 'Mulai Sekarang'
                                    : 'Lanjut',
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight:
                                            FontWeight.w600,
                                        color: Colors.white)),
                            const SizedBox(width: 8),
                            Icon(
                                _page == 2
                                    ? Icons.rocket_launch
                                    : Icons.arrow_forward,
                                size: 20,
                                color: Colors.white),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ============ SLIDE 1: KMS Digital ============
  Widget _slide1() {
    return SingleChildScrollView(
      padding:
          const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedBuilder(
                animation: _anim,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _C.secondaryContainer
                        .withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                builder: (ctx, child) => Positioned.fill(
                  child: Opacity(
                    opacity: _glow(0),
                    child: child!,
                  ),
                ),
              ),
                Container(
                  width: 256,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _C.surfaceLowest,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: _C.outlineVariant
                            .withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                          color:
                              const Color(0xFFA0785A)
                                  .withValues(alpha: 0.14),
                          blurRadius: 32,
                          offset: const Offset(0, 12)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 32, height: 32,
                                  decoration: BoxDecoration(
                                      color: _C.primaryContainer
                                          .withValues(
                                              alpha: 0.15),
                                      shape:
                                          BoxShape.circle),
                                  child: const Icon(
                                      Icons.child_care,
                                      size: 18,
                                      color: _C
                                          .primaryContainer),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text('KMS Digital',
                                          maxLines: 1,
                                          overflow: TextOverflow
                                              .ellipsis,
                                          style: GoogleFonts
                                              .plusJakartaSans(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight
                                                          .w700)),
                                      Text(
                                          'Standar WHO & Kemenkes',
                                          maxLines: 1,
                                          overflow: TextOverflow
                                              .ellipsis,
                                          style: GoogleFonts
                                              .plusJakartaSans(
                                                  fontSize: 10,
                                                  color: _C
                                                      .outline)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3),
                            decoration: BoxDecoration(
                                color: _C.tertiaryFixed,
                                borderRadius:
                                    BorderRadius.circular(
                                        12)),
                            child: const Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Icon(Icons.verified,
                                    size: 12,
                                    color: _C
                                        .onTertiaryFixed),
                                SizedBox(width: 2),
                                Text('Optimal',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: _C
                                            .onTertiaryFixed)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Lapisan raster statis di-cache (painter
                      // shouldRepaint=false) agar animasi 60fps mulus.
                      RepaintBoundary(
                        child: SizedBox(
                          height: 120,
                          child: CustomPaint(
                            painter: _KmsPainter(),
                            size: const Size(
                                double.infinity, 120),
                          ),
                        ),
                      ),
                      Row(
                        children: const [
                          Expanded(
                              child: _Axis(
                                  '6 bln', false, true)),
                          Expanded(
                              child: _Axis(
                                  '12 bln', false, true)),
                          Expanded(
                              child: _Axis(
                                  '18 bln', false, true)),
                          Expanded(
                              child: _Axis(
                                  '24 bln', true, true)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Expanded(
                              child: _Pill(
                                  l: 'Berat',
                                  v: '12.4',
                                  u: 'kg')),
                          SizedBox(width: 6),
                          Expanded(
                              child: _Pill(
                                  l: 'Tinggi',
                                  v: '88.5',
                                  u: 'cm')),
                          SizedBox(width: 6),
                          Expanded(
                              child: _Pill(
                                  l: 'L. Kepala',
                                  v: '47.2',
                                  u: 'cm')),
                        ],
                      ),
                    ],
                  ),
                ),
                // Badge kiri atas
                AnimatedBuilder(
                  animation: _anim,
                  child: _floatBadge(
                    icon: Icons.trending_up,
                    iconBg: _C.secondaryContainer,
                    top: 'Status Gizi',
                    bottom: 'Gizi Baik & Stabil',
                    bottomColor: _C.primary,
                  ),
                  builder: (ctx, child) => Positioned(
                    top: -4 + _float(0.1),
                    left: 4,
                    child: child!,
                  ),
                ),
                // Badge kanan bawah
                AnimatedBuilder(
                  animation: _anim,
                  child: _floatBadge(
                    icon: Icons.workspace_premium,
                    iconBg: Colors.transparent,
                    iconFg: _C.primaryContainer,
                    top: '',
                    bottom: 'Kurva Standar WHO',
                    bottomColor: _C.onSurface,
                  ),
                  builder: (ctx, child) => Positioned(
                    bottom: 96 + _float(0.6, reverse: true),
                    right: 4,
                    child: child!,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          Text('Pantau Tumbuh Kembang & KMS Digital',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.25)),
          const SizedBox(height: 8),
          Text(
            'Catat berat, tinggi, dan lingkar kepala balita secara akurat berbasis grafik standar WHO & Kemenkes RI langsung dari genggaman.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14, color: _C.outline),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ============ SLIDE 2: Jadwal Vaksinasi ============
  Widget _slide2() {
    return SingleChildScrollView(
      padding:
          const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Hanya lingkaran glow yang rebuild per frame;
              // kartu dan teks di bawah ini statis.
              AnimatedBuilder(
                animation: _anim,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _C.primaryContainer
                        .withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                builder: (ctx, child) => Positioned.fill(
                  child: Opacity(
                    opacity: _glow(0.3),
                    child: child!,
                  ),
                ),
              ),
                Container(
                  width: 256,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _C.surfaceLowest,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: _C.outlineVariant
                            .withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                          color:
                              const Color(0xFFA0785A)
                                  .withValues(alpha: 0.14),
                          blurRadius: 32,
                          offset: const Offset(0, 12)),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Kartu vaksin highlight
                      Container(
                        padding:
                            const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              _C.primaryContainer,
                              Color(0xFFF09855)
                            ],
                          ),
                          borderRadius:
                              BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: _C.primaryContainer
                                    .withValues(
                                        alpha: 0.35),
                                blurRadius: 16,
                                offset:
                                    const Offset(0, 4)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.white
                                            .withValues(
                                                alpha: 0.25),
                                        borderRadius:
                                            BorderRadius
                                                .circular(
                                                    10)),
                                    child: Text(
                                        'Posyandu Mawar Indah',
                                        maxLines: 1,
                                        overflow: TextOverflow
                                            .ellipsis,
                                        style: GoogleFonts
                                            .plusJakartaSans(
                                                fontSize: 10,
                                                color: Colors
                                                    .white)),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.event,
                                    size: 15,
                                    color: Colors.white),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text('Vaksin DPT-HB-Hib 3',
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 18,
                                        fontWeight:
                                            FontWeight.w600,
                                        color:
                                            Colors.white)),
                            Text(
                                'Kamis, 15 Mei 2026 • 08.30 WIB',
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 10,
                                        color: Colors.white
                                            .withValues(
                                                alpha:
                                                    0.9))),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                const Row(
                                  mainAxisSize:
                                      MainAxisSize.min,
                                  children: [
                                    Icon(Icons.alarm,
                                        size: 14,
                                        color: Colors.white),
                                    SizedBox(width: 4),
                                    Text('3 Hari Lagi',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors
                                                .white)),
                                  ],
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius
                                                .circular(
                                                    12)),
                                    child: Text(
                                        'No. Antrean: A-14',
                                        maxLines: 1,
                                        overflow: TextOverflow
                                            .ellipsis,
                                        style: GoogleFonts
                                            .plusJakartaSans(
                                                fontSize: 11,
                                                fontWeight:
                                                    FontWeight
                                                        .w700,
                                                color: _C
                                                    .primaryContainer)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      _doneRow('BCG & Polio 1',
                          'Diberikan pada usia 1 bulan'),
                      const SizedBox(height: 6),
                      _doneRow('Campak Rubella (MR)',
                          'Diberikan pada usia 9 bulan'),
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: _anim,
                  child: _floatBadge(
                    icon: Icons.notifications_active,
                    iconBg: _C.primaryContainer,
                    iconFg: Colors.white,
                    top: 'Pengingat Otomatis',
                    bottom: 'Kader & WhatsApp Notif',
                    bottomColor: _C.outline,
                  ),
                  builder: (ctx, child) => Positioned(
                    top: -8 + _float(0.2),
                    right: 0,
                    child: child!,
                  ),
                ),
                AnimatedBuilder(
                  animation: _anim,
                  child: _floatBadge(
                    icon: Icons.confirmation_number,
                    iconBg: _C.secondaryContainer
                        .withValues(alpha: 0.2),
                    iconFg: _C.secondary,
                    top: '',
                    bottom: 'Bebas Antre Lama',
                    bottomColor: _C.secondary,
                  ),
                  builder: (ctx, child) => Positioned(
                    bottom: 96 + _float(0.7, reverse: true),
                    left: 0,
                    child: child!,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          Text('Jadwal Vaksinasi & Notifikasi Posyandu',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.25)),
          const SizedBox(height: 8),
          Text(
            'Jangan lewatkan imunisasi wajib si kecil. Dapatkan pemberitahuan jadwal Posyandu terdekat dan nomor antrean instan.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14, color: _C.outline),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ============ SLIDE 3: Edukasi ============
  Widget _slide3() {
    return SingleChildScrollView(
      padding:
          const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedBuilder(
                animation: _anim,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _C.tertiary
                        .withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                ),
                builder: (ctx, child) => Positioned.fill(
                  child: Opacity(
                    opacity: _glow(0.6),
                    child: child!,
                  ),
                ),
              ),
                Container(
                  width: 256,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _C.surfaceLowest,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: _C.outlineVariant
                            .withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                          color:
                              const Color(0xFFA0785A)
                                  .withValues(alpha: 0.14),
                          blurRadius: 32,
                          offset: const Offset(0, 12)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _C.bg,
                          border: Border.all(
                              color: _C.outlineVariant
                                  .withValues(
                                      alpha: 0.3)),
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48, height: 48,
                              decoration: BoxDecoration(
                                  color: _C.secondaryFixed,
                                  borderRadius:
                                      BorderRadius.circular(
                                          12)),
                              child: const Icon(
                                  Icons.restaurant_menu,
                                  size: 24,
                                  color: Color(
                                      0xFF301400)),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text('GIZI & MPASI',
                                      maxLines: 1,
                                      overflow: TextOverflow
                                          .ellipsis,
                                      style: GoogleFonts
                                          .plusJakartaSans(
                                              fontSize: 10,
                                              fontWeight:
                                                  FontWeight
                                                      .w700,
                                              letterSpacing:
                                                  0.6,
                                              color: _C
                                                  .primaryContainer)),
                                  Text(
                                      'Menu 4 Bintang untuk Berat Ideal',
                                      maxLines: 1,
                                      overflow: TextOverflow
                                          .ellipsis,
                                      style: GoogleFonts
                                          .plusJakartaSans(
                                              fontSize: 12,
                                              fontWeight:
                                                  FontWeight
                                                      .w700)),
                                  Text(
                                      'Direview Ahli Gizi Puskesmas',
                                      maxLines: 1,
                                      overflow: TextOverflow
                                          .ellipsis,
                                      style: GoogleFonts
                                          .plusJakartaSans(
                                              fontSize: 10,
                                              color: _C
                                                  .outline)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 9),
                        decoration: BoxDecoration(
                          color: _C.primaryContainer
                              .withValues(alpha: 0.1),
                          border: Border.all(
                              color: _C.primaryContainer
                                  .withValues(
                                      alpha: 0.2)),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                                Icons.verified_user,
                                size: 18,
                                color:
                                    _C.primaryContainer),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                  '100% Terverifikasi Medis',
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow.ellipsis,
                                  style: GoogleFonts
                                      .plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight:
                                              FontWeight.w600,
                                          color: Color(
                                              0xFF582900))),
                            ),
                            const Spacer(),
                            const Icon(
                                Icons.check_circle,
                                size: 16,
                                color:
                                    _C.primaryContainer),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: _anim,
                  child: _floatBadge(
                    icon: Icons.restaurant_menu,
                    iconBg: _C.primaryFixedDim
                        .withValues(alpha: 0.4),
                    iconFg: _C.primary,
                    top: '',
                    bottom: 'Resep MPASI Lokal',
                    bottomColor: _C.onSurface,
                  ),
                  builder: (ctx, child) => Positioned(
                    bottom: 96 + _float(0.4, reverse: true),
                    left: 0,
                    child: child!,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          Text('Edukasi Parenting Tepercaya',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.25)),
          const SizedBox(height: 8),
          Text(
            'Akses panduan gizi MPASI terkurasi, tips stimulasi motorik balita.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14, color: _C.outline),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _floatBadge({
    required IconData icon,
    required Color iconBg,
    Color iconFg = _C.onSurface,
    required String top,
    required String bottom,
    required Color bottomColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFA0785A)
                  .withValues(alpha: 0.18),
              blurRadius: 20,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26, height: 26,
            decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle),
            child:
                Icon(icon, size: 14, color: iconFg),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (top.isNotEmpty)
                Text(top,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: _C.outline)),
              Text(bottom,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: bottomColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _doneRow(String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _C.surfaceLow,
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 28, height: 28,
            decoration: const BoxDecoration(
                color: _C.tertiaryFixed,
                shape: BoxShape.circle),
            child: const Icon(Icons.check,
                size: 14,
                color: _C.onTertiaryFixed),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
                Text(sub,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10, color: _C.outline)),
              ],
            ),
          ),
          const Icon(Icons.check_circle,
              size: 16, color: _C.outline),
        ],
      ),
    );
  }
}

class _Axis extends StatelessWidget {
  final String t;
  final bool hl;
  final bool center;
  const _Axis(this.t, this.hl, [this.center = false]);
  @override
  Widget build(BuildContext context) {
    return Text(t,
        textAlign: center ? TextAlign.center : null,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight:
                hl ? FontWeight.w700 : FontWeight.w400,
            color: hl ? _C.primary : _C.outline));
  }
}

class _Pill extends StatelessWidget {
  final String l;
  final String v;
  final String u;
  const _Pill(
      {required this.l, required this.v, required this.u});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _C.surfaceLow,
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(l,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 10, color: _C.outline)),
          RichText(
            text: TextSpan(
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _C.onSurface),
              children: [
                TextSpan(text: v),
                TextSpan(
                    text: ' $u',
                    style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        color: _C.outline)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Kurva KMS slide 1: zona aman + area + garis orange + node.
class _KmsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Zona aman hijau transparan
    final zone = Path()
      ..moveTo(0, h * 0.72)
      ..quadraticBezierTo(
          w * 0.3, h * 0.55, w * 0.55, h * 0.35)
      ..lineTo(w, h * 0.13)
      ..lineTo(w, h * 0.94)
      ..lineTo(0, h * 0.94)
      ..close();
    canvas.drawPath(
        zone,
        Paint()
          ..color = _C.tertiary.withValues(alpha: 0.08)
          ..style = PaintingStyle.fill);

    // Garis referensi dashed
    final ref = Path()
      ..moveTo(0, h * 0.78)
      ..quadraticBezierTo(
          w * 0.3, h * 0.60, w * 0.55, h * 0.40)
      ..lineTo(w, h * 0.18);
    _dashed(canvas, ref, _C.tertiary.withValues(alpha: 0.4));

    // Area bawah kurva
    final area = Path()
      ..moveTo(0, h * 0.89)
      ..quadraticBezierTo(
          w * 0.28, h * 0.69, w * 0.53, h * 0.47)
      ..lineTo(w, h * 0.22)
      ..lineTo(w, h * 0.94)
      ..lineTo(0, h * 0.94)
      ..close();
    canvas.drawPath(
        area,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _C.primaryContainer
                  .withValues(alpha: 0.32),
              _C.primaryContainer.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromLTWH(0, 0, w, h)));

    // Garis utama
    final line = Path()
      ..moveTo(0, h * 0.89)
      ..quadraticBezierTo(
          w * 0.28, h * 0.69, w * 0.53, h * 0.47)
      ..lineTo(w, h * 0.22);
    canvas.drawPath(
        line,
        Paint()
          ..color = _C.primaryContainer
          ..strokeWidth = 3.5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round);

    // Node tengah
    for (final t in [0.28, 0.53]) {
      final x = w * t;
      final y = h * (0.89 - t * 0.85);
      canvas.drawCircle(
          Offset(x, y), 4.5, Paint()..color = Colors.white);
      canvas.drawCircle(
          Offset(x, y),
          4.5,
          Paint()
            ..color = _C.primaryContainer
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.5);
    }
    // Node aktif + glow
    final ax = w * 0.80;
    final ay = h * 0.30;
    canvas.drawCircle(
        Offset(ax, ay),
        7,
        Paint()
          ..color = _C.primaryContainer
              .withValues(alpha: 0.25));
    canvas.drawCircle(Offset(ax, ay), 4.5,
        Paint()..color = _C.primaryContainer);
    canvas.drawCircle(Offset(ax, ay), 2,
        Paint()..color = Colors.white);
  }

  void _dashed(Canvas canvas, Path path, Color color) {
    final metrics = path.computeMetrics();
    for (final m in metrics) {
      double d = 0;
      while (d < m.length) {
        final seg = m.extractPath(d, d + 3);
        canvas.drawPath(
            seg,
            Paint()
              ..color = color
              ..strokeWidth = 1.5
              ..style = PaintingStyle.stroke);
        d += 6;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
