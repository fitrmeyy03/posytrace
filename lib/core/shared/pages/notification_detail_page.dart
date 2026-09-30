import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _C {
  static const bg = Color(0xFFFBF9F6);
  static const primary = Color(0xFF954A00);
  static const primaryContainer = Color(0xFFE8863A);
  static const secondary = Color(0xFF914C0D);
  static const primaryFixed = Color(0xFFFFDCC6);
  static const onSurface = Color(0xFF1B1C1A);
  static const onSurfaceVariant = Color(0xFF554338);
  static const outline = Color(0xFF887366);
  static const outlineVariant = Color(0xFFDBC2B3);
  static const surfaceLow = Color(0xFFF5F3F0);
  static const surfaceLowest = Colors.white;
  static const tertiary = Color(0xFF226A55);
  static const tertiaryFixed = Color(0xFFABF1D7);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
}

/// Detail pengingat vaksin (desain warm).
/// Parameter opsional agar bisa dipakai ulang untuk notifikasi lain.
class NotificationDetailPage extends StatelessWidget {
  final String childName;
  final String childMeta;
  final String childId;
  final String tag;
  final String countdown;
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final String queue;
  final String queueNote;
  final String place;
  final String placeDetail;
  final String officer;

  const NotificationDetailPage({
    super.key,
    this.childName = 'Mark Kalandra',
    this.childMeta = '24 Bulan (2 Tahun)',
    this.childId = 'ID #MK-9281',
    this.tag = 'Vaksin MMR (Booster Campak)',
    this.countdown = 'H-3',
    this.title = 'Imunisasi Campak, Gondongan & Rubella',
    this.subtitle = 'Pengingat otomatis dari Posyandu Melati 04',
    this.date = 'Rabu, 14 Mei 2026',
    this.time = '08:30 - 11:30 WIB',
    this.queue = '09:15 WIB',
    this.queueNote = 'Hadir 15 menit lebih awal',
    this.place = 'Balai Warga RW 05',
    this.placeDetail = 'Posyandu Melati 04, Kelurahan Bahagia (400m)',
    this.officer = 'Bidan Siti Rohmah, A.Md.Keb',
  });

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
                _topBar(context),
                const SizedBox(height: 14),
                _childHeader(),
                const SizedBox(height: 10),
                _vaccineCard(),
                const SizedBox(height: 12),
                _scheduleCard(),
                const SizedBox(height: 12),
                _guideCard(),
                const SizedBox(height: 16),
                _actions(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: _C.surfaceLowest,
                shape: BoxShape.circle,
                border: Border.all(
                    color: _C.outlineVariant
                        .withValues(alpha: 0.3)),
              ),
              child: const Icon(Icons.arrow_back,
                  size: 20),
            ),
          ),
          Text('Detail Pengingat',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _childHeader() {
    return Row(
      children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: _C.primaryFixed,
            shape: BoxShape.circle,
            border: Border.all(
                color: _C.outlineVariant
                    .withValues(alpha: 0.3)),
          ),
          alignment: Alignment.center,
          child: Text('M',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _C.primary)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(childName,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3),
                    decoration: BoxDecoration(
                        color: _C.tertiaryFixed
                            .withValues(alpha: 0.3),
                        borderRadius:
                            BorderRadius.circular(12)),
                    child: Text('Terdaftar',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _C.tertiary)),
                  ),
                ],
              ),
              Text('$childMeta • $childId',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: _C.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _vaccineCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFB89678)
                  .withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: _C.primaryFixed
                          .withValues(alpha: 0.3),
                      borderRadius:
                          BorderRadius.circular(12)),
                  child: Text(tag,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _C.primaryContainer)),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: _C.errorContainer,
                    borderRadius:
                        BorderRadius.circular(12)),
                child: Text(countdown,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _C.error)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(title,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.3)),
          Text(subtitle,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12, color: _C.outline)),
        ],
      ),
    );
  }

  Widget _scheduleCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFB89678)
                  .withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('JADWAL & LOKASI',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: _C.outline)),
          const SizedBox(height: 12),
          _row(Icons.calendar_today, _C.primaryContainer,
              'Hari & Tanggal', date, time),
          const _Div(),
          _row(Icons.schedule, _C.primaryContainer,
              'Estimasi Giliran', queue, queueNote,
              big: true),
          const _Div(),
          _row(Icons.location_on, _C.tertiary,
              'Lokasi Posyandu', place, placeDetail),
          const _Div(),
          _row(Icons.badge, _C.secondary,
              'Tenaga Kesehatan', officer, null),
        ],
      ),
    );
  }

  Widget _row(IconData icon, Color fg, String label,
      String value, String? sub,
      {bool big = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32, height: 32,
          decoration: const BoxDecoration(
              color: _C.surfaceLow,
              shape: BoxShape.circle),
          child: Icon(icon, size: 18, color: fg),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: _C.onSurfaceVariant)),
              Text(value,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: big ? 18 : 14,
                      fontWeight: FontWeight.w600,
                      color: big
                          ? _C.primary
                          : _C.onSurface)),
              if (sub != null)
                Text(sub,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: _C.outline)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _guideCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surfaceLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color:
                _C.outlineVariant.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFB89678)
                  .withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PANDUAN & SYARAT',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: _C.outline)),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.shield,
                  size: 18,
                  color: _C.primaryContainer),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                    'Memberikan kekebalan optimal terhadap campak, gondongan, dan rubella untuk usia 2 tahun.',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, height: 1.5)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _C.outlineVariant
                            .withValues(alpha: 0.2)))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.thermostat,
                    size: 18,
                    color: _C.primaryContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                      'Pastikan anak tidak demam (≤ 37.5°C) dan tidak batuk pilek berat saat imunisasi.',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12, height: 1.5)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () => _toast(context,
                  'Alarm pengingat MMR dipasang'),
              icon: const Icon(Icons.alarm,
                  size: 20, color: Colors.white),
              label: Text('Pasang Alarm',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _C.primaryContainer,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(28)),
                elevation: 6,
                shadowColor: _C.primaryContainer
                    .withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 52, height: 52,
          decoration: const BoxDecoration(
              color: _C.surfaceLow,
              shape: BoxShape.circle),
          child: IconButton(
            onPressed: () => _toast(
                context, 'Membuka peta Balai RW 05...'),
            icon: const Icon(Icons.pin_drop,
                color: _C.primary),
          ),
        ),
      ],
    );
  }
}

class _Div extends StatelessWidget {
  const _Div();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 1,
      color: _C.outlineVariant.withValues(alpha: 0.2),
    );
  }
}
