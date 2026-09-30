import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/shared/pages/notifications_page.dart';

class _C {
  static const bg = Color(0xFFFBF9F6);
  static const primary = Color(0xFF954A00);
  static const primaryContainer = Color(0xFFE8863A);
  static const secondary = Color(0xFF914C0D);
  static const secondaryFixed = Color(0xFFFFDCC5);
  static const onSecondaryFixed = Color(0xFF301400);
  static const onSurface = Color(0xFF1B1C1A);
  static const onSurfaceVariant = Color(0xFF554338);
  static const outline = Color(0xFF887366);
  static const outlineVariant = Color(0xFFDBC2B3);
  static const surfaceLow = Color(0xFFF5F3F0);
  static const surfaceLowest = Colors.white;
  static const surfaceHigh = Color(0xFFEAE8E5);
  static const tertiary = Color(0xFF226A55);
  static const tertiaryFixed = Color(0xFFABF1D7);
  static const onTertiaryFixed = Color(0xFF002117);
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int _tab = 0; // 0 mendatang, 1 riwayat
  final List<bool> _checks = [true, true, true, false];
  int _day = 14;

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg,
          style: GoogleFonts.plusJakartaSans(fontSize: 12)),
      backgroundColor: const Color(0xFF30312F),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)),
    ));
  }

  int get _ready => _checks.where((e) => e).length;

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
                _appBar(),
                const SizedBox(height: 10),
                _pills(),
                const SizedBox(height: 12),
                _tabs(),
                const SizedBox(height: 14),
                if (_tab == 0) ...[
                  _hero(),
                  const SizedBox(height: 14),
                  _calendar(),
                  const SizedBox(height: 14),
                  _checklist(),
                  const SizedBox(height: 14),
                  _upcoming(),
                  const SizedBox(height: 14),
                  _lastVisit(),
                ] else
                  _history(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- App bar ----------
  Widget _appBar() {
    return SafeArea(
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Jadwal Posyandu',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4)),
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
                              .withValues(alpha: 0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 4)),
                    ],
                  ),
                  child: const Icon(
                      Icons.notifications_outlined,
                      size: 20,
                      color: _C.onSurfaceVariant),
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

  // ---------- Pills ----------
  Widget _pills() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _LocPill(),
        _ChildPill(),
      ],
    );
  }

  // ---------- Tabs ----------
  Widget _tabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _C.surfaceLow,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          _segTab(0, Icons.event, 'Jadwal Mendatang'),
          _segTab(1, Icons.history, 'Riwayat Kunjungan'),
        ],
      ),
    );
  }

  Widget _segTab(int i, IconData icon, String label) {
    final active = _tab == i;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tab = i),
        child: Container(
          padding:
              const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: active
                ? _C.surfaceLowest
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            boxShadow: active
                ? [
                    BoxShadow(
                        color: const Color(0xFFA0785A)
                            .withValues(alpha: 0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 2))
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 16,
                  color: active
                      ? _C.primary
                      : _C.outline),
              const SizedBox(width: 6),
              Flexible(
                child: Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: active
                            ? _C.primary
                            : _C.outline)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Hero ----------
  Widget _hero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color(0xFFE8863A),
          Color(0xFFED8F44),
          Color(0xFFF39C56),
        ]),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: _C.primaryContainer
                  .withValues(alpha: 0.38),
              blurRadius: 28,
              offset: const Offset(0, 12)),
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
                    color: Colors.white
                        .withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(20)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.alarm,
                        size: 15, color: Colors.white),
                    SizedBox(width: 4),
                    Text('SESI TERDEKAT',
                        style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.6,
                            color: Colors.white)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16)),
                child: Text('⏳ 3 Hari Lagi',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF582900))),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Rabu, 14 Mei 2026',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          Row(
            children: [
              const Icon(Icons.schedule,
                  size: 15,
                  color: Colors.white70),
              const SizedBox(width: 4),
              Text('08:30 - 11:30 WIB • Sesi Pagi Balita',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: Colors.white
                          .withValues(alpha: 0.9))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color:
                  Colors.white.withValues(alpha: 0.15),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AGENDA UTAMA SESI INI:',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        letterSpacing: 0.6,
                        color: Colors.white
                            .withValues(alpha: 0.8))),
                const SizedBox(height: 8),
                _agenda(Icons.check_circle,
                    'Penimbangan BB / TB (Pantau KMS Rutin)'),
                _agenda(Icons.vaccines,
                    'Booster Campak/Rubella (MMR) & Polio Tetes'),
                _agenda(Icons.medication,
                    'Pembagian Kapsul Vitamin A & Biskuit PMT'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12)),
            child: const Row(
              children: [
                Icon(Icons.pin_drop,
                    size: 18, color: Colors.white),
                SizedBox(width: 6),
                Expanded(
                  child: Text('Balai RW 05 (400m dari rumah)',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
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

  Widget _agenda(IconData icon, String t) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(t,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ---------- Kalender ----------
  Widget _calendar() {
    final days = [
      {'d': 'SEN', 'n': '11'},
      {'d': 'SEL', 'n': '12'},
      {'d': 'RAB', 'n': '13'},
      {'d': 'KAM', 'n': '14'},
      {'d': 'JUM', 'n': '15'},
      {'d': 'SAB', 'n': '16'},
      {'d': 'KAM', 'n': '28'},
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(24),
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
                  const Icon(Icons.calendar_month,
                      size: 20, color: _C.primary),
                  const SizedBox(width: 6),
                  Text('Mei 2026',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(
                          color: _C.primaryContainer,
                          shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text('Hari Posyandu (14 & 28 Mei)',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: _C.outline)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 76,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final n = int.parse(days[i]['n']!);
                final selected = _day == n;
                final upcoming = n == 28;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _day = n),
                  child: Container(
                    width: 52,
                    decoration: BoxDecoration(
                      color: selected
                          ? _C.primaryContainer
                          : _C.surfaceLow,
                      borderRadius:
                          BorderRadius.circular(16),
                      border: upcoming && !selected
                          ? Border.all(
                              color: _C.primary
                                  .withValues(alpha: 0.4))
                          : selected
                              ? Border.all(
                                  color: _C
                                      .primaryContainer,
                                  width: 2)
                              : null,
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                  color: _C
                                      .primaryContainer
                                      .withValues(
                                          alpha: 0.4),
                                  blurRadius: 14,
                                  offset: const Offset(
                                      0, 4))
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(days[i]['d']!,
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 10,
                                    fontWeight:
                                        FontWeight.w700,
                                    color: selected
                                        ? Colors.white
                                            .withValues(
                                                alpha: 0.9)
                                        : upcoming
                                            ? _C.primary
                                            : _C.outline)),
                        Text(days[i]['n']!,
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.w700,
                                    color: selected
                                        ? Colors.white
                                        : upcoming
                                            ? _C.primary
                                            : _C
                                                .onSurface)),
                        if (selected || upcoming)
                          Container(
                              width: 6, height: 6,
                              margin:
                                  const EdgeInsets.only(
                                      top: 2),
                              decoration: BoxDecoration(
                                  color: selected
                                      ? Colors.white
                                      : _C
                                          .primaryContainer,
                                  shape:
                                      BoxShape.circle)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Checklist ----------
  Widget _checklist() {
    final items = [
      {
        'icon': Icons.menu_book,
        'color': _C.tertiary,
        'title': 'Buku KIA / KMS Fisik',
        'sub': 'Atau QR KMS Digital dari aplikasi'
      },
      {
        'icon': Icons.checkroom,
        'color': _C.secondary,
        'title': 'Pakaian Nyaman & Berkancing Depan',
        'sub': 'Memudahkan suntik imunisasi'
      },
      {
        'icon': Icons.lunch_dining,
        'color': _C.primary,
        'title': 'Botol Minum & Snack Favorit',
        'sub': 'Mencegah rewel saat antre'
      },
      {
        'icon': Icons.device_thermostat,
        'color': _C.outline,
        'title': 'Cek Suhu Tubuh (Tidak Demam)',
        'sub': 'Vaksin hanya jika anak fit'
      },
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(24),
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
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text('Checklist Kunjungan',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  Text('Persiapan praktis sebelum berangkat',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: _C.outline)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: _C.tertiaryFixed,
                    borderRadius:
                        BorderRadius.circular(12)),
                child: Text('$_ready/4 Siap',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _C.onTertiaryFixed)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(items.length, (i) {
            final it = items[i];
            final on = _checks[i];
            return Padding(
              padding: EdgeInsets.only(
                  bottom: i == items.length - 1 ? 0 : 8),
              child: GestureDetector(
                onTap: () =>
                    setState(() => _checks[i] = !on),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _C.surfaceLow,
                    border: Border.all(
                        color: _C.outlineVariant
                            .withValues(alpha: 0.3)),
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: on,
                        activeColor:
                            _C.primaryContainer,
                        onChanged: (v) => setState(
                            () =>
                                _checks[i] = v ??
                                    false),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(it['title'] as String,
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 12,
                                        fontWeight:
                                            FontWeight.w600)),
                            Text(it['sub'] as String,
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 12,
                                        color: _C.outline)),
                          ],
                        ),
                      ),
                      Icon(it['icon'] as IconData,
                          size: 20,
                          color: it['color'] as Color),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ---------- Sesi mendatang ----------
  Widget _upcoming() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text('Jadwal Sesi Mendatang',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                Text('Agenda 1-2 bulan ke depan',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: _C.outline)),
              ],
            ),
            Text('Lihat Semua',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _C.primary)),
          ],
        ),
        const SizedBox(height: 10),
        _sessionCard(
          icon: Icons.medication,
          iconBg: _C.secondaryFixed,
          iconFg: _C.onSecondaryFixed,
          title: 'Kapsul Vitamin A & Obat Cacing',
          date: 'Kamis, 28 Mei 2026 • 09:00 - 11:30',
          staff: 'Petugas: Bidan Siti & Kader Dewi',
          badge: 'Terbuka',
          badgeBg: _C.tertiaryFixed,
          badgeFg: _C.onTertiaryFixed,
          loc: 'Balai RW 05 - Posyandu Melati',
          action: 'Detail Sesi',
          onAction: () =>
              _toast('Membuka detail sesi Vitamin A'),
        ),
        const SizedBox(height: 10),
        _sessionCard(
          icon: Icons.query_stats,
          iconBg: _C.tertiaryFixed.withValues(alpha: 0.4),
          iconFg: _C.tertiary,
          title: 'Penimbangan Rutin & Konseling Gizi',
          date: 'Minggu, 14 Juni 2026 • 08:30 - 11:00',
          staff: 'Fokus: Stunting & MPASI Sehat',
          badge: 'Segera Buka',
          badgeBg: _C.surfaceHigh,
          badgeFg: _C.outline,
          loc: 'Balai Warga Melati Blok C',
          action: 'Ingatkan Saya',
          actionIcon: Icons.notifications_outlined,
          onAction: () => _toast(
              'Pengingat sesi 14 Juni dipasang'),
        ),
      ],
    );
  }

  Widget _sessionCard({
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
    required String title,
    required String date,
    required String staff,
    required String badge,
    required Color badgeBg,
    required Color badgeFg,
    required String loc,
    required String action,
    IconData actionIcon = Icons.chevron_right,
    required VoidCallback onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(24),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius:
                        BorderRadius.circular(14)),
                child:
                    Icon(icon, size: 24, color: iconFg),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 14,
                                fontWeight:
                                    FontWeight.w700)),
                    Text(date,
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 12,
                                color: _C.outline)),
                    Text(staff,
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 12,
                                color: _C
                                    .onSurfaceVariant)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius:
                        BorderRadius.circular(12)),
                child: Text(badge,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: badgeFg)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding:
                const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _C.surfaceLow))),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(loc,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: _C.outline)),
                ),
                GestureDetector(
                  onTap: onAction,
                  child: Row(
                    children: [
                      Text(action,
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight.w700,
                                  color: _C.primary)),
                      Icon(actionIcon,
                          size: 16, color: _C.primary),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Kunjungan terakhir ----------
  Widget _lastVisit() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(24),
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
                    width: 32, height: 32,
                    decoration: const BoxDecoration(
                        color: _C.surfaceLow,
                        shape: BoxShape.circle),
                    child: const Icon(
                        Icons.check_circle,
                        size: 18,
                        color: _C.onSurfaceVariant),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text('Kunjungan Terakhir',
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight.w700)),
                      Text('12 April 2026 • Bidan Ratna',
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 12,
                                  color: _C.outline)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: _C.surfaceLow,
                    borderRadius:
                        BorderRadius.circular(12)),
                child: Text('KMS Tercatat',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10, color: _C.outline)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: _C.surfaceLow,
                borderRadius: BorderRadius.circular(16)),
            child: const Row(
              children: [
                Expanded(
                    child: _VisitMetric(
                        l: 'Berat Badan',
                        v: '15.0 kg',
                        t: '+300 gr ↗',
                        ok: true)),
                Expanded(
                    child: _VisitMetric(
                        l: 'Tinggi Badan',
                        v: '118 cm',
                        t: '+1.2 cm ↗',
                        ok: true)),
                Expanded(
                    child: _VisitMetric(
                        l: 'Imunisasi',
                        v: 'DPT-HB',
                        t: 'Tuntas ✓',
                        ok: false,
                        accent: true)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Riwayat ----------
  Widget _history() {
    final items = [
      {
        'date': '12 April 2026',
        'by': 'Bidan Ratna • Melati 04',
        'bb': '15.0 kg', 'tb': '118 cm', 'im': 'DPT-HB',
      },
      {
        'date': '15 Maret 2026',
        'by': 'Kader Dewi • Melati 04',
        'bb': '14.7 kg', 'tb': '116.8 cm', 'im': '-',
      },
      {
        'date': '10 Februari 2026',
        'by': 'Bidan Ratna • Melati 04',
        'bb': '14.4 kg', 'tb': '115.5 cm', 'im': 'Polio',
      },
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Riwayat Kunjungan',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: _C.surfaceLow,
                  borderRadius:
                      BorderRadius.circular(12)),
              child: Text('3 Kunjungan',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: _C.outline)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...List.generate(items.length, (i) {
          final it = items[i];
          return Padding(
            padding: EdgeInsets.only(
                bottom: i == items.length - 1 ? 0 : 10),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _C.surfaceLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFFB89678)
                          .withValues(alpha: 0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8)),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                            color: i == 0
                                ? _C.primaryContainer
                                    .withValues(
                                        alpha: 0.2)
                                : _C.surfaceLow,
                            borderRadius:
                                BorderRadius.circular(
                                    12)),
                        child: Icon(
                            Icons.event_note,
                            size: 20,
                            color: i == 0
                                ? _C.primary
                                : _C.outline),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(it['date'] as String,
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight
                                              .w700)),
                          Text(it['by'] as String,
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 12,
                                      color:
                                          _C.outline)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _hChip('BB', it['bb'] as String),
                      const SizedBox(width: 8),
                      _hChip('TB', it['tb'] as String),
                      const SizedBox(width: 8),
                      _hChip('Imun', it['im'] as String),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _hChip(String l, String v) {
    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: _C.surfaceLow,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(l,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10, color: _C.outline)),
            Text(v,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _LocPill extends StatelessWidget {
  const _LocPill();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: _C.surfaceLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on,
              size: 16, color: _C.primary),
          SizedBox(width: 4),
          Text('Melati 04 • Bahagia',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _C.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _ChildPill extends StatelessWidget {
  const _ChildPill();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: _C.surfaceLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.face,
              size: 15, color: _C.outline),
          SizedBox(width: 4),
          Text('Mark (2th 5bln)',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: _C.outline)),
        ],
      ),
    );
  }
}

class _VisitMetric extends StatelessWidget {
  final String l;
  final String v;
  final String t;
  final bool ok;
  final bool accent;
  const _VisitMetric({
    required this.l,
    required this.v,
    required this.t,
    required this.ok,
    this.accent = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(l,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 11, color: _C.outline)),
        Text(v,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w700)),
        Text(t,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: accent
                    ? _C.primary
                    : ok
                        ? _C.tertiary
                        : _C.outline)),
      ],
    );
  }
}
