import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/shared/pages/notifications_page.dart';

class _C {
  static const bg = Color(0xFFFBF9F6);
  static const primary = Color(0xFF954A00);
  static const primaryContainer = Color(0xFFE8863A);
  static const onSurface = Color(0xFF1B1C1A);
  static const outline = Color(0xFF887366);
  static const outlineVariant = Color(0xFFDBC2B3);
  static const surfaceLow = Color(0xFFF5F3F0);
  static const surfaceLowest = Colors.white;
  static const tertiary = Color(0xFF226A55);
  static const tertiaryFixed = Color(0xFFABF1D7);
  static const onTertiaryFixedVariant = Color(0xFF00513E);
}

class DashboardPage extends StatelessWidget {
  final Function(int)? onTabChange;

  const DashboardPage({super.key, this.onTabChange});

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg,
          style: GoogleFonts.plusJakartaSans(fontSize: 12)),
      backgroundColor: const Color(0xFF30312F),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)),
    ));
  }

  void _go(int i) => onTabChange?.call(i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding:
                const EdgeInsets.fromLTRB(20, 8, 20, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _header(context),
                const SizedBox(height: 14),
                _greeting(),
                const SizedBox(height: 12),
                Text('Mark tumbuh hebat minggu ini! 🎉',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.3)),
                const SizedBox(height: 14),
                _childCard(context),
                const SizedBox(height: 16),
                _vaccineBanner(context),
                const SizedBox(height: 20),
                _bentoHeader(context),
                const SizedBox(height: 12),
                _bentoGrid(context),
                const SizedBox(height: 16),
                _partnerCard(context),
                const SizedBox(height: 8),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 36,
                  fit: BoxFit.contain,
                  errorBuilder: (ctx, err, stack) =>
                      const Icon(
                          Icons.child_care_rounded,
                          color: _C.primary),
                ),
              ),
              const SizedBox(width: 6),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      color: _C.onSurface),
                  children: const [
                    TextSpan(text: 'Posy'),
                    TextSpan(
                        text: 'Trace',
                        style: TextStyle(
                            color:
                                _C.primaryContainer)),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        const NotificationsPage())),
            child: Stack(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: _C.surfaceLowest,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFFB89678)
                              .withValues(alpha: 0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 8)),
                    ],
                  ),
                  child: const Icon(
                      Icons.notifications_outlined,
                      size: 22,
                      color: _C.onSurface),
                ),
                Positioned(
                  right: 10, top: 10,
                  child: Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(
                      color: _C.primaryContainer,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: _C.surfaceLowest,
                          width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _greeting() {
    return Row(
      children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            color: _C.primaryContainer
                .withValues(alpha: 0.25),
            shape: BoxShape.circle,
            border: Border.all(
                color: _C.outlineVariant
                    .withValues(alpha: 0.5)),
          ),
          alignment: Alignment.center,
          child: Text('IA',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _C.primary)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hai, Ibu Agnes',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            Text('Rabu, 28 April 2026',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _C.outline)),
          ],
        ),
      ],
    );
  }

  Widget _childCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFB89678)
                  .withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEFE5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: const Color(0xFFFCD8BE)
                              .withValues(alpha: 0.6)),
                    ),
                    alignment: Alignment.center,
                    child: Text('M',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: _C.primary)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Mark',
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.w700)),
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
                            child: Text('Gizi Baik',
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 10,
                                        fontWeight:
                                            FontWeight.w700,
                                        color: _C
                                            .onTertiaryFixedVariant)),
                          ),
                        ],
                      ),
                      Text('2 tahun 5 bulan',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: _C.outline)),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _go(1),
                child: Container(
                  width: 32, height: 32,
                  decoration: const BoxDecoration(
                      color: _C.surfaceLow,
                      shape: BoxShape.circle),
                  child: const Icon(Icons.north_east,
                      size: 18, color: _C.outline),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                  child: _Metric(
                      icon: Icons.male,
                      label: 'Gender',
                      value: 'Laki-laki')),
              SizedBox(width: 10),
              Expanded(
                  child: _Metric(
                      icon: Icons.scale,
                      label: 'Berat',
                      value: '15 kg')),
              SizedBox(width: 10),
              Expanded(
                  child: _Metric(
                      icon: Icons.straighten,
                      label: 'Tinggi',
                      value: '118 cm')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _vaccineBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8863A), Color(0xFFF09855)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: _C.primaryContainer
                  .withValues(alpha: 0.38),
              blurRadius: 24,
              offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white
                            .withValues(alpha: 0.2))),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _WhiteDot(),
                    SizedBox(width: 6),
                    Text('MENDATANG',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6,
                            color: Colors.white)),
                  ],
                ),
              ),
              Text('1 dari 2 terjadwal',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                          .withValues(alpha: 0.9))),
            ],
          ),
          const SizedBox(height: 12),
          Text('Jadwal Vaksin MMR (Campak)',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                  color: Colors.white)),
          Text('Dalam 3 Hari Lagi • Lindungi si kecil tepat waktu',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Container(
            padding:
                const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Colors.white
                            .withValues(alpha: 0.2)))),
            child: Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 17,
                    color: Colors.white70),
                const SizedBox(width: 6),
                Text('23 April 2026',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: Colors.white)),
                Text('  •  ',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: Colors.white
                            .withValues(alpha: 0.4))),
                const Icon(Icons.location_on,
                    size: 17,
                    color: Colors.white70),
                const SizedBox(width: 4),
                Expanded(
                  child: Text('Posyandu Melati',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bentoHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Layanan & Fitur',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            Text('Pantau setiap langkah kecil buah hati',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12, color: _C.outline)),
          ],
        ),
        GestureDetector(
          onTap: () =>
              _toast(context, 'Semua layanan segera hadir'),
          child: Row(
            children: [
              Text('Semua',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _C.primary)),
              const Icon(Icons.chevron_right,
                  size: 16, color: _C.primary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bentoGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.02,
      children: [
        _tile(
          context,
          icon: Icons.show_chart,
          iconBg: const Color(0xFFFFF3E8),
          iconFg: _C.primaryContainer,
          title: 'Grafik KMS',
          sub: 'Kurva Standar WHO',
          subIcon: Icons.check_circle,
          subColor: _C.tertiary,
          tab: 1,
        ),
        _tile(
          context,
          icon: Icons.vaccines,
          iconBg: const Color(0xFFE8F5E9),
          iconFg: _C.tertiary,
          title: 'Riwayat Vaksin',
          sub: 'Lengkap s/d 24 bln',
          tab: 2,
        ),
        _tile(
          context,
          icon: Icons.star,
          iconBg: const Color(0xFFFFF8E1),
          iconFg: const Color(0xFFF9A825),
          title: 'Tumbuh Kembang',
          sub: 'Milestone sesuai usia',
          tab: 1,
        ),
        _tile(
          context,
          icon: Icons.medication,
          iconBg: const Color(0xFFFCE4EC),
          iconFg: const Color(0xFFC44729),
          title: 'Obat & Nutrisi',
          sub: 'Vitamin A & Zinc aktif',
          tab: 3,
        ),
      ],
    );
  }

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
    required String title,
    required String sub,
    IconData? subIcon,
    Color? subColor,
    required int tab,
  }) {
    return GestureDetector(
      onTap: () => _go(tab),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _C.surfaceLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: _C.outlineVariant
                  .withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFFB89678)
                    .withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8)),
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
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                      color: iconBg,
                      borderRadius:
                          BorderRadius.circular(12)),
                  child:
                      Icon(icon, size: 22, color: iconFg),
                ),
                const Icon(Icons.arrow_outward,
                    size: 18, color: _C.outline),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (subIcon != null) ...[
                      Icon(subIcon,
                          size: 14,
                          color: subColor ??
                              _C.outline),
                      const SizedBox(width: 4),
                    ],
                    Flexible(
                      child: Text(sub,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight.w500,
                                  color: subColor ??
                                      _C.outline)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _partnerCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFB89678)
                  .withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                    color: const Color(0xFFFAF0E6),
                    borderRadius:
                        BorderRadius.circular(12)),
                child: const Icon(
                    Icons.local_hospital,
                    size: 20,
                    color: _C.primary),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text('Fasilitas Posyandu Aktif',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                  Text('Bidan Desa: Ibu Sri Wahyuni, Amd.Keb',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: _C.outline)),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () => _toast(
                context, 'Menghubungi Bidan Sri Wahyuni...'),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                  color: _C.surfaceLow,
                  borderRadius: BorderRadius.circular(20)),
              child: Text('Kontak',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _Metric(
      {required this.icon,
      required this.label,
      required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _C.surfaceLow.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 28, height: 28,
            decoration: const BoxDecoration(
                color: _C.surfaceLowest,
                borderRadius:
                    BorderRadius.all(Radius.circular(10))),
            child: Icon(icon,
                size: 17, color: _C.primaryContainer),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10, color: _C.outline)),
                Text(value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WhiteDot extends StatelessWidget {
  const _WhiteDot();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 8, height: 8,
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle));
  }
}
