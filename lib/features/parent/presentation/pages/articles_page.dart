import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'article_detail_page.dart';

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
  static const onTertiaryFixed = Color(0xFF002117);
  static const onTertiaryFixedVariant = Color(0xFF00513E);
}

class _Article {
  final String catKey;
  final String catLabel;
  final Color banner;
  final IconData bannerIcon;
  final String title;
  final String desc;
  final String author;
  final String authorInit;
  final String time;
  final String? rating;
  const _Article({
    required this.catKey,
    required this.catLabel,
    required this.banner,
    required this.bannerIcon,
    required this.title,
    required this.desc,
    required this.author,
    required this.authorInit,
    required this.time,
    this.rating,
  });
}

const _articles = [
  _Article(
    catKey: 'mpasi',
    catLabel: 'Gizi & Nutrisi',
    banner: Color(0xFFFFF3E8),
    bannerIcon: Icons.restaurant_menu,
    title:
        'Panduan Menu MPASI 4 Bintang untuk Cegah Stunting di Usia 2 Tahun',
    desc:
        'Proporsi karbohidrat, hewani, nabati, dan mikronutrien demi pertumbuhan linier optimal si kecil.',
    author: 'dr. Tiara Sp.A',
    authorInit: 'T',
    time: '5 mnt baca',
    rating: '4.9',
  ),
  _Article(
    catKey: 'mpasi',
    catLabel: 'Nutrisi Balita',
    banner: Color(0xFFE8F5E9),
    bannerIcon: Icons.eco,
    title:
        'Mengatasi Balita Picky Eater: Trik Menyenangkan Mengenalkan Sayur Hijau',
    desc: 'Strategi feeding rules dan variasi tekstur tanpa drama.',
    author: 'Bidan Siti, A.Md.Keb',
    authorInit: 'S',
    time: '3 mnt baca',
  ),
  _Article(
    catKey: 'tumbuh',
    catLabel: 'Stimulasi Bahasa',
    banner: Color(0xFFE3F2FD),
    bannerIcon: Icons.record_voice_over,
    title:
        'Stimulasi Bicara 2-3 Tahun: Kapan Perlu Waspada Speech Delay?',
    desc: 'Red flags bahasa dan stimulasi harian di rumah.',
    author: 'dr. Hendra, Sp.A',
    authorInit: 'H',
    time: '6 mnt baca',
  ),
  _Article(
    catKey: 'tidur',
    catLabel: 'Pola Tidur',
    banner: Color(0xFFF3E5F5),
    bannerIcon: Icons.bedtime,
    title:
        'Menjaga Kualitas Tidur Malam Si Kecil Tanpa Rewel & Bangun Tengah Malam',
    desc: 'Sleep hygiene dan rutinitas malam yang menenangkan.',
    author: 'Konselor Anak',
    authorInit: 'K',
    time: '4 mnt baca',
  ),
];

const _filters = [
  'Semua',
  'Gizi & MPASI',
  'Pola Tidur',
  'Tumbuh Kembang',
  'Vaksinasi',
  'Kesehatan Gigi',
];

const _filterKeys = [
  'all',
  'mpasi',
  'tidur',
  'tumbuh',
  'vaksin',
  'gigi',
];

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final _search = TextEditingController();
  int _filter = 0;
  final Set<int> _bookmarks = {2};

  /// Query yang sudah di-debounce; daftar hasil hanya rebuild
  /// dari nilai ini, bukan dari tiap ketikan keyboard.
  String _query = '';
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  /// Dipanggil tiap ketikan; setState hanya jalan 300ms setelah
  /// pengguna berhenti mengetik.
  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _query = value);
    });
  }

  List<_Article> get _list {
    final key = _filterKeys[_filter];
    final q = _query.toLowerCase();
    return _articles.where((a) {
      if (key != 'all' && a.catKey != key) return false;
      if (q.isEmpty) return true;
      return (a.title + a.author).toLowerCase().contains(q);
    }).toList();
  }

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

  void _open(_Article a) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ArticleDetailPage(
                  title: a.title,
                  category: a.catLabel,
                  readTime: a.time.split(' ').first,
                )));
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
                _searchBar(),
                const SizedBox(height: 10),
                _chips(),
                const SizedBox(height: 18),
                _spotlightHead(),
                const SizedBox(height: 10),
                if (_filter == 0 && _query.isEmpty)
                  _featured(),
                if (_filter == 0 && _query.isEmpty)
                  const SizedBox(height: 20),
                _recoHead(),
                const SizedBox(height: 10),
                ..._cards(),
                const SizedBox(height: 20),
                _kilatHead(),
                const SizedBox(height: 10),
                _kilat(),
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
              Text('TIPS DOKTER & KADER POSYANDU',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                      color: _C.primary)),
              Text('Edukasi & Panduan',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4)),
            ],
          ),
          Row(
            children: [
              _iconBtn(Icons.search, () {
                _toast('Ketik di kolom pencarian di bawah');
              }),
              const SizedBox(width: 8),
              _iconBtn(Icons.bookmark, () {
                _toast(
                    '${_bookmarks.length} artikel tersimpan');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: _C.surfaceLowest,
          shape: BoxShape.circle,
          border: Border.all(
              color:
                  _C.outlineVariant.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFFB89678)
                    .withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, 4)),
          ],
        ),
        child:
            Icon(icon, size: 20, color: _C.onSurfaceVariant),
      ),
    );
  }

  // ---------- Search ----------
  Widget _searchBar() {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFB89678)
                  .withValues(alpha: 0.10),
              blurRadius: 20,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(Icons.search,
                size: 22, color: _C.outline),
          ),
          Expanded(
            child: TextField(
              controller: _search,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText:
                    'Cari topik gizi, MPASI, imunisasi...',
                hintStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: _C.outline
                        .withValues(alpha: 0.7)),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
              ),
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () =>
                _toast('Filter kategori segera hadir'),
            child: Container(
              width: 32, height: 32,
              decoration: const BoxDecoration(
                  color: _C.surfaceLow,
                  shape: BoxShape.circle),
              child: const Icon(Icons.tune,
                  size: 18,
                  color: _C.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Chips ----------
  Widget _chips() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final active = _filter == i;
          return GestureDetector(
            onTap: () => setState(() => _filter = i),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 9),
              decoration: BoxDecoration(
                color: active
                    ? _C.primaryContainer
                    : _C.surfaceLowest,
                borderRadius: BorderRadius.circular(20),
                border: active
                    ? null
                    : Border.all(
                        color: _C.outlineVariant
                            .withValues(alpha: 0.5)),
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
              child: Text(_filters[i],
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: active
                          ? Colors.white
                          : _C.onSurfaceVariant)),
            ),
          );
        },
      ),
    );
  }

  // ---------- Sorotan ----------
  Widget _spotlightHead() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            _PulseDot(),
            SizedBox(width: 6),
            Text('Sorotan Posyandu',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
          ],
        ),
        GestureDetector(
          onTap: () =>
              _toast('Memuat semua sorotan...'),
          child: Text('Lihat Semua',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _C.primary)),
        ),
      ],
    );
  }

  Widget _featured() {
    final a = _articles[0];
    final saved = _bookmarks.contains(0);
    return GestureDetector(
      onTap: () => _open(a),
      child: Container(
        decoration: BoxDecoration(
          color: _C.surfaceLowest,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color:
                  _C.outlineVariant.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFFB89678)
                    .withValues(alpha: 0.14),
                blurRadius: 24,
                offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner (ilustrasi ikon, tanpa foto)
            Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  a.banner,
                  _C.primaryContainer
                      .withValues(alpha: 0.25),
                ]),
                borderRadius:
                    const BorderRadius.vertical(
                        top: Radius.circular(24)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(a.bannerIcon,
                        size: 64,
                        color: _C.primaryContainer
                            .withValues(alpha: 0.6)),
                  ),
                  Positioned(
                    top: 12, left: 12,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5),
                      decoration: BoxDecoration(
                          color: _C.primaryContainer,
                          borderRadius:
                              BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: _C.primaryContainer
                                    .withValues(
                                        alpha: 0.4),
                                blurRadius: 8,
                                offset: const Offset(
                                    0, 2)),
                          ]),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified,
                              size: 14,
                              color: Colors.white),
                          SizedBox(width: 4),
                          Text('Pilihan Bidan Desa',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight.w700,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12, right: 12,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (saved) {
                            _bookmarks.remove(0);
                          } else {
                            _bookmarks.add(0);
                          }
                        });
                        _toast(saved
                            ? 'Bookmark dihapus'
                            : 'Artikel disimpan');
                      },
                      child: Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(
                            color: Colors.white
                                .withValues(alpha: 0.9),
                            shape: BoxShape.circle),
                        child: Icon(
                            saved
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 18,
                            color: _C.primary),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12, left: 12,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.white
                              .withValues(alpha: 0.8),
                          borderRadius:
                              BorderRadius.circular(8)),
                      child: Text(a.catLabel,
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(a.title,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.3)),
                  const SizedBox(height: 6),
                  Text(a.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          height: 1.4,
                          color: _C.onSurfaceVariant)),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: _C.outlineVariant
                                    .withValues(
                                        alpha: 0.3)))),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24, height: 24,
                              decoration:
                                  const BoxDecoration(
                                      color: _C
                                          .primaryContainer,
                                      shape:
                                          BoxShape.circle),
                              alignment: Alignment.center,
                              child: Text(a.authorInit,
                                  style: GoogleFonts
                                      .plusJakartaSans(
                                          fontSize: 10,
                                          fontWeight:
                                              FontWeight
                                                  .w700,
                                          color: Colors
                                              .white)),
                            ),
                            const SizedBox(width: 6),
                            Text(a.author,
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 12,
                                        fontWeight:
                                            FontWeight.w500)),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 16,
                                color:
                                    _C.primaryContainer),
                            const SizedBox(width: 2),
                            Text(a.rating ?? '',
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 10,
                                        fontWeight:
                                            FontWeight
                                                .w700,
                                        color: _C
                                            .secondary)),
                            const SizedBox(width: 8),
                            const Icon(Icons.schedule,
                                size: 16,
                                color: _C.outline),
                            const SizedBox(width: 2),
                            Text(a.time,
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 10,
                                        color: _C.outline)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Rekomendasi ----------
  Widget _recoHead() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  color: _C.tertiaryFixed,
                  borderRadius: BorderRadius.circular(12)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.child_care,
                      size: 13,
                      color: _C.onTertiaryFixedVariant),
                  SizedBox(width: 4),
                  Text('Fase Mark: 2 Th 5 Bln',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _C
                              .onTertiaryFixedVariant)),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text('Rekomendasi Tumbuh Kembang',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
          ],
        ),
        GestureDetector(
          onTap: () =>
              _toast('Memuat semua rekomendasi...'),
          child: Text('Lihat Semua',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _C.primary)),
        ),
      ],
    );
  }

  List<Widget> _cards() {
    final list = _list;
    // Saat filter Semua + tanpa query, sorotan sudah tampilkan artikel 0
    final show =
        (_filter == 0 && _query.isEmpty)
            ? list.skip(1).toList()
            : list;
    if (show.isEmpty) {
      return [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: _C.surfaceLowest,
              borderRadius: BorderRadius.circular(24)),
          alignment: Alignment.center,
          child: Text(
            'Belum ada artikel untuk topik ini.',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 13, color: _C.onSurfaceVariant),
          ),
        ),
      ];
    }
    return List.generate(show.length, (i) {
      final a = show[i];
      final gi = _articles.indexOf(a);
      return _ArticleCard(
        article: a,
        saved: _bookmarks.contains(gi),
        last: i == show.length - 1,
        onTap: () => _open(a),
        onToggleSave: () => _toggleSave(gi),
      );
    });
  }

  void _toggleSave(int gi) {
    final wasSaved = _bookmarks.contains(gi);
    setState(() {
      if (wasSaved) {
        _bookmarks.remove(gi);
      } else {
        _bookmarks.add(gi);
      }
    });
    _toast(wasSaved ? 'Bookmark dihapus' : 'Artikel disimpan');
  }

  // ---------- Panduan kilat ----------
  Widget _kilatHead() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(Icons.bolt,
                size: 20, color: _C.primaryContainer),
            SizedBox(width: 4),
            Text('Panduan Kilat Posyandu',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
          ],
        ),
        Text('Swipe',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _C.primary)),
      ],
    );
  }

  Widget _kilat() {
    final items = [
      {
        'icon': Icons.medication,
        'bg1': const Color(0xFFFFDCC6),
        'bg2': const Color(0xFFFFB786),
        'tag': 'Bulan Kapsul Merah',
        'title': 'Jadwal & Manfaat Vitamin A',
        'foot': '2 Mnt Infografis',
        'fg': _C.onSurface,
      },
      {
        'icon': Icons.thermostat,
        'bg1': _C.tertiaryFixed,
        'bg2': const Color(0xFF68AC94),
        'tag': 'P3K Bunda',
        'title': 'Trik Redakan Demam Pasca Imunisasi',
        'foot': '3 Mnt Video',
        'fg': _C.onTertiaryFixed,
      },
      {
        'icon': Icons.restaurant,
        'bg1': _C.secondaryFixed,
        'bg2': const Color(0xFFFFB784),
        'tag': 'Kemenkes RI',
        'title': 'Porsi Ideal Isi Piringku Balita',
        'foot': '1 Mnt Panduan',
        'fg': _C.onSecondaryFixed,
      },
    ];
    return SizedBox(
      height: 204,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final it = items[i];
          return GestureDetector(
            onTap: () => _toast(
                '${it['title']} segera hadir'),
            child: Container(
              width: 190,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  it['bg1'] as Color,
                  (it['bg2'] as Color)
                      .withValues(alpha: 0.6),
                ]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                            color: Colors.white
                                .withValues(
                                    alpha: 0.8),
                            shape: BoxShape.circle),
                        child: Icon(
                            it['icon'] as IconData,
                            size: 20,
                            color: _C.primary),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3),
                        decoration: BoxDecoration(
                            color: Colors.white
                                .withValues(
                                    alpha: 0.6),
                            borderRadius:
                                BorderRadius.circular(
                                    10)),
                        child: Text(
                            it['tag'] as String,
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 10,
                                    color: it['fg']
                                        as Color)),
                      ),
                      const SizedBox(height: 6),
                      Text(it['title'] as String,
                          maxLines: 3,
                          overflow:
                              TextOverflow.ellipsis,
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 15,
                                  fontWeight:
                                      FontWeight.w700,
                                  height: 1.25,
                                  color: it['fg']
                                      as Color)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(it['foot'] as String,
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 10,
                                    color: it['fg']
                                        as Color)),
                      ),
                      Icon(Icons.arrow_forward,
                          size: 18,
                          color: it['fg'] as Color),
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
}

/// Satu kartu artikel vertikal. Widget murni (pure): seluruh data
/// masuk lewat parameter sehingga aman dipakai ulang dan tidak
/// membaca state parent secara langsung.
class _ArticleCard extends StatelessWidget {
  final _Article article;
  final bool saved;
  final bool last;
  final VoidCallback onTap;
  final VoidCallback onToggleSave;

  const _ArticleCard({
    required this.article,
    required this.saved,
    required this.last,
    required this.onTap,
    required this.onToggleSave,
  });

  @override
  Widget build(BuildContext context) {
    final a = article;
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
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
                  blurRadius: 20,
                  offset: const Offset(0, 8)),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 88, height: 88,
                decoration: BoxDecoration(
                  color: a.banner,
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: Icon(a.bannerIcon,
                    size: 36,
                    color: _C.primaryContainer
                        .withValues(alpha: 0.7)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        Flexible(
                          child: Text(a.catLabel
                                  .toUpperCase(),
                              overflow:
                                  TextOverflow.ellipsis,
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight:
                                          FontWeight.w700,
                                      letterSpacing: 0.4,
                                      color: _C
                                          .tertiary)),
                        ),
                        GestureDetector(
                          onTap: onToggleSave,
                          child: Icon(
                              saved
                                  ? Icons.bookmark
                                  : Icons
                                      .bookmark_border,
                              size: 18,
                              color: saved
                                  ? _C.primary
                                  : _C.outline),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(a.title,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 14,
                                fontWeight:
                                    FontWeight.w700,
                                height: 1.3)),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        Flexible(
                          child: Text(a.author,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 11,
                                      color: _C
                                          .onSurfaceVariant)),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.timer,
                                size: 14,
                                color: _C.outline),
                            const SizedBox(width: 2),
                            Text(a.time,
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 10,
                                        color:
                                            _C.outline)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PulseDot extends StatelessWidget {
  const _PulseDot();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 8, height: 8,
        decoration: const BoxDecoration(
            color: _C.primaryContainer,
            shape: BoxShape.circle));
  }
}
