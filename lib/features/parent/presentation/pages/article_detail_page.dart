import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _C {
  static const bg = Color(0xFFFBF9F6);
  static const primary = Color(0xFF954A00);
  static const primaryContainer = Color(0xFFE8863A);
  static const secondary = Color(0xFF914C0D);
  static const secondaryContainer = Color(0xFFFEA45F);
  static const secondaryFixed = Color(0xFFFFDCC5);
  static const onSecondaryFixedVariant = Color(0xFF713700);
  static const onSurface = Color(0xFF1B1C1A);
  static const onSurfaceVariant = Color(0xFF554338);
  static const outline = Color(0xFF887366);
  static const outlineVariant = Color(0xFFDBC2B3);
  static const surfaceLow = Color(0xFFF5F3F0);
  static const surfaceLowest = Colors.white;

  /// Bayangan kartu standar. Nilai ARGB (0x14 = alpha 0.08)
  /// diverifikasi identik dengan `Color(0xFFB89678).withValues(alpha: 0.08)`,
  /// sehingga aman dipakai sebagai const tanpa mengubah piksel.
  static const cardShadow = BoxShadow(
    color: Color(0x14B89678),
    blurRadius: 24,
    offset: Offset(0, 8),
  );
  static const tertiary = Color(0xFF226A55);
  static const tertiaryFixed = Color(0xFFABF1D7);
}

class ArticleDetailPage extends StatefulWidget {
  final String title;
  final String category;
  final String readTime;
  final String content;

  const ArticleDetailPage({
    super.key,
    required this.title,
    this.category = 'Kesehatan Anak',
    this.readTime = '5 menit',
    this.content = '',
  });

  @override
  State<ArticleDetailPage> createState() =>
      _ArticleDetailPageState();
}

class _ArticleDetailPageState
    extends State<ArticleDetailPage> {
  bool _saved = true;
  bool _playing = false;
  int _step = 0; // -1..2

  double get _bodySize {
    if (_step <= -1) return 14;
    if (_step == 1) return 18;
    if (_step >= 2) return 20;
    return 16;
  }

  String get _stepLabel {
    if (_step <= -1) return 'Ringkas';
    if (_step == 1) return 'Besar';
    if (_step >= 2) return 'Ekstra Besar';
    return 'Normal';
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg,
          style: GoogleFonts.plusJakartaSans(fontSize: 12)),
      backgroundColor: const Color(0xFF30312F),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: SafeArea(
          bottom: false,
          child: Container(
            color: _C.bg.withValues(alpha: 0.9),
            padding: const EdgeInsets.fromLTRB(
                20, 8, 20, 8),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                _roundBtn(Icons.arrow_back, () {
                  Navigator.pop(context);
                }),
                Text('Detail Artikel',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: () {
                    setState(() => _saved = !_saved);
                    _toast(_saved
                        ? 'Artikel disimpan'
                        : 'Dihapus dari simpanan');
                  },
                  child: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: _C.surfaceLowest,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        _C.cardShadow,
                      ],
                    ),
                    child: Icon(
                        _saved
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        size: 20,
                        color: _C.primaryContainer),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
                20, 8, 20, 120),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                _chip(),
                const SizedBox(height: 10),
                Text(widget.title,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.3)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.schedule,
                        size: 15, color: _C.outline),
                    const SizedBox(width: 4),
                    Text('${widget.readTime} baca',
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 12,
                                color: _C
                                    .onSurfaceVariant)),
                    Text('  •  ',
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 12,
                                color: _C.outline)),
                    Text('Diperbarui 24 Apr 2026',
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 12,
                                color: _C
                                    .onSurfaceVariant)),
                  ],
                ),
                const SizedBox(height: 14),
                _reviewer(),
                const SizedBox(height: 14),
                _hero(),
                const SizedBox(height: 18),
                _body(),
                const SizedBox(height: 20),
                _related(),
              ],
            ),
          ),
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    20, 0, 20, 20),
                child: Center(child: _readerBar()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: _C.surfaceLowest,
          shape: BoxShape.circle,
          boxShadow: [
                _C.cardShadow,
          ],
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }

  Widget _chip() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: _C.secondaryFixed,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.restaurant_menu,
              size: 16, color: _C.primary),
          const SizedBox(width: 4),
          Text(widget.category,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _C.onSecondaryFixedVariant)),
        ],
      ),
    );
  }

  Widget _reviewer() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: [
                        _C.cardShadow,
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: _C.primaryContainer
                      .withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: _C.secondaryFixed,
                      width: 2),
                ),
                alignment: Alignment.center,
                child: Text('TA',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
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
                          width: 2)),
                  child: const Icon(Icons.verified,
                      size: 12, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text('dr. Tiara Anindita, Sp.A',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                Text(
                    'Dokter Spesialis Anak • Ditinjau Tim Medis & Kemenkes',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: _C.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hero() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          const Color(0xFFFFEFE5),
          _C.primaryContainer.withValues(alpha: 0.35),
        ]),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
                        _C.cardShadow,
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(Icons.restaurant_menu,
                size: 72,
                color: _C.primaryContainer
                    .withValues(alpha: 0.5)),
          ),
          Positioned(
            left: 12, right: 12, bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                  color: Colors.white
                      .withValues(alpha: 0.9),
                  borderRadius:
                      BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.verified_user,
                          size: 16,
                          color: _C.primaryContainer),
                      SizedBox(width: 4),
                      Text(
                          'Rekomendasi Standar Buku KIA',
                          style: TextStyle(
                              fontSize: 11)),
                    ],
                  ),
                  Text('Tervalidasi',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _C.tertiary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    final s = _bodySize;
    final pStyle = GoogleFonts.plusJakartaSans(
        fontSize: s, height: 1.5, color: _C.onSurfaceVariant);
    final hStyle = GoogleFonts.plusJakartaSans(
        fontSize: 18, fontWeight: FontWeight.w700);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Memasuki usia dua tahun, si kecil dalam fase lonjakan eksplorasi fisik dan rasa ingin tahu yang tinggi. Menyajikan hidangan bergizi seimbang memastikan pertambahan tinggi badan optimal guna membentengi masa depannya dari risiko stunting.',
          style: pStyle,
        ),
        const SizedBox(height: 14),
        // Kotak bidan
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _C.secondaryFixed
                .withValues(alpha: 0.3),
            border: Border.all(
                color: _C.secondaryContainer
                    .withValues(alpha: 0.5)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40, height: 40,
                decoration: const BoxDecoration(
                    color: _C.secondaryContainer,
                    shape: BoxShape.circle),
                child: const Icon(Icons.lightbulb,
                    size: 22, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text('Kunci Penting Bidan Posyandu',
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 14,
                                fontWeight:
                                    FontWeight.w700,
                                color: _C.secondary)),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: s,
                                height: 1.4,
                                color: _C
                                    .onSurfaceVariant),
                        children: const [
                          TextSpan(
                              text:
                                  'Terapkan rumus '),
                          TextSpan(
                              text:
                                  'Protein Hewani Ganda',
                              style: TextStyle(
                                  fontWeight:
                                      FontWeight.w700,
                                  color: _C.onSurface)),
                          TextSpan(
                              text:
                                  '. Padukan telur dengan ikan kembung kukus atau ayam cincang agar asam amino esensial bekerja ganda!'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text('1. Mengapa Protein Hewani Krusial di Usia 2 Tahun?',
            style: hStyle),
        const SizedBox(height: 8),
        Text(
          'Asam amino esensial protein hewani memiliki bioavailabilitas tertinggi yang menstimulasi hormon pertumbuhan dan tulang panjang balita:',
          style: pStyle,
        ),
        const SizedBox(height: 8),
        _bullet('Ikan Kembung & Teri Segar:',
            ' Omega-3 dan kalsium setara hingga melampaui salmon impor.'),
        _bullet('1 Butir Telur Tiap Hari:',
            ' Suplai kolin bagi myelin otak dan otot padat.'),
        _bullet('Hati Ayam/Sapi:',
            ' Benteng pencegah anemia defisiensi besi pemicu GTM.'),
        const SizedBox(height: 14),
        // Quote
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _C.surfaceLowest,
            border: const Border(
                left: BorderSide(
                    color: _C.primaryContainer,
                    width: 4)),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16)),
            boxShadow: [
              _C.cardShadow,
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '“Konsistensi jam makan lebih penting daripada memaksa piring selalu habis licin.”',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      height: 1.4)),
              const SizedBox(height: 6),
              Text('— dr. Tiara Anindita, Sp.A',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _C.primary)),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text('2. Contoh Jadwal Makan Harian Balita Aktif',
            style: hStyle),
        const SizedBox(height: 8),
        Text(
          'Pola teratur menciptakan ritme lapar biologis alami sehingga anak tidak mudah rewel:',
          style: pStyle,
        ),
        const SizedBox(height: 8),
        _meal('07:00', Icons.wb_sunny,
            const Color(0xFFFFDCC6), 'Sarapan Utama',
            'Nasi lembek, telur orak-arik mentega, tumis labu siam, taburan teri.'),
        _meal('10:00', Icons.cookie,
            _C.secondaryFixed, 'Snack Bergizi Pagi',
            'Puding santan buah naga atau alpukat keruk dengan susu.'),
        _meal('12:30', Icons.restaurant,
            _C.tertiaryFixed, 'Makan Siang Komplit',
            'Sup bola ayam cincang & wortel, perkedel tahu, pepaya manis.'),
        _meal('18:30', Icons.nights_stay,
            const Color(0xFFEAE8E5), 'Makan Malam',
            'Nasi tim kembung bumbu kuning, bayam bening segar.'),
      ],
    );
  }

  Widget _bullet(String bold, String rest) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
                        _C.cardShadow,
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle,
              size: 20, color: _C.tertiary),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                    fontSize: _bodySize,
                    height: 1.4,
                    color: _C.onSurface),
                children: [
                  TextSpan(
                      text: bold,
                      style: const TextStyle(
                          fontWeight:
                              FontWeight.w700)),
                  TextSpan(text: rest),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _meal(String time, IconData icon, Color bg,
      String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
                        _C.cardShadow,
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            padding:
                const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Icon(icon, size: 16, color: _C.onSurface),
                Text(time,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                Text(desc,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        height: 1.4,
                        color: _C.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _related() {
    final items = [
      {
        'icon': Icons.local_drink,
        'bg': _C.tertiaryFixed,
        'fg': _C.tertiary,
        'cat': 'Tumbuh Kembang',
        'title': 'Kebutuhan Cairan & Susu Optimal untuk Usia 2 Tahun',
        'time': '3 mnt baca',
      },
      {
        'icon': Icons.cookie,
        'bg': _C.secondaryFixed,
        'fg': _C.secondary,
        'cat': 'Resep Sehat',
        'title': '7 Menu Camilan Tinggi Zat Besi Tanpa Gula Tambahan',
        'time': '4 mnt baca',
      },
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Artikel Terkait',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Text('Lihat Semua',
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
        ),
        const SizedBox(height: 8),
        ...List.generate(items.length, (i) {
          final it = items[i];
          return Padding(
            padding: EdgeInsets.only(
                bottom: i == items.length - 1 ? 0 : 8),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ArticleDetailPage(
                            title:
                                it['title'] as String,
                            category:
                                it['cat'] as String,
                            readTime: (it['time']
                                    as String)
                                .split(' ')
                                .first,
                          ))),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _C.surfaceLowest,
                  border: Border.all(
                      color: _C.outlineVariant
                          .withValues(alpha: 0.3)),
                  borderRadius:
                      BorderRadius.circular(16),
                  boxShadow: [
                  _C.cardShadow,
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 72, height: 72,
                      decoration: BoxDecoration(
                          color: it['bg'] as Color,
                          borderRadius:
                              BorderRadius.circular(
                                  12)),
                      child: Icon(it['icon'] as IconData,
                          size: 32,
                          color: it['fg'] as Color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                              (it['cat'] as String)
                                  .toUpperCase(),
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight:
                                          FontWeight.w700,
                                      letterSpacing: 0.4,
                                      color: _C.tertiary)),
                          Text(it['title'] as String,
                              maxLines: 2,
                              overflow: TextOverflow
                                  .ellipsis,
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.w700,
                                      height: 1.3)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.timer,
                                  size: 14,
                                  color: _C.outline),
                              const SizedBox(width: 2),
                              Text(it['time'] as String,
                                  style: GoogleFonts
                                      .plusJakartaSans(
                                          fontSize: 11,
                                          color: _C
                                              .outline)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: _C.outline),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _readerBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFA0785A)
                  .withValues(alpha: 0.16),
              blurRadius: 32,
              offset: const Offset(0, 12)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Font size
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
                color: _C.surfaceLow,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                _aBtn('A-', () {
                  setState(() => _step =
                      (_step - 1).clamp(-1, 2));
                  _toast('Ukuran teks: $_stepLabel');
                }),
                Container(
                    width: 1,
                    height: 12,
                    color: _C.outlineVariant
                        .withValues(alpha: 0.6)),
                _aBtn('A+', () {
                  setState(() => _step =
                      (_step + 1).clamp(-1, 2));
                  _toast('Ukuran teks: $_stepLabel');
                }),
              ],
            ),
          ),
          // Audio
          GestureDetector(
            onTap: () {
              setState(() => _playing = !_playing);
              _toast(_playing
                  ? 'Memutar narasi audio artikel...'
                  : 'Audio narasi dihentikan');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                  color: _C.primaryContainer,
                  borderRadius:
                      BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: _C.primaryContainer
                            .withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4)),
                  ]),
              child: Row(
                children: [
                  Icon(
                      _playing
                          ? Icons.pause_circle
                          : Icons.play_circle,
                      size: 18,
                      color: Colors.white),
                  const SizedBox(width: 4),
                  Text(_playing ? '04:12 Jeda' : 'Dengarkan',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
          // Save
          GestureDetector(
            onTap: () =>
                _toast('Tersimpan ke Koleksi Resep!'),
            child: Container(
              width: 36, height: 36,
              decoration: const BoxDecoration(
                  color: _C.surfaceLow,
                  shape: BoxShape.circle),
              child: const Icon(Icons.folder_special,
                  size: 20, color: _C.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _aBtn(String t, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28, height: 28,
        alignment: Alignment.center,
        child: Text(t,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
