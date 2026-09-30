import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  static const tertiary = Color(0xFF226A55);
  static const tertiaryFixed = Color(0xFFABF1D7);
  static const onTertiaryContainer = Color(0xFF003E2F);
  static const error = Color(0xFFBA1A1A);
}

class GrowthPage extends StatefulWidget {
  const GrowthPage({super.key});

  @override
  State<GrowthPage> createState() => _GrowthPageState();
}

class _GrowthPageState extends State<GrowthPage> {
  int _tab = 0; // 0 KMS, 1 vaksin, 2 obat
  int _metric = 0; // 0 berat, 1 tinggi

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
                const SizedBox(height: 12),
                _childCard(),
                const SizedBox(height: 16),
                _tabs(),
                const SizedBox(height: 14),
                if (_tab == 0) _kmsModule(),
                if (_tab == 1) _vaksinModule(),
                if (_tab == 2) _obatModule(),
                const SizedBox(height: 16),
                _consultCta(),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('KMS & POSYANDU DIGITAL',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: _C.primary)),
              Text('Rekam Kesehatan',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3)),
            ],
          ),
          GestureDetector(
            onTap: () => _toast('Bantuan rekam kesehatan'),
            child: Container(
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
              child: const Icon(Icons.more_vert,
                  size: 20, color: _C.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Kartu anak ----------
  Widget _childCard() {
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
                  .withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 64, height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEFE5),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: _C.primaryContainer
                              .withValues(alpha: 0.4),
                          width: 3),
                    ),
                    alignment: Alignment.center,
                    child: Text('M',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: _C.primary)),
                  ),
                  Positioned(
                    bottom: -2, right: -2,
                    child: Container(
                      width: 20, height: 20,
                      decoration: BoxDecoration(
                        color: _C.tertiary,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: _C.surfaceLowest,
                            width: 2),
                      ),
                      child: const Icon(Icons.check,
                          size: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Mark Kalandra',
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.w700)),
                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4),
                          decoration: BoxDecoration(
                              color: _C.tertiaryFixed,
                              borderRadius:
                                  BorderRadius.circular(
                                      12)),
                          child: const Row(
                            mainAxisSize:
                                MainAxisSize.min,
                            children: [
                              _Dot(),
                              SizedBox(width: 4),
                              Text('Gizi Baik',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight:
                                          FontWeight.w700,
                                      color: _C
                                          .onTertiaryContainer)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text('2 Tahun 5 Bulan • Laki-laki',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: _C.outline)),
                    Text('ID Posyandu: #MEL-2024-089',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _C.primary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding:
                const EdgeInsets.only(top: 14),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _C.surfaceLow))),
            child: const Row(
              children: [
                Expanded(
                    child: _MiniMetric(
                        label: 'Berat Badan',
                        value: '15.0',
                        unit: 'kg',
                        valueColor:
                            _C.primaryContainer,
                        foot: 'Ideal (+0.3kg)',
                        footColor: _C.tertiary)),
                SizedBox(width: 10),
                Expanded(
                    child: _MiniMetric(
                        label: 'Tinggi Badan',
                        value: '118.0',
                        unit: 'cm',
                        valueColor: _C.secondary,
                        foot: 'Sesuai Umur',
                        footColor: _C.tertiary)),
                SizedBox(width: 10),
                Expanded(
                    child: _MiniMetric(
                        label: 'Lingkar Kepala',
                        value: '49.2',
                        unit: 'cm',
                        valueColor: _C.onSurface,
                        foot: 'Normocephal',
                        footColor: _C.outline)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Tabs ----------
  Widget _tabs() {
    final defs = [
      {'icon': Icons.query_stats, 'label': 'Grafik KMS'},
      {'icon': Icons.vaccines, 'label': 'Riwayat Vaksin'},
      {'icon': Icons.medication, 'label': 'Obat & Nutrisi'},
    ];
    return SizedBox(
      height: 44,
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
                    ? _C.primaryContainer
                    : _C.surfaceLowest,
                borderRadius: BorderRadius.circular(24),
                border: active
                    ? null
                    : Border.all(
                        color: _C.outlineVariant
                            .withValues(alpha: 0.4)),
                boxShadow: active
                    ? [
                        BoxShadow(
                            color: _C.primaryContainer
                                .withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset:
                                const Offset(0, 4))
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Icon(defs[i]['icon'] as IconData,
                      size: 18,
                      color: active
                          ? Colors.white
                          : _C.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text(defs[i]['label'] as String,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: active
                              ? Colors.white
                              : _C.onSurfaceVariant)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------- Modul 1: KMS ----------
  Widget _kmsModule() {
    final isBerat = _metric == 0;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text('STANDAR KEMENKES / WHO',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: _C.primary)),
                  Text('Kurva Pertumbuhan Balita',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: _C.surfaceLow,
                    borderRadius:
                        BorderRadius.circular(20)),
                child: Row(
                  children: [
                    _pillOpt('Berat', 0),
                    _pillOpt('Tinggi', 1),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _C.bg,
              border: Border.all(
                  color: _C.outlineVariant
                      .withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 12, height: 4,
                            decoration: BoxDecoration(
                                color: _C
                                    .primaryContainer,
                                borderRadius:
                                    BorderRadius.circular(
                                        2))),
                        const SizedBox(width: 4),
                        Text(
                            isBerat
                                ? 'Posisi Mark (15 kg)'
                                : 'Posisi Mark (118 cm)',
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight:
                                        FontWeight.w600)),
                        const SizedBox(width: 10),
                        Container(
                            width: 10, height: 10,
                            decoration: BoxDecoration(
                                color: _C.tertiaryFixed,
                                borderRadius:
                                    BorderRadius.circular(
                                        2))),
                        const SizedBox(width: 4),
                        Text('Rentang Normal WHO',
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 10,
                                    color: _C.outline)),
                      ],
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3),
                      decoration: BoxDecoration(
                          color: _C.tertiaryFixed
                              .withValues(alpha: 0.6),
                          borderRadius:
                              BorderRadius.circular(12)),
                      child: Text('Persentil 65%',
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight.w700,
                                  color: _C.tertiary)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    // Lapisan raster statis di-cache agar scroll mulus;
                    // painter sudah shouldRepaint=false.
                    RepaintBoundary(
                      child: SizedBox(
                        height: 176,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: _WarmKmsPainter(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 28, right: 44,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3),
                        decoration: BoxDecoration(
                            color: _C.onSurface,
                            borderRadius:
                                BorderRadius.circular(6)),
                        child: Text(
                            isBerat
                                ? 'Mark: 15.0 kg'
                                : 'Mark: 118 cm',
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 10,
                                    fontWeight:
                                        FontWeight.w700,
                                    color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 6),
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: _C
                                  .surfaceLow))),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      _xlab('12 Bln', false),
                      _xlab('18 Bln', false),
                      _xlab('24 Bln', false),
                      _xlab('29 Bln (Kini)', true),
                      _xlab('36 Bln', false),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: _C.surfaceLow,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.verified,
                    size: 20,
                    color: _C.primaryContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Kenaikan Berat Badan Memenuhi Syarat (KBM)',
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight.w700)),
                      Text(
                          'Mark mempertahankan kurva pita hijau stabil 6 bulan terakhir. Lanjutkan stimulasi nutrisi mikro & protein hewani.',
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 12,
                                  height: 1.4,
                                  color: _C
                                      .onSurfaceVariant)),
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

  Widget _pillOpt(String t, int i) {
    final active = _metric == i;
    return GestureDetector(
      onTap: () => setState(() => _metric = i),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: active
              ? _C.surfaceLowest
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: active
              ? [
                  const BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 4,
                      offset: Offset(0, 1))
                ]
              : null,
        ),
        child: Text(t,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: active
                    ? _C.primary
                    : _C.outline)),
      ),
    );
  }

  Widget _xlab(String t, bool hl) {
    return Text(t,
        style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight:
                hl ? FontWeight.w700 : FontWeight.w400,
            color: hl ? _C.primary : _C.outline));
  }

  // ---------- Modul 2: Vaksin ----------
  Widget _vaksinModule() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text('IMUNISASI DASAR & LANJUTAN',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: _C.primary)),
                  Text('Riwayat & Jadwal Vaksin',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: _C.secondaryFixed,
                    borderRadius:
                        BorderRadius.circular(16)),
                child: Text('8 / 10 Lengkap',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _C.onSecondaryFixed)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Kartu MMR mendatang
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                _C.primaryContainer,
                Color(0xFFF09855)
              ]),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: _C.primaryContainer
                        .withValues(alpha: 0.28),
                    blurRadius: 20,
                    offset: const Offset(0, 8)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.white
                              .withValues(alpha: 0.25),
                          borderRadius:
                              BorderRadius.circular(12)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.event,
                              size: 14,
                              color: Colors.white),
                          SizedBox(width: 4),
                          Text('3 Hari Lagi',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.white
                              .withValues(alpha: 0.2),
                          borderRadius:
                              BorderRadius.circular(10)),
                      child: Text('Wajib Lanjutan',
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 10,
                                  color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Vaksin MMR (Campak/Rubella)',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                Text('Dosis Booster Usia 2-3 Tahun',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: Colors.white
                            .withValues(alpha: 0.9))),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Colors.white
                                  .withValues(
                                      alpha: 0.2)))),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16,
                              color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                              'Posyandu Melati 04 • 08:30',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white)),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _toast(
                            'Alarm MMR dipasang untuk 23 April 08:30'),
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(
                                      20)),
                          child: Text('Pasang Alarm',
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight:
                                          FontWeight.w700,
                                      color: _C.primary)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text('Vaksinasi Terakhir yang Telah Diterima:',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _vaxRow('DPT-HB-Hib Lanjutan', 'Dosis ke-4 • Usia 18 Bulan',
              '14 Sep 2025'),
          const SizedBox(height: 8),
          _vaxRow('Polio Tetes (bOPV 4)', 'Puskesmas Bahagia • Sukses',
              '02 Mei 2025'),
          const SizedBox(height: 8),
          _vaxRow('Vaksin Dasar Lengkap', 'Posyandu Terpadu • Dokter Rina',
              '10 Jan 2025'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _toast(
                'Membuka Buku Kartu Imunisasi lengkap'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Lihat Buku Kartu Imunisasi Lengkap',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _C.primary)),
                const Icon(Icons.chevron_right,
                    size: 16, color: _C.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _vaxRow(String title, String sub, String date) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _C.bg,
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: const BoxDecoration(
                    color: _C.tertiaryFixed,
                    shape: BoxShape.circle),
                child: const Icon(Icons.done_all,
                    size: 16,
                    color: _C.onTertiaryContainer),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
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
          Text(date,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _C.tertiary)),
        ],
      ),
    );
  }

  // ---------- Modul 4: Obat ----------
  Widget _obatModule() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text('SUPLEMENTASI POSYANDU',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: _C.primary)),
                  Text('Obat & Nutrisi Harian',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              GestureDetector(
                onTap: () => _toast(
                    'Tambah catatan nutrisi segera hadir'),
                child: const Icon(Icons.add_circle,
                    size: 24, color: _C.primaryContainer),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _supRow(
            badge: 'A',
            badgeBg: _C.error,
            title: 'Vitamin A (Kapsul Merah 200.000 IU)',
            sub: 'Bulan Vitamin A Posyandu • Feb 2026',
            status: 'Sudah Diminum',
            statusBg: _C.tertiaryFixed,
            statusFg: _C.onTertiaryContainer,
          ),
          const SizedBox(height: 8),
          _supRow(
            badge: 'Zn',
            badgeBg: _C.secondaryFixed,
            badgeFg: _C.onSecondaryFixed,
            title: 'Zinc & Vitamin D3 Tetes',
            sub: '400 IU / Hari • Rutin Pagi Hari',
            status: 'Harian',
            statusBg: Colors.transparent,
            statusFg: _C.outline,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: _C.surfaceLow,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.restaurant,
                            size: 18,
                            color: _C.primary),
                        const SizedBox(width: 6),
                        Text(
                            "Evaluasi Piring 'Isi Piringku'",
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight.w700)),
                      ],
                    ),
                    Text('Seimbang',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _C.tertiary)),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Expanded(
                        child: _Plate(
                            icon: Icons.egg_alt,
                            iconColor:
                                _C.primaryContainer,
                            t: 'Protein',
                            s: '2 Telur + Ikan',
                            ok: true)),
                    SizedBox(width: 8),
                    Expanded(
                        child: _Plate(
                            icon: Icons.restaurant,
                            iconColor: _C.tertiary,
                            t: 'Sayur',
                            s: 'Bayam & Wortel',
                            ok: true)),
                    SizedBox(width: 8),
                    Expanded(
                        child: _Plate(
                            icon: Icons.bakery_dining,
                            iconColor:
                                _C.primaryContainer,
                            t: 'Karbo',
                            s: 'Nasi Lembek',
                            ok: false)),
                    SizedBox(width: 8),
                    Expanded(
                        child: _Plate(
                            icon: Icons.local_drink,
                            iconColor: _C.primary,
                            t: 'Cairan',
                            s: 'Air + 250ml Susu',
                            ok: true)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _supRow({
    required String badge,
    required Color badgeBg,
    Color badgeFg = Colors.white,
    required String title,
    required String sub,
    required String status,
    required Color statusBg,
    required Color statusFg,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: badge == 'A'
            ? _C.error.withValues(alpha: 0.06)
            : _C.bg,
        border: Border.all(
            color: badge == 'A'
                ? _C.error.withValues(alpha: 0.2)
                : _C.outlineVariant
                    .withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius:
                        BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: Text(badge,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: badgeFg)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
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
                horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: statusBg,
                borderRadius: BorderRadius.circular(12)),
            child: Text(status,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: statusFg)),
          ),
        ],
      ),
    );
  }

  Widget _consultCta() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity, height: 52,
          child: ElevatedButton.icon(
            onPressed: () => _toast(
                'Menghubungkan ke Bidan Desa / Kader...'),
            icon: const Icon(Icons.chat,
                size: 20, color: Colors.white),
            label: Text(
                'Konsultasi dengan Bidan Desa / Kader Posyandu',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _C.primaryContainer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
              elevation: 6,
              shadowColor: _C.primaryContainer
                  .withValues(alpha: 0.4),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
            'Sinkronisasi data otomatis dengan Sistem Informasi Posyandu Nasional',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 11, color: _C.outline)),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 6, height: 6,
        decoration: const BoxDecoration(
            color: _C.tertiary, shape: BoxShape.circle));
  }
}

class _MiniMetric extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color valueColor;
  final String foot;
  final Color footColor;
  const _MiniMetric({
    required this.label,
    required this.value,
    required this.unit,
    required this.valueColor,
    required this.foot,
    required this.footColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: _C.surfaceLow,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(label,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 11, color: _C.onSurfaceVariant)),
          const SizedBox(height: 2),
          RichText(
            text: TextSpan(
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: valueColor),
              children: [
                TextSpan(text: value),
                TextSpan(
                    text: ' $unit',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: _C.onSurfaceVariant)),
              ],
            ),
          ),
          Text(foot,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: footColor)),
        ],
      ),
    );
  }
}

class _Plate extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String t;
  final String s;
  final bool ok;
  const _Plate({
    required this.icon,
    required this.iconColor,
    required this.t,
    required this.s,
    required this.ok,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: _C.surfaceLowest,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(height: 4),
          Text(t,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700)),
          Text(s,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: ok
                      ? _C.tertiary
                      : _C.onSurfaceVariant)),
        ],
      ),
    );
  }
}

/// Kurva KMS warm: grid + pita hijau + median + kurva orange.
class _WarmKmsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    for (final y in [0.125, 0.375, 0.625, 0.875]) {
      canvas.drawLine(
          Offset(20, h * y), Offset(w - 10, h * y),
          Paint()
            ..color =
                _C.surfaceLow.withValues(alpha: 1)
            ..strokeWidth = 1);
    }

    // Pita normal hijau
    final band = Path()
      ..moveTo(20, h * 0.75)
      ..quadraticBezierTo(
          w * 0.31, h * 0.625, w * 0.56, h * 0.47)
      ..lineTo(w - 10, h * 0.19)
      ..lineTo(w - 10, h * 0.50)
      ..quadraticBezierTo(
          w * 0.69, h * 0.72, w * 0.38, h * 0.84)
      ..lineTo(20, h * 0.91)
      ..close();
    canvas.drawPath(
        band,
        Paint()
          ..color = _C.tertiaryFixed
              .withValues(alpha: 0.45));

    // Median dashed
    final med = Path()
      ..moveTo(20, h * 0.825)
      ..quadraticBezierTo(
          w * 0.34, h * 0.675, w * 0.625, h * 0.53)
      ..lineTo(w - 10, h * 0.34);
    _dashed(canvas, med);

    // Kurva Mark
    final line = Path()
      ..moveTo(20, h * 0.85)
      ..quadraticBezierTo(
          w * 0.28, h * 0.7375, w * 0.44, h * 0.6375)
      ..lineTo(w * 0.81, h * 0.3625);
    canvas.drawPath(
        line,
        Paint()
          ..color = _C.primaryContainer
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round);

    // Area bawah kurva
    final area = Path.from(line)
      ..lineTo(w * 0.81, h * 0.875)
      ..lineTo(20, h * 0.875)
      ..close();
    canvas.drawPath(
        area,
        Paint()
          ..color = _C.primaryContainer
              .withValues(alpha: 0.12));

    // Titik
    final pts = [
      Offset(20, h * 0.85),
      Offset(w * 0.25, h * 0.75),
      Offset(w * 0.44, h * 0.6375),
      Offset(w * 0.625, h * 0.50),
      Offset(w * 0.81, h * 0.3625),
    ];
    for (int i = 0; i < pts.length - 1; i++) {
      canvas.drawCircle(
          pts[i], 3.5, Paint()..color = Colors.white);
      canvas.drawCircle(
          pts[i],
          3.5,
          Paint()
            ..color = _C.primaryContainer
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5);
    }
    final last = pts.last;
    canvas.drawCircle(
        last, 6, Paint()..color = _C.primaryContainer);
    canvas.drawCircle(
        last, 6,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
    canvas.drawCircle(
        last, 2.5, Paint()..color = Colors.white);
  }

  void _dashed(Canvas canvas, Path path) {
    for (final m in path.computeMetrics()) {
      double d = 0;
      while (d < m.length) {
        canvas.drawPath(
            m.extractPath(d, d + 4),
            Paint()
              ..color = const Color(0xFF68AC94)
              ..strokeWidth = 2
              ..style = PaintingStyle.stroke);
        d += 6;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
