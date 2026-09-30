import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/shared/pages/notifications_page.dart';
import '../../../../core/shared/pages/profile_page.dart';

class _C {
  static const bg = Color(0xFFFDF7FF);
  static const primary = Color(0xFF632CE5);
  static const primaryFixed = Color(0xFFE8DEFF);
  static const onSurface = Color(0xFF1D1A25);
  static const onSurfaceVariant = Color(0xFF494455);
  static const outline = Color(0xFF7A7487);
  static const surfaceLow = Color(0xFFF8F1FF);
  static const surfaceHigh = Color(0xFFEDE5F5);
  static const surfaceHighest = Color(0xFFE7E0EF);
  static const tertiary = Color(0xFF00655A);
  static const tertiaryContainer = Color(0xFF008073);
  static const tertiaryFixed = Color(0xFF8DF5E4);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF93000A);
  static const warnBg = Color(0xFFFFF8E1);
  static const warnFg = Color(0xFFB78103);
}

class _Item {
  final String initials;
  final Color avatarBg;
  final Color avatarFg;
  final String name;
  final String meta;
  final String kader;
  final String time;
  final String bb;
  final String bbTrend;
  final bool bbDown;
  final String tb;
  final String tbTrend;
  final String lk;
  final String lkTrend;
  String status = 'menunggu';
  _Item({
    required this.initials,
    required this.avatarBg,
    required this.avatarFg,
    required this.name,
    required this.meta,
    required this.kader,
    required this.time,
    required this.bb,
    required this.bbTrend,
    this.bbDown = false,
    required this.tb,
    required this.tbTrend,
    required this.lk,
    required this.lkTrend,
  });
}

class MidwifeGrowthPage extends StatefulWidget {
  const MidwifeGrowthPage({super.key});

  @override
  State<MidwifeGrowthPage> createState() => _MidwifeGrowthPageState();
}

class _MidwifeGrowthPageState extends State<MidwifeGrowthPage> {
  int _tab = 0; // 0 menunggu, 1 divalidasi, 2 ditolak
  String? _expanded;

  final List<_Item> _items = [
    _Item(
      initials: 'KA',
      avatarBg: _C.tertiaryFixed,
      avatarFg: Color(0xFF00201C),
      name: 'Kenzo Alfarizi',
      meta: '14 Bulan • Laki-laki',
      kader: 'Kader Siti (Mawar 02)',
      time: '09:40 WIB',
      bb: '8.4', bbTrend: '-0.2 kg', bbDown: true,
      tb: '72.5', tbTrend: '+0.8 cm',
      lk: '44.0', lkTrend: 'Tetap',
    ),
    _Item(
      initials: 'DH',
      avatarBg: Color(0xFFFFE0B2),
      avatarFg: Color(0xFFE65100),
      name: 'Dinda Humaira',
      meta: '8 Bulan • Perempuan',
      kader: 'Kader Rahma (Melati 01)',
      time: '09:15 WIB',
      bb: '7.8', bbTrend: '+0.1 kg',
      tb: '68.2', tbTrend: '+0.4 cm',
      lk: '42.5', lkTrend: 'Tetap',
    ),
    _Item(
      initials: 'MR',
      avatarBg: _C.primaryFixed,
      avatarFg: _C.primary,
      name: 'Muhammad Rayyan',
      meta: '22 Bulan • Laki-laki',
      kader: 'Kader Dewi (Anggrek 04)',
      time: '08:50 WIB',
      bb: '11.6', bbTrend: '+0.3 kg',
      tb: '84.0', tbTrend: '+0.6 cm',
      lk: '47.8', lkTrend: 'Tetap',
    ),
    _Item(
      initials: 'AN',
      avatarBg: Color(0xFFE8F5E9),
      avatarFg: Color(0xFF2E7D32),
      name: 'Aisyah Nurfadilah',
      meta: '18 Bulan • Perempuan',
      kader: 'Kader Siti (Mawar 02)',
      time: '08:30 WIB',
      bb: '9.9', bbTrend: '+0.2 kg',
      tb: '78.5', tbTrend: '+0.5 cm',
      lk: '45.2', lkTrend: 'Tetap',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _expanded = _items.first.name;
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.plusJakartaSans(fontSize: 12)),
      backgroundColor: const Color(0xFF322F3A),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ));
  }

  List<_Item> get _filtered {
    if (_tab == 1) {
      return _items.where((e) => e.status == 'divalidasi').toList();
    }
    if (_tab == 2) {
      return _items.where((e) => e.status == 'ditolak').toList();
    }
    return _items.where((e) => e.status == 'menunggu').toList();
  }

  int get _cMenunggu =>
      _items.where((e) => e.status == 'menunggu').length;
  int get _cValid =>
      _items.where((e) => e.status == 'divalidasi').length + 38;
  int get _cTolak =>
      _items.where((e) => e.status == 'ditolak').length + 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _header()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _titleSection(),
                const SizedBox(height: 12),
                _tabs(),
                const SizedBox(height: 14),
                ..._cards(),
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

  Widget _titleSection() {
    final pending =
        _items.where((e) => e.status == 'menunggu').length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Validasi Pengukuran',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18, fontWeight: FontWeight.w700)),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: _C.primaryFixed,
                  borderRadius: BorderRadius.circular(20)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.local_hospital,
                      size: 14, color: _C.primary),
                  SizedBox(width: 4),
                  Text('Wilayah Bidan',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _C.primary)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '$pending data menunggu verifikasi dari 3 Posyandu hari ini.',
          style: GoogleFonts.plusJakartaSans(
              fontSize: 12, color: _C.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _tabs() {
    final tabs = [
      {'label': 'Menunggu', 'count': '$_cMenunggu'},
      {'label': 'Divalidasi', 'count': '$_cValid'},
      {'label': 'Ditolak', 'count': '$_cTolak'},
    ];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final active = _tab == i;
          return GestureDetector(
            onTap: () => setState(() => _tab = i),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: active
                    ? _C.primary
                    : _C.surfaceHigh,
                borderRadius: BorderRadius.circular(24),
                boxShadow: active
                    ? [
                        BoxShadow(
                            color: _C.primary
                                .withValues(alpha: 0.25),
                            blurRadius: 12,
                            offset: const Offset(0, 4))
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Text(tabs[i]['label'] as String,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: active
                              ? Colors.white
                              : _C.onSurfaceVariant)),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: i == 2 && !active
                          ? _C.errorContainer
                          : active
                              ? Colors.white
                                  .withValues(alpha: 0.2)
                              : _C.surfaceHighest,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                        tabs[i]['count'] as String,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: i == 2 && !active
                                ? _C.onErrorContainer
                                : active
                                    ? Colors.white
                                    : _C.onSurfaceVariant)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _cards() {
    final list = _filtered;
    if (list.isEmpty) {
      return [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)),
          alignment: Alignment.center,
          child: Text(
            _tab == 1
                ? 'Belum ada data yang divalidasi.'
                : 'Belum ada data yang ditolak.',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 13, color: _C.onSurfaceVariant),
          ),
        ),
      ];
    }
    return List.generate(list.length, (i) {
      final it = list[i];
      final expanded = _expanded == it.name && _tab == 0;
      return Padding(
        padding: EdgeInsets.only(
            bottom: i == list.length - 1 ? 0 : 14),
        child: _card(it, expanded),
      );
    });
  }

  Widget _card(_Item it, bool expanded) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF651FFF)
                  .withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                    color: it.avatarBg,
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(it.initials,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: it.avatarFg)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(it.name,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    Text(it.meta,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _C.onSurfaceVariant)),
                  ],
                ),
              ),
              if (_tab == 0)
                _statusChip()
              else if (_tab == 1)
                _doneChip('Divalidasi', _C.tertiaryContainer,
                    Colors.white)
              else
                _doneChip('Ditolak', _C.error, Colors.white),
              if (_tab == 0 && !expanded)
                IconButton(
                  onPressed: () => setState(
                      () => _expanded = it.name),
                  icon: const Icon(Icons.chevron_right,
                      color: _C.outline),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: _C.surfaceLow,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.volunteer_activism,
                    size: 18, color: _C.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: _C.onSurfaceVariant),
                      children: [
                        const TextSpan(text: 'Diinput '),
                        TextSpan(
                            text: it.kader.split('(').first.trim(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: _C.onSurface)),
                        TextSpan(
                            text:
                                ' (${it.kader.split('(').last}'),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(it.time,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 11, color: _C.outline)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (expanded)
            _gridDetail(it)
          else
            _gridCompact(it),
          if (expanded) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: _C.errorContainer
                      .withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12)),
              child: const Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning,
                      size: 18, color: _C.error),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Grafik BB turun di bawah kurva normal. Rekomendasikan konfirmasi ukur ulang atau konsultasi PMT.',
                      style: TextStyle(
                          fontSize: 11,
                          height: 1.4,
                          color: _C.onErrorContainer),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          it.status = 'ditolak';
                          _expanded = null;
                        });
                        _toast(
                            'Data ${it.name} ditolak, minta ukur ulang');
                      },
                      icon: const Icon(Icons.replay,
                          size: 18, color: _C.onErrorContainer),
                      label: Text('Tolak / Ukur',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _C.onErrorContainer)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _C.errorContainer,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(28)),
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          it.status = 'divalidasi';
                          _expanded = null;
                        });
                        _toast(
                            'Data ${it.name} disetujui & masuk KMS');
                      },
                      icon: const Icon(Icons.check_circle,
                          size: 18, color: Colors.white),
                      label: Text('Setujui Data',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _C.tertiaryContainer,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(28)),
                        elevation: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _statusChip() {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: _C.warnBg,
          borderRadius: BorderRadius.circular(20)),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.pending,
              size: 13, color: _C.warnFg),
          SizedBox(width: 4),
          Text('Menunggu',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: _C.warnFg)),
        ],
      ),
    );
  }

  Widget _doneChip(String t, Color bg, Color fg) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(t,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: fg)),
    );
  }

  Widget _gridDetail(_Item it) {
    return Row(
      children: [
        Expanded(
            child: _measure('Berat (BB)', it.bb, 'kg',
                it.bbTrend, it.bbDown, Icons.scale)),
        const SizedBox(width: 8),
        Expanded(
            child: _measure('Tinggi (TB)', it.tb, 'cm',
                it.tbTrend, false, Icons.straighten,
                up: true)),
        const SizedBox(width: 8),
        Expanded(
            child: _measure('Lingkar (LK)', it.lk, 'cm',
                it.lkTrend, false, Icons.circle_outlined,
                flat: true)),
      ],
    );
  }

  Widget _gridCompact(_Item it) {
    return Row(
      children: [
        Expanded(child: _mini('BB', it.bb, 'kg')),
        const SizedBox(width: 8),
        Expanded(child: _mini('TB', it.tb, 'cm')),
        const SizedBox(width: 8),
        Expanded(child: _mini('LK', it.lk, 'cm')),
      ],
    );
  }

  Widget _measure(String label, String v, String unit,
      String trend, bool down, IconData icon,
      {bool up = false, bool flat = false}) {
    final Color c = down
        ? _C.error
        : up
            ? _C.tertiary
            : _C.outline;
    final IconData ti =
        down ? Icons.trending_down : up ? Icons.trending_up : Icons.horizontal_rule;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: _C.surfaceLow,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10, color: _C.outline)),
              Icon(icon, size: 14, color: _C.primary),
            ],
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _C.onSurface),
              children: [
                TextSpan(text: v),
                TextSpan(
                    text: ' $unit',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _C.outline)),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(ti, size: 12, color: flat ? _C.outline : c),
              const SizedBox(width: 2),
              Text(trend,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: flat ? _C.outline : c)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mini(String l, String v, String u) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: _C.surfaceLow,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 10, color: _C.outline)),
          RichText(
            text: TextSpan(
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _C.onSurface),
              children: [
                TextSpan(text: v),
                TextSpan(
                    text: ' $u',
                    style: const TextStyle(
                        fontSize: 10,
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
