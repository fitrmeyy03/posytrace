import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _C {
  static const bg = Color(0xFFFBF9F6);
  static const primary = Color(0xFF954A00);
  static const primaryContainer = Color(0xFFE8863A);
  static const primaryFixed = Color(0xFFFFDCC6);
  static const onPrimaryFixed = Color(0xFF311400);
  static const secondary = Color(0xFF914C0D);
  static const secondaryFixed = Color(0xFFFFDCC5);
  static const onSurface = Color(0xFF1B1C1A);
  static const onSurfaceVariant = Color(0xFF554338);
  static const outline = Color(0xFF887366);
  static const outlineVariant = Color(0xFFDBC2B3);
  static const surfaceLow = Color(0xFFF5F3F0);
  static const surfaceLowest = Colors.white;
  static const surfaceHigh = Color(0xFFEAE8E5);
  static const tertiary = Color(0xFF226A55);
  static const tertiaryFixed = Color(0xFFABF1D7);
  static const onTertiaryContainer = Color(0xFF003E2F);
  static const error = Color(0xFFBA1A1A);
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _toast(BuildContext context, String msg) {
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

  void _qrDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 180, height: 180,
              decoration: BoxDecoration(
                color: _C.surfaceLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: _C.outlineVariant
                        .withValues(alpha: 0.5)),
              ),
              child: const Icon(Icons.qr_code_2,
                  size: 120, color: _C.onSurface),
            ),
            const SizedBox(height: 12),
            Text('QR Anggota KIA',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            Text('Mark Kalandra • #MEL-2024-089',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12, color: _C.outline)),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _C.primaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(24)),
                ),
                child: Text('Tutup',
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Keluar',
            style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700)),
        content: Text('Yakin ingin keluar dari akun?',
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
          SliverPadding(
            padding:
                const EdgeInsets.fromLTRB(20, 8, 20, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _appBar(context),
                const SizedBox(height: 12),
                _parentCard(context),
                const SizedBox(height: 18),
                _childSection(context),
                const SizedBox(height: 18),
                _menu(context),
                const SizedBox(height: 16),
                _logout(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- App bar ----------
  Widget _appBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AKUN & KELUARGA',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                      color: _C.primary)),
              Text('Profil Saya',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4)),
            ],
          ),
          GestureDetector(
            onTap: () =>
                _toast(context, 'Pengaturan profil segera hadir'),
            child: Container(
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
              child: const Icon(Icons.settings,
                  size: 22, color: _C.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Kartu ibu ----------
  Widget _parentCard(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 64, height: 64,
                    decoration: BoxDecoration(
                      color: _C.primaryContainer
                          .withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: _C.primaryContainer
                              .withValues(alpha: 0.3),
                          width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Text('AS',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: _C.primary)),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      width: 16, height: 16,
                      decoration: BoxDecoration(
                        color: _C.tertiary,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: _C.surfaceLowest,
                            width: 2),
                      ),
                      child: const Icon(Icons.check,
                          size: 10, color: Colors.white),
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
                    const Wrap(
                      spacing: 6,
                      children: [
                        _Badge(
                            text: 'Orang Tua / Ibu',
                            bg: _C.primaryFixed,
                            fg: _C.onPrimaryFixed),
                        _BadgeCheck(),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Bunda Agnes Safitri',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                    Text('agnes.safitri@email.com',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: _C.onSurfaceVariant)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding:
                const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _C.outlineVariant
                            .withValues(alpha: 0.3)))),
            child: const Column(
              children: [
                _MetaRow(
                    icon: Icons.call,
                    text: '0812-3456-7890'),
                SizedBox(height: 8),
                _MetaRow(
                    icon: Icons.location_on,
                    text:
                        'Kel. Bahagia, RW 05 • Posyandu Melati 04'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _actionBtn(
                  context,
                  icon: Icons.edit,
                  label: 'Ubah Profil',
                  primary: true,
                  onTap: () => _toast(context,
                      'Formulir ubah profil segera hadir'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _actionBtn(
                  context,
                  icon: Icons.qr_code_2,
                  label: 'QR Anggota KIA',
                  primary: false,
                  onTap: () => _qrDialog(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(BuildContext context,
      {required IconData icon,
      required String label,
      required bool primary,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
            color: _C.surfaceLow,
            borderRadius: BorderRadius.circular(24)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 16,
                color: primary
                    ? _C.primary
                    : _C.onSurfaceVariant),
            const SizedBox(width: 4),
            Flexible(
              child: Text(label,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primary
                          ? _C.primary
                          : _C.onSurfaceVariant)),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Anak ----------
  Widget _childSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Balita Terhubung',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                  color: _C.primaryFixed,
                  borderRadius: BorderRadius.circular(12)),
              child: Text('1 Anak Aktif',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: _C.onPrimaryFixed)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _C.surfaceLowest,
            borderRadius: BorderRadius.circular(24),
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
            children: [
              Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEFE5),
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text('M',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: _C.primary)),
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
                            Text('Mark Kalandra',
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 15,
                                        fontWeight:
                                            FontWeight
                                                .w700)),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3),
                              decoration: BoxDecoration(
                                  color:
                                      _C.tertiaryFixed,
                                  borderRadius:
                                      BorderRadius
                                          .circular(
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
                                              FontWeight
                                                  .w700,
                                          color: _C
                                              .onTertiaryContainer)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text('2 Tahun 5 Bulan • Laki-laki',
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 12,
                                    color: _C.outline)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: _C.surfaceLow,
                    borderRadius:
                        BorderRadius.circular(12)),
                child: const Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    _ChildMeta(
                        l: 'NIK', v: '3208••••0091'),
                    _ChildMeta(
                        l: 'Posyandu',
                        v: 'Melati 04'),
                    _ChildMeta(
                        l: 'BB / TB',
                        v: '15 kg / 118 cm'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _toast(context,
              'Fitur tambah anak segera hadir'),
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: _C.surfaceLow,
                borderRadius: BorderRadius.circular(24)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle,
                    size: 20, color: _C.primary),
                SizedBox(width: 6),
                Text('Tambah Data Anak Lain',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _C.primary)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------- Menu ----------
  Widget _menu(BuildContext context) {
    final items = [
      {
        'icon': Icons.medical_services,
        'bg': _C.primaryFixed.withValues(alpha: 0.6),
        'fg': _C.primary,
        'title': 'Buku KIA & Rekam Medis Digital',
        'sub': 'Akses PDF rekam medis & QR Posyandu',
        'badge': null,
      },
      {
        'icon': Icons.history_edu,
        'bg': _C.tertiaryFixed.withValues(alpha: 0.6),
        'fg': _C.tertiary,
        'title': 'Jadwal & Riwayat Kunjungan Saya',
        'sub': 'Terakhir hadir: 14 Mei 2024',
        'badge': null,
      },
      {
        'icon': Icons.notifications_active,
        'bg': _C.secondaryFixed.withValues(alpha: 0.7),
        'fg': _C.secondary,
        'title': 'Pengingat & Notifikasi Posyandu',
        'sub': 'Alarm H-3, H-1 & broadcast WhatsApp',
        'badge': 'Aktif',
      },
      {
        'icon': Icons.support_agent,
        'bg': _C.surfaceHigh,
        'fg': _C.onSurfaceVariant,
        'title': 'Bantuan & Kontak Bidan Desa',
        'sub': 'Bidan Siti Aisyah • 0811-9876-543',
        'badge': null,
      },
      {
        'icon': Icons.info,
        'bg': _C.surfaceHigh,
        'fg': _C.onSurfaceVariant,
        'title': 'Tentang PosyTrace',
        'sub': 'Versi 2.4 • Terakreditasi Kemenkes RI',
        'badge': null,
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Layanan & Pengaturan',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _C.surfaceLowest,
            borderRadius: BorderRadius.circular(24),
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
            children: List.generate(items.length, (i) {
              final it = items[i];
              final badge = it['badge'] as String?;
              return GestureDetector(
                onTap: () => _toast(context,
                    '${it['title']} segera hadir'),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                            color: it['bg'] as Color,
                            shape: BoxShape.circle),
                        child: Icon(
                            it['icon'] as IconData,
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
                                            FontWeight
                                                .w600)),
                            Text(it['sub'] as String,
                                style: GoogleFonts
                                    .plusJakartaSans(
                                        fontSize: 12,
                                        color: _C
                                            .onSurfaceVariant)),
                          ],
                        ),
                      ),
                      if (badge != null)
                        Container(
                          margin:
                              const EdgeInsets.only(
                                  right: 6),
                          padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3),
                          decoration: BoxDecoration(
                              color: _C.primaryFixed,
                              borderRadius:
                                  BorderRadius.circular(
                                      10)),
                          child: Text(badge,
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                      color: _C
                                          .onPrimaryFixed)),
                        ),
                      const Icon(Icons.chevron_right,
                          size: 20, color: _C.outline),
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

  // ---------- Logout ----------
  Widget _logout(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 52,
      child: OutlinedButton.icon(
        onPressed: () => _confirmLogout(context),
        icon: const Icon(Icons.logout,
            size: 20, color: _C.error),
        label: Text('Keluar dari Akun',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _C.error)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color:
                  _C.error.withValues(alpha: 0.3)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28)),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  const _Badge(
      {required this.text,
      required this.bg,
      required this.fg});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12)),
      child: Text(text,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: fg)),
    );
  }
}

class _BadgeCheck extends StatelessWidget {
  const _BadgeCheck();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          color: _C.tertiaryFixed,
          borderRadius: BorderRadius.circular(12)),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified,
              size: 12, color: _C.onTertiaryContainer),
          SizedBox(width: 4),
          Text('Terverifikasi KIA',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: _C.onTertiaryContainer)),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _MetaRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: _C.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: _C.onSurfaceVariant)),
        ),
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

class _ChildMeta extends StatelessWidget {
  final String l;
  final String v;
  const _ChildMeta({required this.l, required this.v});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(l,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 10, color: _C.outline)),
        Text(v,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w700)),
      ],
    );
  }
}
