import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/shared/pages/notifications_page.dart';
import '../../../../core/shared/pages/profile_page.dart';

class _C {
  static const bg = Color(0xFFFDF7FF);
  static const primary = Color(0xFF632CE5);
  static const secondary = Color(0xFF4B00CC);
  static const primaryFixed = Color(0xFFE8DEFF);
  static const onSurface = Color(0xFF1D1A25);
  static const onSurfaceVariant = Color(0xFF494455);
  static const outline = Color(0xFF7A7487);
  static const surfaceLow = Color(0xFFF8F1FF);
  static const surfaceHigh = Color(0xFFEDE5F5);
  static const tertiary = Color(0xFF00655A);
  static const tertiaryContainer = Color(0xFF008073);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF93000A);
}

class MidwifeDashboardPage extends StatelessWidget {
  final Function(int)? onTabChange;

  const MidwifeDashboardPage({super.key, this.onTabChange});

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.plusJakartaSans(fontSize: 12)),
      backgroundColor: const Color(0xFF322F3A),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ));
  }

  void _goTab(int i) => onTabChange?.call(i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _header(context)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _profileCard(),
                const SizedBox(height: 14),
                _alertBanner(context),
                const SizedBox(height: 18),
                _summarySection(context),
                const SizedBox(height: 18),
                _servicesSection(context),
                const SizedBox(height: 18),
                _liveSection(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.fromLTRB(20, 0, 12, 0),
      decoration: BoxDecoration(
        color: _C.surfaceLow.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF632CE5).withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, 4)),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 32, height: 32,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                        Icons.child_care_rounded,
                        color: _C.primary),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('POSY Trace',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: _C.primary)),
                    Text('BIDAN WILAYAH',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            color: _C.outline)),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Stack(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  const NotificationsPage())),
                      icon: const Icon(Icons.notifications_outlined,
                          size: 22,
                          color: _C.onSurfaceVariant),
                    ),
                    Positioned(
                      right: 12, top: 12,
                      child: Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(
                          color: _C.error,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: _C.surfaceLow, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => const ProfilePage())),
                  child: Container(
                    width: 32, height: 32,
                    decoration: const BoxDecoration(
                        color: _C.primary,
                        shape: BoxShape.circle),
                    child: const Icon(Icons.person,
                        size: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF651FFF).withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: _C.surfaceHigh,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_hospital,
                          size: 14, color: _C.primary),
                      SizedBox(width: 4),
                      Text('Puskesmas Sukamaju',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _C.primary)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text('Halo, Bidan Ratna 👋',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                Text('Pantau kesehatan ibu & anak desa hari ini',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: _C.outline)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 56, height: 56,
                decoration: const BoxDecoration(
                    color: _C.primaryFixed,
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text('BR',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF20005F))),
              ),
              Positioned(
                bottom: -2, right: -2,
                child: Container(
                  width: 20, height: 20,
                  decoration: BoxDecoration(
                    color: _C.tertiaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.verified,
                      size: 12,
                      color: Color(0xFFDCFFF7)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _alertBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.errorContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40, height: 40,
            decoration: const BoxDecoration(
                color: _C.error, shape: BoxShape.circle),
            child: const Icon(Icons.priority_high,
                size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                          '3 Balita Butuh Tindak Lanjut!',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _C.onErrorContainer)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: _C.error,
                          borderRadius:
                              BorderRadius.circular(20)),
                      child: Text('Prioritas',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        height: 1.4,
                        color: _C.onSurfaceVariant),
                    children: const [
                      TextSpan(
                          text:
                              'BB turun 2x berturut-turut & Z-Score TB/U < -2 SD di '),
                      TextSpan(
                          text: 'Posyandu Melati 03',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _C.onErrorContainer)),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rujukan Puskesmas & PMT',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _C.outline)),
                    GestureDetector(
                      onTap: () => _goTab(1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(20)),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Tinjau Balita',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: _C.error)),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward,
                                size: 16, color: _C.error),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summarySection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.bolt,
                    size: 20, color: _C.primary),
                const SizedBox(width: 4),
                Text('Ringkasan Hari Ini',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            Text('Update 09:30 WIB',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10, color: _C.outline)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 168,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _statCard(
                context,
                icon: Icons.pending_actions,
                iconBg: const Color(0xFFFFF3E0),
                iconFg: const Color(0xFFE65100),
                value: '14',
                label: 'MENUNGGU VALIDASI',
                foot: 'Dari 4 Kader',
                footColor: const Color(0xFFE65100),
                dot: const Color(0xFFF9A825),
              ),
              const SizedBox(width: 10),
              _statCard(
                context,
                icon: Icons.warning,
                iconBg: _C.errorContainer
                    .withValues(alpha: 0.6),
                iconFg: _C.error,
                value: '6',
                valueColor: _C.error,
                label: 'BERMASALAH GIZI',
                foot: 'Stunting & Wasting',
                footColor: _C.error,
                badge: 'Atensi',
              ),
              const SizedBox(width: 10),
              _statCard(
                context,
                icon: Icons.event_available,
                iconBg: _C.primaryFixed,
                iconFg: _C.primary,
                value: '3',
                label: 'SESI AKTIF',
                foot: 'RW 01, 03, 05',
                footColor: _C.primary,
                dot: _C.tertiary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCard(
    BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
    required String value,
    Color valueColor = _C.onSurface,
    required String label,
    required String foot,
    required Color footColor,
    Color? dot,
    String? badge,
  }) {
    return GestureDetector(
      onTap: () => _goTab(1),
      child: Container(
        width: 148,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF651FFF)
                    .withValues(alpha: 0.05),
                blurRadius: 16,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                      color: iconBg,
                      borderRadius: BorderRadius.circular(12)),
                  child:
                      Icon(icon, size: 20, color: iconFg),
                ),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                        color: _C.errorContainer,
                        borderRadius:
                            BorderRadius.circular(8)),
                    child: Text(badge,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: _C.onErrorContainer)),
                  )
                else if (dot != null)
                  Container(
                      width: 8, height: 8,
                      decoration: BoxDecoration(
                          color: dot,
                          shape: BoxShape.circle)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                        color: valueColor)),
                Text(label,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: _C.outline)),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Text(foot,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: footColor),
                      overflow: TextOverflow.ellipsis),
                ),
                Icon(Icons.chevron_right,
                    size: 14, color: footColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _servicesSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.grid_view,
                    size: 20, color: _C.primary),
                const SizedBox(width: 4),
                Text('Layanan Klinis Bidan',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            Text('5 Fitur',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _C.primary)),
          ],
        ),
        const SizedBox(height: 10),
        // Hero: Validasi
        GestureDetector(
          onTap: () => _goTab(1),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                _C.primary,
                _C.secondary,
              ]),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: _C.primary
                        .withValues(alpha: 0.22),
                    blurRadius: 20,
                    offset: const Offset(0, 8)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                      color: Colors.white
                          .withValues(alpha: 0.15),
                      borderRadius:
                          BorderRadius.circular(16)),
                  child: const Icon(Icons.fact_check,
                      size: 26, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text('Validasi Pengukuran',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      SizedBox(height: 2),
                      Text(
                          '14 entri data baru dari kader butuh persetujuan',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70)),
                    ],
                  ),
                ),
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                      color: Colors.white
                          .withValues(alpha: 0.2),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.05,
          children: [
            _serviceCard(
              context,
              icon: Icons.calculate,
              bg: const Color(0xFFE0F2FE),
              fg: const Color(0xFF0277BD),
              title: 'Kalkulator Z-Score',
              desc: 'Standar kurva WHO & Kemenkes RI',
              tab: 2,
            ),
            _serviceCard(
              context,
              icon: Icons.query_stats,
              bg: const Color(0xFFFFF3E0),
              fg: const Color(0xFFE65100),
              title: 'Klasifikasi Gizi',
              desc: 'Stunting, Wasting, Underweight',
              tab: 2,
            ),
            _serviceCard(
              context,
              icon: Icons.note_alt,
              bg: const Color(0xFFE8F5E9),
              fg: const Color(0xFF00695C),
              title: 'Rekomendasi Medis',
              desc: 'Instruksi PMT & rujukan faskes',
              tab: null,
            ),
            _serviceCard(
              context,
              icon: Icons.bar_chart,
              bg: const Color(0xFFF3E5F5),
              fg: _C.secondary,
              title: 'Laporan Agregat',
              desc: 'Tren bulanan RW 01 - 06',
              tab: 3,
            ),
          ],
        ),
      ],
    );
  }

  Widget _serviceCard(
    BuildContext context, {
    required IconData icon,
    required Color bg,
    required Color fg,
    required String title,
    required String desc,
    int? tab,
  }) {
    return GestureDetector(
      onTap: () {
        if (tab != null) {
          _goTab(tab);
        } else {
          _toast(context, 'Fitur rekomendasi medis segera hadir');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF651FFF)
                    .withValues(alpha: 0.05),
                blurRadius: 16,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, size: 24, color: fg),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(desc,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: _C.outline),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _liveSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: _C.surfaceLow,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _LiveDot(),
                  SizedBox(width: 6),
                  Text('Posyandu Sedang Berjalan',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              Text('Live Hari Ini',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: _C.tertiary)),
            ],
          ),
          const SizedBox(height: 12),
          _liveItem(
              code: 'M03',
              title: 'Posyandu Melati 03',
              sub: 'Balai RW 03 • Kader: Bu Sumiati',
              right: '28 / 35',
              rightSub: 'Balita'),
          const SizedBox(height: 8),
          _liveItem(
              code: 'M01',
              title: 'Posyandu Mawar 01',
              sub: 'Rumah Kader RW 01 • Selesai',
              badge: '100% Selesai'),
        ],
      ),
    );
  }

  Widget _liveItem({
    required String code,
    required String title,
    required String sub,
    String? right,
    String? rightSub,
    String? badge,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                    color: _C.primaryFixed
                        .withValues(alpha: 0.5),
                    borderRadius:
                        BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: Text(code,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: _C.primary)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                  Text(sub,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: _C.outline)),
                ],
              ),
            ],
          ),
          if (badge != null)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(badge,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: _C.tertiary)),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(right ?? '',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: _C.primary)),
                Text(rightSub ?? '',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10, color: _C.outline)),
              ],
            ),
        ],
      ),
    );
  }
}

class _LiveDot extends StatelessWidget {
  const _LiveDot();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 10, height: 10,
        decoration: const BoxDecoration(
            color: _C.tertiary, shape: BoxShape.circle));
  }
}
