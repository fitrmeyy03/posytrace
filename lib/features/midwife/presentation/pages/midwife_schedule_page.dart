import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/shared/pages/notifications_page.dart';
import '../../../../core/shared/pages/profile_page.dart';

class _C {
  static const bg = Color(0xFFFDF7FF);
  static const primary = Color(0xFF632CE5);
  static const primaryFixed = Color(0xFFE8DEFF);
  static const secondary = Color(0xFF4B00CC);
  static const secondaryFixed = Color(0xFFE7DEFF);
  static const onSurface = Color(0xFF1D1A25);
  static const onSurfaceVariant = Color(0xFF494455);
  static const outline = Color(0xFF7A7487);
  static const surfaceLow = Color(0xFFF8F1FF);
  static const surfaceHighest = Color(0xFFE7E0EF);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF93000A);
  static const goodBg = Color(0xFFE8F5E9);
  static const good = Color(0xFF1B5E20);
}

class _Patient {
  final String initials;
  final Color avatarBg;
  final Color avatarFg;
  final String name;
  final String sex;
  final String age;
  final String mother;
  final String status; // stunting | wasting | underweight | normal
  final String diag;
  final String diagSub;
  final String bbu;
  final String bbuLabel;
  final String tbu;
  final String tbuLabel;
  final String bbtb;
  final String bbtbLabel;
  final List<double> trend; // 6 values 0..1 (0 top, 1 bottom)
  final List<String> months;
  const _Patient({
    required this.initials,
    required this.avatarBg,
    required this.avatarFg,
    required this.name,
    required this.sex,
    required this.age,
    required this.mother,
    required this.status,
    required this.diag,
    required this.diagSub,
    required this.bbu,
    required this.bbuLabel,
    required this.tbu,
    required this.tbuLabel,
    required this.bbtb,
    required this.bbtbLabel,
    required this.trend,
    required this.months,
  });
}

const _patients = [
  _Patient(
    initials: 'KA',
    avatarBg: _C.primaryFixed,
    avatarFg: _C.primary,
    name: 'Kenzo Alfarizi',
    sex: 'Laki-laki',
    age: '14 Bulan',
    mother: 'Ibu: Siska Melani (RW 03)',
    status: 'stunting',
    diag: 'Indikasi Stunting (TB/U Sangat Pendek)',
    diagSub: 'Perlu rujukan & intervensi PMT intensif',
    bbu: '-1.8 SD', bbuLabel: 'Risiko Kurang',
    tbu: '-2.4 SD', tbuLabel: 'Pendek (Stunting)',
    bbtb: '-0.6 SD', bbtbLabel: 'Gizi Baik (Normal)',
    trend: [0.42, 0.45, 0.50, 0.60, 0.66, 0.72],
    months: ['Des (9b)', 'Jan (10b)', 'Feb (11b)', 'Mar (12b)', 'Apr (13b)', 'Mei (14b)'],
  ),
  _Patient(
    initials: 'DH',
    avatarBg: Color(0xFFFFE0B2),
    avatarFg: Color(0xFFE65100),
    name: 'Dinda Humaira',
    sex: 'Perempuan',
    age: '8 Bulan',
    mother: 'Ibu: Ratna Sari (RW 01)',
    status: 'underweight',
    diag: 'Berat Kurang (BB/U Rendah)',
    diagSub: 'Perlu PMT dan konseling MP-ASI',
    bbu: '-2.1 SD', bbuLabel: 'Berat Kurang',
    tbu: '-1.2 SD', tbuLabel: 'Normal',
    bbtb: '-1.5 SD', bbtbLabel: 'Risiko Kurus',
    trend: [0.40, 0.44, 0.48, 0.52, 0.56, 0.60],
    months: ['Des (3b)', 'Jan (4b)', 'Feb (5b)', 'Mar (6b)', 'Apr (7b)', 'Mei (8b)'],
  ),
  _Patient(
    initials: 'MR',
    avatarBg: _C.secondaryFixed,
    avatarFg: _C.secondary,
    name: 'Muhammad Rayyan',
    sex: 'Laki-laki',
    age: '22 Bulan',
    mother: 'Ibu: Dewi Lestari (RW 04)',
    status: 'normal',
    diag: 'Tumbuh Normal Sesuai Usia',
    diagSub: 'Pertahankan pola gizi seimbang',
    bbu: '-0.3 SD', bbuLabel: 'Normal',
    tbu: '-0.5 SD', tbuLabel: 'Normal',
    bbtb: '0.1 SD', bbtbLabel: 'Gizi Baik',
    trend: [0.38, 0.38, 0.37, 0.37, 0.36, 0.36],
    months: ['Des (17b)', 'Jan (18b)', 'Feb (19b)', 'Mar (20b)', 'Apr (21b)', 'Mei (22b)'],
  ),
  _Patient(
    initials: 'AN',
    avatarBg: _C.goodBg,
    avatarFg: _C.good,
    name: 'Aisyah Nurfadilah',
    sex: 'Perempuan',
    age: '18 Bulan',
    mother: 'Ibu: Siti Rahma (RW 02)',
    status: 'wasting',
    diag: 'Indikasi Wasting (BB/TB Rendah)',
    diagSub: 'Perlu PMT pemulihan 90 hari',
    bbu: '-1.0 SD', bbuLabel: 'Risiko Kurang',
    tbu: '-0.8 SD', tbuLabel: 'Normal',
    bbtb: '-2.2 SD', bbtbLabel: 'Kurus (Wasting)',
    trend: [0.45, 0.48, 0.52, 0.58, 0.62, 0.68],
    months: ['Des (13b)', 'Jan (14b)', 'Feb (15b)', 'Mar (16b)', 'Apr (17b)', 'Mei (18b)'],
  ),
];

class MidwifeSchedulePage extends StatefulWidget {
  const MidwifeSchedulePage({super.key});

  @override
  State<MidwifeSchedulePage> createState() => _MidwifeSchedulePageState();
}

class _MidwifeSchedulePageState extends State<MidwifeSchedulePage> {
  final _search = TextEditingController();
  final _note = TextEditingController(
      text:
          'Pertumbuhan TB melandai sejak usia 11 bulan. Nafsu makan menurun pasca demam 2 minggu lalu. Jadwalkan temu dokter Puskesmas hari Kamis, 23 Mei 2024.');
  final _rws = ['RW 01', 'RW 02', 'RW 03', 'RW 04', 'RW 05', 'RW 06'];
  int _rw = 2;
  int _filter = 1; // 0 semua,1 stunting,2 wasting,3 underweight,4 normal
  int _active = 0;
  bool _pmt = true;
  bool _rujuk = true;
  bool _kunjungan = false;
  bool _saving = false;
  bool _saved = false;

  @override
  void dispose() {
    _search.dispose();
    _note.dispose();
    super.dispose();
  }

  List<_Patient> get _list {
    final q = _search.text.toLowerCase();
    return _patients.where((p) {
      final keys = ['semua', 'stunting', 'wasting', 'underweight', 'normal'];
      if (keys[_filter] != 'semua' && p.status != keys[_filter]) {
        return false;
      }
      if (q.isEmpty) return true;
      return (p.name + p.mother).toLowerCase().contains(q);
    }).toList();
  }

  _Patient get _p {
    final l = _list;
    if (l.isEmpty) return _patients[0];
    if (_active >= l.length) _active = 0;
    return l[_active];
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.plusJakartaSans(fontSize: 12)),
      backgroundColor: const Color(0xFF322F3A),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ));
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() {
      _saving = true;
      _saved = false;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() {
      _saving = false;
      _saved = true;
    });
    _toast('Rekomendasi tersimpan & tersinkron ke Kader');
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) setState(() => _saved = false);
  }

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
                _searchRow(),
                const SizedBox(height: 10),
                _chips(),
                const SizedBox(height: 12),
                if (_list.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    alignment: Alignment.center,
                    child: Text('Tidak ada balita cocok filter.',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: _C.onSurfaceVariant)),
                  )
                else ...[
                  _miniList(),
                  const SizedBox(height: 12),
                  _detailCard(),
                  const SizedBox(height: 12),
                  _chartCard(),
                  const SizedBox(height: 12),
                  _formCard(),
                ],
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

  Widget _searchRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
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
            child: TextField(
              controller: _search,
              onChanged: (_) =>
                  setState(() => _active = 0),
              decoration: InputDecoration(
                hintText: 'Cari balita, NIK, atau nama ibu...',
                hintStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: _C.outline),
                prefixIcon: const Icon(Icons.search,
                    size: 20, color: _C.outline),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            setState(() => _rw = (_rw + 1) % _rws.length);
            _toast('Filter wilayah: ${_rws[_rw]}');
          },
          child: Container(
            height: 48,
            padding:
                const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: _C.surfaceLow,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                const Icon(Icons.tune,
                    size: 20, color: _C.primary),
                const SizedBox(width: 4),
                Text(_rws[_rw],
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _C.primary)),
                const Icon(Icons.expand_more,
                    size: 16, color: _C.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _chips() {
    final defs = [
      {'label': 'Semua', 'count': '52'},
      {'label': 'Stunting', 'count': '4'},
      {'label': 'Wasting', 'count': '2'},
      {'label': 'Underweight', 'count': '5'},
      {'label': 'Normal', 'count': '41'},
    ];
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: defs.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final active = _filter == i;
          Color bg = _C.surfaceHighest;
          Color fg = _C.onSurfaceVariant;
          if (active) {
            if (i == 1) {
              bg = _C.errorContainer;
              fg = _C.onErrorContainer;
            } else if (i == 0) {
              bg = _C.onSurface;
              fg = Colors.white;
            } else if (i == 4) {
              bg = _C.goodBg;
              fg = _C.good;
            } else {
              bg = _C.primary;
              fg = Colors.white;
            }
          }
          return GestureDetector(
            onTap: () => setState(() {
              _filter = i;
              _active = 0;
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(20),
                  border: active && i == 1
                      ? Border.all(
                          color: _C.error
                              .withValues(alpha: 0.2))
                      : null),
              child: Row(
                children: [
                  if (i == 1)
                    Container(
                        width: 8, height: 8,
                        decoration: const BoxDecoration(
                            color: _C.error,
                            shape: BoxShape.circle)),
                  if (i == 1) const SizedBox(width: 6),
                  Text(defs[i]['label'] as String,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: fg)),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white
                            .withValues(alpha: 0.7),
                        borderRadius:
                            BorderRadius.circular(10)),
                    child: Text(
                        defs[i]['count'] as String,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: fg)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _miniList() {
    final l = _list;
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: l.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final sel = i == _active;
          return GestureDetector(
            onTap: () => setState(() => _active = i),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: sel ? _C.primary : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                        color: sel
                            ? Colors.white
                                .withValues(alpha: 0.2)
                            : l[i].avatarBg,
                        shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Text(l[i].initials,
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            color: sel
                                ? Colors.white
                                : l[i].avatarFg)),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(l[i].name,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: sel
                                  ? Colors.white
                                  : _C.onSurface)),
                      Text(l[i].age,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: sel
                                  ? Colors.white70
                                  : _C.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _detailCard() {
    final p = _p;
    final isStunting = p.status == 'stunting';
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF651FFF)
                  .withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(
                    color: p.avatarBg,
                    borderRadius: BorderRadius.circular(14)),
                alignment: Alignment.center,
                child: Text(p.initials,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: p.avatarFg)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(p.name,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                    Text('${p.sex} • ${p.age}',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: _C.onSurfaceVariant)),
                    Text(p.mother,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            color: _C.outline)),
                  ],
                ),
              ),
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                    color: _C.surfaceLow,
                    shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () => _toast(
                      'Lokasi ${p.name} dibagikan ke kader'),
                  icon: const Icon(Icons.share_location,
                      size: 19, color: _C.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isStunting
                  ? _C.errorContainer
                      .withValues(alpha: 0.6)
                  : _C.goodBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 24, height: 24,
                  decoration: BoxDecoration(
                      color: isStunting
                          ? _C.error
                          : _C.good,
                      shape: BoxShape.circle),
                  child: Icon(
                      isStunting
                          ? Icons.priority_high
                          : Icons.check,
                      size: 15, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(p.diag,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: isStunting
                                  ? _C.error
                                  : _C.good)),
                      Text(p.diagSub,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              color: isStunting
                                  ? _C.error.withValues(
                                      alpha: 0.8)
                                  : _C.good.withValues(
                                      alpha: 0.8))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                  child: _zBox(
                      'BB / U', p.bbu, p.bbuLabel,
                      const Color(0xFFFFFDE7),
                      const Color(0xFF9A7D0A),
                      const Color(0xFFFFF9C4),
                      const Color(0xFF827717))),
              const SizedBox(width: 8),
              Expanded(
                  child: _zBox(
                      'TB / U', p.tbu, p.tbuLabel,
                      _C.errorContainer
                          .withValues(alpha: 0.7),
                      _C.error, _C.error,
                      Colors.white,
                      solidBadge: isStunting)),
              const SizedBox(width: 8),
              Expanded(
                  child: _zBox(
                      'BB / TB', p.bbtb, p.bbtbLabel,
                      _C.goodBg.withValues(alpha: 0.7),
                      const Color(0xFF2E7D32),
                      const Color(0xFFC8E6C9),
                      const Color(0xFF1B5E20))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _zBox(String t, String v, String label, Color bg,
      Color vColor, Color badgeBg, Color badgeFg,
      {bool solidBadge = false}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(t,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: vColor)),
          const SizedBox(height: 4),
          Text(v,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: vColor)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
                color: solidBadge ? vColor : badgeBg,
                borderRadius: BorderRadius.circular(10)),
            child: Text(label,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: solidBadge
                        ? Colors.white
                        : badgeFg)),
          ),
        ],
      ),
    );
  }

  Widget _chartCard() {
    final p = _p;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF651FFF)
                  .withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 4)),
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
                    width: 28, height: 28,
                    decoration: BoxDecoration(
                        color: _C.primaryFixed,
                        borderRadius:
                            BorderRadius.circular(10)),
                    child: const Icon(
                        Icons.query_stats,
                        size: 17, color: _C.primary),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text('Kurva Pertumbuhan KMS',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w800)),
                      Text('TB menurut Usia (6 bln terakhir)',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              color: _C.outline)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: _C.primaryFixed,
                    borderRadius: BorderRadius.circular(12)),
                child: Text('${p.age.split(' ').first} Bln',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _C.primary)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Lapisan raster di-cache; painter hanya repaint
          // saat data kurva (points) benar-benar berubah.
          RepaintBoundary(
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: _C.surfaceLow
                      .withValues(alpha: 0.5),
                  borderRadius:
                      BorderRadius.circular(16)),
              child: CustomPaint(
                painter: _KmsPainter(points: p.trend),
                size: const Size(double.infinity, 150),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                p.months.length,
                (i) => Expanded(
                      child: Text(p.months[i],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 8,
                              fontWeight: i == 5
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                              color: i == 5
                                  ? _C.error
                                  : _C.outline)),
                    )),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Lg(color: Color(0xFF4CAF50), t: 'Hijau (Normal)'),
              SizedBox(width: 10),
              _Lg(color: Color(0xFFFBC02D), t: 'Kuning (-2 SD)'),
              SizedBox(width: 10),
              _Lg(color: _C.error, t: 'Merah (< -2 SD)'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _monthChip('Mei (Terbaru)', '72.4 cm',
                  '+0.2 cm (Flat)', _C.error),
              const SizedBox(width: 8),
              _monthChip('April', '72.2 cm', '+0.4 cm',
                  const Color(0xFF827717)),
              const SizedBox(width: 8),
              _monthChip('Maret', '71.8 cm', '+0.8 cm',
                  const Color(0xFF2E7D32)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _monthChip(
      String l, String v, String t, Color tc) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: _C.surfaceLow,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Text(l,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10, color: _C.outline)),
            Text(v,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
            Text(t,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: tc)),
          ],
        ),
      ),
    );
  }

  Widget _formCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF651FFF)
                  .withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: const BoxDecoration(
                    color: _C.secondaryFixed,
                    shape: BoxShape.circle),
                child: const Icon(Icons.edit_note,
                    size: 19, color: _C.secondary),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Intervensi & Rekomendasi Medis',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w800)),
                  Text('Catatan Bidan Wilayah Desa Sukamaju',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: _C.outline)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          _check(
              value: _pmt,
              onChanged: (v) =>
                  setState(() => _pmt = v ?? false),
              title: 'Resep PMT Pemulihan (90 Hari)',
              sub: 'Biskuit gizi, susu & telur ayam',
              icon: Icons.restaurant),
          const SizedBox(height: 8),
          _check(
              value: _rujuk,
              onChanged: (v) =>
                  setState(() => _rujuk = v ?? false),
              title: 'Rujukan Dokter Puskesmas',
              sub: 'Skrining infeksi / penyakit penyerta',
              icon: Icons.medical_services),
          const SizedBox(height: 8),
          _check(
              value: _kunjungan,
              onChanged: (v) => setState(
                  () => _kunjungan = v ?? false),
              title: 'Kunjungan Rumah Kader',
              sub: 'Edukasi sanitasi & pola asuh',
              icon: Icons.home),
          const SizedBox(height: 12),
          Text('Catatan Tambahan Bidan',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          TextField(
            controller: _note,
            maxLines: 3,
            decoration: InputDecoration(
              filled: true,
              fillColor: _C.surfaceLow,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.all(14),
            ),
            style: GoogleFonts.plusJakartaSans(fontSize: 13),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity, height: 52,
            child: ElevatedButton.icon(
              onPressed: _saving ? null : _save,
              icon: Icon(
                  _saving
                      ? Icons.sync
                      : _saved
                          ? Icons.done_all
                          : Icons.check_circle,
                  color: Colors.white),
              label: Text(
                  _saving
                      ? 'Menyimpan...'
                      : _saved
                          ? 'Tersimpan'
                          : 'Simpan Rekomendasi Medis',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _C.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
              ),
            ),
          ),
          if (_saved) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: _C.goodBg,
                  borderRadius: BorderRadius.circular(16)),
              child: const Row(
                children: [
                  Icon(Icons.verified,
                      size: 18, color: _C.good),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Rekomendasi tercatat & tersinkron ke Kader!',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _C.good),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _check(
      {required bool value,
      required ValueChanged<bool?> onChanged,
      required String title,
      required String sub,
      required IconData icon}) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: _C.surfaceLow,
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Checkbox(
                value: value,
                activeColor: _C.primary,
                onChanged: onChanged),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                  Text(sub,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: _C.onSurfaceVariant)),
                ],
              ),
            ),
            Icon(icon, size: 20, color: _C.primary),
          ],
        ),
      ),
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
            style: GoogleFonts.plusJakartaSans(fontSize: 10)),
      ],
    );
  }
}

class _KmsPainter extends CustomPainter {
  final List<double> points;
  _KmsPainter({required this.points});
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    // zones
    final zones = [
      [0.08, 0.38, const Color(0xFFE8F5E9).withValues(alpha: 0.8)],
      [0.38, 0.62, const Color(0xFFFFF9C4).withValues(alpha: 0.8)],
      [0.62, 0.95, const Color(0xFFFFEBEE).withValues(alpha: 0.8)],
    ];
    for (final z in zones) {
      canvas.drawRect(
          Rect.fromLTWH(16, h * (z[0] as double), w - 32,
              h * ((z[1] as double) - (z[0] as double))),
          Paint()..color = z[2] as Color);
    }
    // guideline
    final guide = Path();
    for (int i = 0; i <= 20; i++) {
      final x = 16 + (w - 32) * i / 20;
      final y = h * 0.30 + (h * 0.02) * (i / 20);
      if (i == 0) {
        guide.moveTo(x, y);
      } else {
        guide.lineTo(x, y);
      }
    }
    canvas.drawPath(
        guide,
        Paint()
          ..color = const Color(0xFF81C784)
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke);
    // trajectory
    final pts = List.generate(points.length, (i) {
      final x = 20 + (w - 40) * i / (points.length - 1);
      return Offset(x, h * points[i]);
    });
    final path = Path()..moveTo(pts[0].dx, pts[0].dy);
    for (int i = 1; i < pts.length; i++) {
      path.lineTo(pts[i].dx, pts[i].dy);
    }
    canvas.drawPath(
        path,
        Paint()
          ..color = const Color(0xFF632CE5)
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round);
    for (int i = 0; i < pts.length - 1; i++) {
      canvas.drawCircle(pts[i], 3.5, Paint()..color = Colors.white);
      canvas.drawCircle(
          pts[i],
          3.5,
          Paint()
            ..color = const Color(0xFF632CE5)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }
    final last = pts.last;
    canvas.drawCircle(
        last, 8,
        Paint()
          ..color =
              const Color(0xFFBA1A1A).withValues(alpha: 0.25));
    canvas.drawCircle(
        last, 5, Paint()..color = const Color(0xFFBA1A1A));
    canvas.drawCircle(
        last, 5,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  @override
  // Hanya repaint saat data kurva benar-benar berganti pasien;
  // setState lain (tab/filter/switch) tidak memicu repaint ulang.
  bool shouldRepaint(covariant _KmsPainter old) =>
      !listEquals(old.points, points);
}
