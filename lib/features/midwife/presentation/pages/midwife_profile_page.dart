import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/shared/pages/notifications_page.dart';

class _C {
  static const bg = Color(0xFFFDF7FF);
  static const primary = Color(0xFF632CE5);
  static const primaryContainer = Color(0xFF7C4DFF);
  static const primaryFixed = Color(0xFFE8DEFF);
  static const onPrimaryFixedVariant = Color(0xFF4F00D0);
  static const secondary = Color(0xFF4B00CC);
  static const secondaryFixed = Color(0xFFE7DEFF);
  static const onSurfaceVariant = Color(0xFF494455);
  static const outline = Color(0xFF7A7487);
  static const outlineVariant = Color(0xFFCAC3D8);
  static const surfaceLow = Color(0xFFF8F1FF);
  static const surfaceHigh = Color(0xFFEDE5F5);
  static const tertiary = Color(0xFF00655A);
  static const tertiaryContainer = Color(0xFF008073);
  static const tertiaryFixed = Color(0xFF8DF5E4);
  static const onTertiaryFixedVariant = Color(0xFF005048);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
}

class MidwifeProfilePage extends StatelessWidget {
  const MidwifeProfilePage({super.key});

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle,
              size: 20, color: Color(0xFF8DF5E4)),
          const SizedBox(width: 10),
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
      duration: const Duration(seconds: 2),
    ));
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Keluar',
            style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700)),
        content: Text(
            'Akhiri sesi Bidan dengan aman?',
            style: GoogleFonts.plusJakartaSans()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal',
                style: GoogleFonts.plusJakartaSans(
                    color: _C.onSurfaceVariant)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .pushReplacementNamed('/login');
            },
            child: Text('Keluar',
                style: GoogleFonts.plusJakartaSans(
                    color: _C.error,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _header(context)),
          SliverPadding(
            padding:
                const EdgeInsets.fromLTRB(20, 8, 20, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _heroCard(),
                const SizedBox(height: 12),
                _metrics(),
                const SizedBox(height: 16),
                _settings(context),
                const SizedBox(height: 14),
                _logout(context),
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
          ],
        ),
      ),
    );
  }

  Widget _heroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 96, height: 96,
                decoration: BoxDecoration(
                  color: _C.primaryFixed,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: _C.primary
                            .withValues(alpha: 0.18),
                        blurRadius: 24,
                        offset: const Offset(0, 8)),
                  ],
                ),
                alignment: Alignment.center,
                child: Text('BR',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: _C.primary)),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: _C.primaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white, width: 4),
                  ),
                  child: const Icon(Icons.verified,
                      size: 18, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Bidan Ratna Sari, S.Tr.Keb',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: _C.primaryContainer,
                borderRadius: BorderRadius.circular(20)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.local_hospital,
                    size: 14, color: Colors.white),
                SizedBox(width: 4),
                Text('BIDAN KOORDINATOR POSYANDU',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Puskesmas Sukamaju',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _C.primary)),
              SizedBox(width: 6),
              Text('•',
                  style:
                      TextStyle(color: _C.outline)),
              SizedBox(width: 6),
              Text('NIP: 19880412 201101 2 003',
                  style: TextStyle(
                      fontSize: 12, color: _C.outline)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: _C.surfaceLow,
                borderRadius: BorderRadius.circular(12)),
            child: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mail,
                        size: 15, color: _C.primary),
                    SizedBox(width: 6),
                    Text('ratna.bidan@puskesmas.go.id',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call,
                        size: 15, color: _C.tertiary),
                    SizedBox(width: 6),
                    Text('0812-9876-5432',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
                color: _C.primaryFixed
                    .withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _PulseDot(),
                    SizedBox(width: 8),
                    Text('SIPB Aktif: 503/SIPB/2024',
                        style: TextStyle(
                            fontSize: 10,
                            color: _C.onPrimaryFixedVariant)),
                  ],
                ),
                Text('Klinis Aktif',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _C.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metrics() {
    return const Row(
      children: [
        Expanded(
            child: _Metric(
                icon: Icons.child_care,
                bg: _C.primaryFixed,
                fg: _C.primary,
                value: '248',
                label: 'Balita Dipantau',
                foot: 'Aktif RW 01-06',
                footColor: _C.tertiary)),
        SizedBox(width: 10),
        Expanded(
            child: _Metric(
                icon: Icons.task_alt,
                bg: _C.tertiaryFixed,
                fg: _C.onTertiaryFixedVariant,
                value: '62',
                label: 'Validasi Bulan Ini',
                foot: '100% Selesai',
                footColor: _C.tertiaryContainer)),
        SizedBox(width: 10),
        Expanded(
            child: _Metric(
                icon: Icons.note_alt,
                bg: _C.secondaryFixed,
                fg: _C.secondary,
                value: '19',
                label: 'Rekomendasi',
                foot: '19 Kasus Gizi',
                footColor: _C.secondary)),
      ],
    );
  }

  Widget _settings(BuildContext context) {
    final items = [
      {
        'icon': Icons.badge,
        'bg': _C.primaryFixed,
        'fg': _C.primary,
        'title': 'Edit Profil Bidan',
        'sub': 'Perbarui SIPB, kontak & jadwal poli',
        'msg': 'Membuka Formulir SIPB & Jadwal Poli'
      },
      {
        'icon': Icons.lock_clock,
        'bg': _C.surfaceHigh,
        'fg': _C.secondary,
        'title': 'Ubah Kata Sandi & PIN Validasi',
        'sub': 'PIN otentikasi data e-PPGBM',
        'msg': 'PIN e-PPGBM Siap Diperbarui'
      },
      {
        'icon': Icons.location_on,
        'bg': _C.tertiaryFixed,
        'fg': _C.onTertiaryFixedVariant,
        'title': 'Wilayah Tugas & Posyandu Binaan',
        'sub': '6 RW binaan di Kelurahan Sukamaju',
        'msg': 'Memuat 6 Posyandu Binaan'
      },
      {
        'icon': Icons.menu_book,
        'bg': Color(0xFFCDBDFF),
        'fg': _C.onPrimaryFixedVariant,
        'title': 'Bantuan & Pedoman Medis Kemenkes',
        'sub': 'Standar antropometri & tatalaksana gizi',
        'msg': 'Pedoman Antropometri Kemenkes'
      },
      {
        'icon': Icons.info,
        'bg': _C.surfaceHigh,
        'fg': _C.onSurfaceVariant,
        'title': 'Tentang Aplikasi POSY Trace',
        'sub': 'Versi v2.4.0 - Edisi Tenaga Kesehatan',
        'msg': 'POSY Trace Edisi Bidan v2.4.0'
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('PENGATURAN & OTORITAS KLINIS',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: _C.outline)),
            Text('Akses Koordinator',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _C.primary)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(6),
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
            children: List.generate(items.length, (i) {
              final it = items[i];
              return GestureDetector(
                onTap: () =>
                    _toast(context, it['msg'] as String),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                            color: it['bg'] as Color,
                            shape: BoxShape.circle),
                        child: Icon(it['icon'] as IconData,
                            size: 20,
                            color: it['fg'] as Color),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(it['title'] as String,
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 14,
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
                      const Icon(Icons.chevron_right,
                          size: 20,
                          color: _C.outlineVariant),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _logout(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity, height: 52,
          child: ElevatedButton.icon(
            onPressed: () => _confirmLogout(context),
            icon: const Icon(Icons.logout,
                size: 20, color: _C.error),
            label: Text('Keluar dari Akun Bidan',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _C.error)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _C.errorContainer
                  .withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.health_and_safety,
                size: 15, color: _C.primary),
            SizedBox(width: 4),
            Text('POSY TRACE ECOSYSTEM',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: _C.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: 2),
        Text('Terintegrasi Kemenkes RI & e-PPGBM',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 10, color: _C.outline)),
      ],
    );
  }
}

class _PulseDot extends StatelessWidget {
  const _PulseDot();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 10, height: 10,
        decoration: const BoxDecoration(
            color: _C.tertiaryContainer,
            shape: BoxShape.circle));
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final Color fg;
  final String value;
  final String label;
  final String foot;
  final Color footColor;
  const _Metric({
    required this.icon,
    required this.bg,
    required this.fg,
    required this.value,
    required this.label,
    required this.foot,
    required this.footColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF651FFF)
                  .withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
                color: bg, shape: BoxShape.circle),
            child: Icon(icon, size: 18, color: fg),
          ),
          const SizedBox(height: 8),
          Text(value,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  height: 1.1)),
          Text(label,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 10, color: _C.outline)),
          const SizedBox(height: 4),
          Text(foot,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: footColor)),
        ],
      ),
    );
  }
}
