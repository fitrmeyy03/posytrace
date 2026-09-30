import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/shared/pages/notifications_page.dart';
import '../../../../core/shared/pages/profile_page.dart';

class _C {
  static const bg = Color(0xFFFDF7FF);
  static const primary = Color(0xFF632CE5);
  static const primaryContainer = Color(0xFF7C4DFF);
  static const primaryFixed = Color(0xFFE8DEFF);
  static const onPrimaryFixed = Color(0xFF20005F);
  static const secondary = Color(0xFF4B00CC);
  static const onSurface = Color(0xFF1D1A25);
  static const onSurfaceVariant = Color(0xFF494455);
  static const outline = Color(0xFF7A7487);
  static const surfaceLow = Color(0xFFF8F1FF);
  static const surfaceHigh = Color(0xFFEDE5F5);
  static const tertiary = Color(0xFF00655A);
  static const tertiaryFixed = Color(0xFF8DF5E4);
  static const onTertiaryFixedVariant = Color(0xFF005048);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
}

class _Dist {
  final String name;
  final String total;
  final double normal;
  final double waspada;
  final double stunting;
  final String normalT;
  final String waspadaT;
  final String stuntingT;
  const _Dist({
    required this.name,
    required this.total,
    required this.normal,
    required this.waspada,
    required this.stunting,
    required this.normalT,
    required this.waspadaT,
    required this.stuntingT,
  });
}

const _dists = [
  _Dist(
      name: 'Melati RW 03', total: '68 Balita',
      normal: 0.80, waspada: 0.11, stunting: 0.09,
      normalT: '80.9%', waspadaT: '10.3%', stuntingT: '8.8% (6 Kasus)'),
  _Dist(
      name: 'Kenanga RW 01', total: '54 Balita',
      normal: 0.85, waspada: 0.10, stunting: 0.05,
      normalT: '85.2%', waspadaT: '9.3%', stuntingT: '5.5% (3 Kasus)'),
  _Dist(
      name: 'Mawar RW 02', total: '62 Balita',
      normal: 0.90, waspada: 0.05, stunting: 0.05,
      normalT: '90.3%', waspadaT: '4.8%', stuntingT: '4.9% (3 Kasus)'),
  _Dist(
      name: 'Anggrek RW 05', total: '64 Balita',
      normal: 0.93, waspada: 0.04, stunting: 0.03,
      normalT: '93.8%', waspadaT: '4.7%', stuntingT: '1.5% (1 Kasus)'),
];

class MidwifeArticlesPage extends StatefulWidget {
  const MidwifeArticlesPage({super.key});

  @override
  State<MidwifeArticlesPage> createState() =>
      _MidwifeArticlesPageState();
}

class _MidwifeArticlesPageState
    extends State<MidwifeArticlesPage>
    with SingleTickerProviderStateMixin {
  final _periods = ['Mei 2024', 'April 2024', 'Maret 2024'];
  final _regions = [
    'Semua RW', 'RW 01', 'RW 02', 'RW 03', 'RW 05'
  ];
  int _period = 0;
  int _region = 0;
  late AnimationController _spin;
  bool _exporting = false;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  List<_Dist> get _filtered {
    if (_region == 0) return _dists;
    final key = _regions[_region].split(' ').last;
    return _dists
        .where((d) => d.name.contains(key))
        .toList();
  }

  void _toast(String msg, {bool ok = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(ok ? Icons.check_circle : Icons.download,
              size: 18, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(msg,
                style:
                    GoogleFonts.plusJakartaSans(fontSize: 12)),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF322F3A),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)),
      duration: const Duration(seconds: 3),
    ));
  }

  void _refresh() {
    _spin.forward(from: 0);
    _toast('Data ${_periods[_period]} dimuat ulang');
  }

  void _export() {
    if (_exporting) return;
    setState(() => _exporting = true);
    _toast('Mengunduh Agregat_Sukamaju_Mei24.xlsx & PDF',
        ok: true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _exporting = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _header()),
          SliverPadding(
            padding:
                const EdgeInsets.fromLTRB(20, 8, 20, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _verifiedBanner(),
                const SizedBox(height: 12),
                _titleRow(),
                const SizedBox(height: 10),
                _filters(),
                const SizedBox(height: 16),
                _summary(),
                const SizedBox(height: 16),
                _distribution(),
                const SizedBox(height: 16),
                _priority(),
                const SizedBox(height: 16),
                _exportArea(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      height: 64,
      padding: const EdgeInsets.fromLTRB(20, 0, 12, 0),
      decoration: BoxDecoration(
        color: _C.surfaceLow.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF632CE5)
                  .withValues(alpha: 0.06),
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
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
                      icon: const Icon(
                          Icons.notifications_outlined,
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
                              color: _C.surfaceLow,
                              width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const ProfilePage())),
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

  Widget _verifiedBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _C.primaryFixed.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              _BadgeIcon(),
              SizedBox(width: 8),
              Text('Data Agregat Terverifikasi Kemenkes',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _C.onPrimaryFixed)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12)),
            child: Text('e-PPGBM',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: _C.primary)),
          ),
        ],
      ),
    );
  }

  Widget _titleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Laporan Wilayah',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3)),
            Text('Monitoring gizi & tumbuh kembang',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: _C.onSurfaceVariant)),
          ],
        ),
        GestureDetector(
          onTap: _refresh,
          child: Container(
            width: 40, height: 40,
            decoration: const BoxDecoration(
                color: _C.surfaceHigh,
                shape: BoxShape.circle),
            child: RotationTransition(
              turns: _spin,
              child: const Icon(Icons.sync,
                  size: 20, color: _C.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _filters() {
    return Row(
      children: [
        Expanded(
          child: _filterBtn(
            icon: Icons.calendar_month,
            label: _periods[_period],
            onTap: () {
              setState(() =>
                  _period = (_period + 1) % _periods.length);
              _toast('Periode: ${_periods[_period]}');
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _filterBtn(
            icon: Icons.location_on,
            label: _regions[_region],
            onTap: () {
              setState(() =>
                  _region = (_region + 1) % _regions.length);
            },
          ),
        ),
      ],
    );
  }

  Widget _filterBtn(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding:
            const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF651FFF)
                    .withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: _C.primary),
                const SizedBox(width: 6),
                Text(label,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            const Icon(Icons.arrow_drop_down,
                color: _C.outline),
          ],
        ),
      ),
    );
  }

  Widget _summary() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ringkasan Pemantauan',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
            Text('Total Sasaran: 254 Balita',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _C.outline)),
          ],
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.98,
          children: [
            _metric(
              icon: Icons.groups,
              iconBg: _C.primaryFixed,
              iconFg: _C.primary,
              value: '248',
              valueColor: _C.onSurface,
              label: 'Balita Dipantau',
              foot: '97.6% dari sasaran',
              footColor: _C.tertiary,
              badge: '+4%',
              badgeBg: _C.tertiaryFixed,
              badgeFg: _C.onTertiaryFixedVariant,
            ),
            _metric(
              icon: Icons.straighten,
              iconBg: _C.errorContainer,
              iconFg: _C.error,
              value: '7.2%',
              valueColor: _C.error,
              label: 'Prevalensi Stunting',
              foot: '18 Kasus terdata',
              footColor: _C.error,
              badge: '-1.1%',
              badgeBg: _C.tertiaryFixed,
              badgeFg: _C.onTertiaryFixedVariant,
            ),
            _metric(
              icon: Icons.scale,
              iconBg: _C.surfaceHigh,
              iconFg: _C.secondary,
              value: '3.6%',
              valueColor: _C.onSurface,
              label: 'Wasting (Kurang)',
              foot: '9 Kasus teridentifikasi',
              footColor: _C.onSurfaceVariant,
              badge: 'Stabil',
              badgeBg: _C.surfaceHigh,
              badgeFg: _C.onSurfaceVariant,
            ),
            _metric(
              icon: Icons.sentiment_very_satisfied,
              iconBg: _C.tertiaryFixed,
              iconFg: _C.tertiary,
              value: '89.2%',
              valueColor: _C.tertiary,
              label: 'Gizi Baik & Normal',
              foot: '221 Anak sehat',
              footColor: _C.tertiary,
              badge: '+1.8%',
              badgeBg: _C.tertiaryFixed,
              badgeFg: _C.onTertiaryFixedVariant,
            ),
          ],
        ),
      ],
    );
  }

  Widget _metric({
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
    required String value,
    required Color valueColor,
    required String label,
    required String foot,
    required Color footColor,
    required String badge,
    required Color badgeBg,
    required Color badgeFg,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF651FFF)
                  .withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 2)),
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
                width: 32, height: 32,
                decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(10)),
                child:
                    Icon(icon, size: 18, color: iconFg),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(badge,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: badgeFg)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                      color: valueColor)),
              Text(label,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12, color: _C.outline)),
            ],
          ),
          Text(foot,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: footColor)),
        ],
      ),
    );
  }

  Widget _distribution() {
    final list = _filtered;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF651FFF)
                  .withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Distribusi Gizi per Wilayah',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  Text('Proporsi status gizi posyandu',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: _C.onSurfaceVariant)),
                ],
              ),
              const Icon(Icons.info,
                  size: 18, color: _C.outline),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              _Lg(color: _C.tertiary, t: 'Normal'),
              SizedBox(width: 10),
              _Lg(color: _C.secondary, t: 'Waspada/Kurang'),
              SizedBox(width: 10),
              _Lg(color: _C.error, t: 'Stunting'),
            ],
          ),
          const SizedBox(height: 12),
          if (list.isEmpty)
            Text('Tidak ada data wilayah ini.',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: _C.onSurfaceVariant)),
          ...List.generate(list.length, (i) {
            final d = list[i];
            return Padding(
              padding: EdgeInsets.only(
                  bottom: i == list.length - 1 ? 0 : 14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(d.name,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      Text(d.total,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              color: _C.outline)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SizedBox(
                      height: 12,
                      child: Row(
                        children: [
                          Expanded(
                              flex: (d.normal * 100).round(),
                              child: Container(
                                  color: _C.tertiary)),
                          Expanded(
                              flex: (d.waspada * 100).round(),
                              child: Container(
                                  color: _C.secondary)),
                          Expanded(
                              flex: (d.stunting * 100)
                                  .round(),
                              child: Container(
                                  color: _C.error)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(d.normalT,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _C.tertiary)),
                      Text(d.waspadaT,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _C.secondary)),
                      Text(d.stuntingT,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _C.error)),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _priority() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.flag,
                    size: 20, color: _C.error),
                SizedBox(width: 4),
                Text('Prioritas Intervensi Wilayah',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: _C.errorContainer,
                  borderRadius: BorderRadius.circular(12)),
              child: Text('Perlu Aksi Segera',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: _C.error)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _rank(
          rank: '#1',
          badgeBg: _C.errorContainer,
          badgeFg: _C.error,
          title: 'Posyandu Melati 03',
          sub: 'Wilayah RW 03 Sukamaju',
          tag: '6 Kasus Stunting',
          tagBg: _C.errorContainer,
          tagFg: _C.error,
          note:
              'Perlu intervensi PMT Pemulihan & edukasi sanitasi keluarga.',
          noteIcon: Icons.priority_high,
        ),
        const SizedBox(height: 10),
        _rank(
          rank: '#2',
          badgeBg: _C.surfaceHigh,
          badgeFg: _C.secondary,
          title: 'Posyandu Kenanga 01',
          sub: 'Wilayah RW 01 Sukamaju',
          tag: '4 Kasus Wasting',
          tagBg: _C.primaryFixed,
          tagFg: _C.onPrimaryFixed,
          note:
              'Jadwalkan konseling gizi & rujukan poli gizi Puskesmas.',
          noteIcon: Icons.restaurant,
        ),
        const SizedBox(height: 10),
        _rank(
          rank: '#3',
          badgeBg: _C.surfaceHigh,
          badgeFg: _C.outline,
          title: 'Posyandu Mawar 02',
          sub: 'Wilayah RW 02 Sukamaju',
          tag: '3 Underweight',
          tagBg: _C.surfaceHigh,
          tagFg: _C.onSurfaceVariant,
          note:
              'Evaluasi pola asuh MP-ASI dan frekuensi penimbangan berikutnya.',
          noteIcon: Icons.child_care,
        ),
      ],
    );
  }

  Widget _rank({
    required String rank,
    required Color badgeBg,
    required Color badgeFg,
    required String title,
    required String sub,
    required String tag,
    required Color tagBg,
    required Color tagFg,
    required String note,
    required IconData noteIcon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF651FFF)
                  .withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 2)),
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
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius:
                            BorderRadius.circular(14)),
                    alignment: Alignment.center,
                    child: Text(rank,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: badgeFg)),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text(sub,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: _C.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: tagBg,
                    borderRadius: BorderRadius.circular(12)),
                child: Text(tag,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: tagFg)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: _C.surfaceLow,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Icon(noteIcon, size: 14, color: _C.error),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(note,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: _C.onSurfaceVariant)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _exportArea() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity, height: 52,
          child: ElevatedButton.icon(
            onPressed: _exporting ? null : _export,
            icon: Icon(
                _exporting
                    ? Icons.sync
                    : Icons.download_for_offline,
                color: Colors.white),
            label: Text(
                _exporting
                    ? 'Mengunduh...'
                    : 'Export Laporan Lengkap (PDF & Excel)',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _C.primaryContainer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text('Format standar pelaporan e-PPGBM Kemenkes RI',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12, color: _C.outline)),
      ],
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  const _BadgeIcon();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28, height: 28,
      decoration: const BoxDecoration(
          color: _C.primary, shape: BoxShape.circle),
      child: const Icon(Icons.verified,
          size: 16, color: Colors.white),
    );
  }
}

class _Lg extends StatelessWidget {
  final Color color;
  final String t;
  const _Lg({required this.color, required this.t});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 8, height: 8,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(t,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 10, color: _C.onSurfaceVariant)),
      ],
    );
  }
}
