import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification_detail_page.dart';

class _C {
  static const bg = Color(0xFFFBF9F6);
  static const primary = Color(0xFF954A00);
  static const primaryContainer = Color(0xFFE8863A);
  static const secondary = Color(0xFF914C0D);
  static const onSurfaceVariant = Color(0xFF554338);
  static const outline = Color(0xFF887366);
  static const outlineVariant = Color(0xFFDBC2B3);
  static const surfaceLowest = Colors.white;
  static const tertiary = Color(0xFF226A55);
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

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
                SafeArea(
                  bottom: false,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Notifikasi',
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 26,
                                  fontWeight:
                                      FontWeight.w700,
                                  letterSpacing: -0.4)),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5),
                        decoration: BoxDecoration(
                            color: _C.primaryContainer
                                .withValues(
                                    alpha: 0.15),
                            borderRadius:
                                BorderRadius.circular(
                                    12)),
                        child: Text('2 Baru',
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 10,
                                    fontWeight:
                                        FontWeight.w700,
                                    color: _C.primary)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _section('Hari Ini'),
                const SizedBox(height: 8),
                _card(
                  context,
                  icon: Icons.vaccines,
                  iconBg: _C.primaryContainer
                      .withValues(alpha: 0.15),
                  iconFg: _C.primary,
                  title: 'Vaksin MMR Mark 3 Hari Lagi',
                  message:
                      'Booster Campak/Rubella di Posyandu Melati 04, 14 Mei 08:30',
                  time: '2 jam lalu',
                  unread: true,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const NotificationDetailPage())),
                ),
                _card(
                  context,
                  icon: Icons.show_chart,
                  iconBg: _C.secondary
                      .withValues(alpha: 0.12),
                  iconFg: _C.secondary,
                  title: 'Pengingat Pengukuran',
                  message:
                      'Waktunya menimbang Mark bulan ini di posyandu',
                  time: '5 jam lalu',
                  unread: true,
                  onTap: () => _toast(context,
                      'Membuka pengingat pengukuran...'),
                ),
                const SizedBox(height: 16),
                _section('Kemarin'),
                const SizedBox(height: 8),
                _card(
                  context,
                  icon: Icons.menu_book,
                  iconBg: _C.tertiary
                      .withValues(alpha: 0.12),
                  iconFg: _C.tertiary,
                  title: 'Artikel Baru',
                  message:
                      'Panduan MPASI 4 Bintang untuk cegah stunting',
                  time: '1 hari lalu',
                  onTap: () => _toast(context,
                      'Membuka artikel...'),
                ),
                _card(
                  context,
                  icon: Icons.check_circle,
                  iconBg: _C.secondary
                      .withValues(alpha: 0.12),
                  iconFg: _C.secondary,
                  title: 'Pengukuran Tercatat',
                  message:
                      'Data Mark 15 Mei berhasil tersimpan di KMS',
                  time: '1 hari lalu',
                  onTap: () => _toast(context,
                      'Membuka riwayat pengukuran...'),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String t) {
    return Text(t,
        style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _C.onSurfaceVariant));
  }

  Widget _card(
    BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
    required String title,
    required String message,
    required String time,
    bool unread = false,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _C.surfaceLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: unread
                    ? _C.primaryContainer
                        .withValues(alpha: 0.4)
                    : _C.outlineVariant
                        .withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFFB89678)
                      .withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4)),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius:
                        BorderRadius.circular(12)),
                child:
                    Icon(icon, size: 20, color: iconFg),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(title,
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.w600)),
                        ),
                        if (unread)
                          Container(
                              width: 8, height: 8,
                              decoration:
                                  const BoxDecoration(
                                      color: _C
                                          .primaryContainer,
                                      shape:
                                          BoxShape.circle)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(message,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            height: 1.4,
                            color: _C.onSurfaceVariant)),
                    const SizedBox(height: 6),
                    Text(time,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: _C.outline)),
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
