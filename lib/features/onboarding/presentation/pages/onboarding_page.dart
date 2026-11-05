import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/growth_status.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_mascot.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Onboarding 1–3: perkenalan pencatatan, Z-Score otomatis, lalu edukasi.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  static const _slides = [
    _SlideData(
      tag: 'LANGKAH 1 DARI 3',
      title: 'Pantau Tumbuh Kembang Balita',
      body:
          'Setiap kunjungan posyandu tercatat rapi — berat dan tinggi badan anak terpantau dari bulan ke bulan, tidak lagi hilang di buku tulis.',
      mascotLine: 'Halo! Aku bantu catat tumbuh kembang si kecil, ya.',
      visual: _VisualKind.measurement,
      mood: MascotMood.greeting,
    ),
    _SlideData(
      tag: 'LANGKAH 2 DARI 3',
      title: 'Status Gizi Terhitung Otomatis',
      body:
          'BB/U, TB/U, dan BB/TB dihitung dengan Z-Score metode LMS standar WHO — kader dan orang tua langsung melihat status gizi anak tanpa menghitung manual.',
      mascotLine: 'Status gizi langsung terbaca, tanpa hitung manual.',
      visual: _VisualKind.zscore,
      mood: MascotMood.normal,
    ),
    _SlideData(
      tag: 'LANGKAH 3 DARI 3',
      title: 'Edukasi & Pengingat untuk Orang Tua',
      body:
          'Hasil kunjungan, jadwal posyandu, dan artikel edukasi dari bidan terkirim sebagai notifikasi.',
      mascotLine: 'Jadwal posyandu dan artikel bidan tidak akan terlewat.',
      visual: _VisualKind.notification,
      mood: MascotMood.greeting,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_index == _slides.length - 1) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final last = _index == _slides.length - 1;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('PosyTrace',
                      style: AppText.h3.copyWith(
                        color: AppColors.deepOrange,
                      )),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text('Lewati'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) => _SlideView(_slides[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_slides.length, (i) {
                      final active = i == _index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 6,
                        width: active ? 22 : 6,
                        decoration: BoxDecoration(
                          color: active ? AppColors.primary : AppColors.tint,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    last ? 'Mulai' : 'Lanjut',
                    expanded: true,
                    onPressed: _next,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _VisualKind { measurement, zscore, notification }

class _SlideData {
  const _SlideData({
    required this.tag,
    required this.title,
    required this.body,
    required this.visual,
    required this.mascotLine,
    required this.mood,
  });
  final String tag;
  final String title;
  final String body;
  final String mascotLine;
  final MascotMood mood;
  final _VisualKind visual;
}

class _SlideView extends StatelessWidget {
  final _SlideData data;
  const _SlideView(this.data);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight - 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MascotSpeech(
                message: data.mascotLine,
                mood: data.mood,
                mascotSize: 64,
              ),
              const SizedBox(height: 20),
              _visual(),
              const SizedBox(height: 28),
              Text(
                data.tag,
                style: AppText.label.copyWith(color: AppColors.deepOrange),
              ),
              const SizedBox(height: 8),
              Text(data.title, style: AppText.display.copyWith(fontSize: 24)),
              const SizedBox(height: 10),
              Text(data.body,
                  style: AppText.body.copyWith(
                    color: AppColors.textSecondary,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _visual() {
    switch (data.visual) {
      case _VisualKind.measurement:
        return Row(
          children: const [
            Expanded(
              child: _BigStat(
                value: '9,8 kg',
                label: 'BERAT BADAN',
                icon: Icons.monitor_weight_outlined,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _BigStat(
                value: '86,5 cm',
                label: 'TINGGI BADAN',
                icon: Icons.straighten_rounded,
              ),
            ),
          ],
        );
      case _VisualKind.zscore:
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HASIL Z-SCORE · AISYAH, 24 BULAN',
                style: AppText.label.copyWith(fontSize: 11),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Expanded(
                    child: ZScoreBox(
                        label: 'BB/U',
                        value: -1.2,
                        status: GrowthStatus.normal),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ZScoreBox(
                        label: 'TB/U',
                        value: -0.8,
                        status: GrowthStatus.normal),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ZScoreBox(
                        label: 'BB/TB',
                        value: -1.5,
                        status: GrowthStatus.normal),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const StatusChip(GrowthStatus.normal, compact: true),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Status gizi dihitung otomatis',
                      style: AppText.caption,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      case _VisualKind.notification:
        return Column(
          children: const [
            _MiniNotif(
              icon: Icons.event_available_rounded,
              title: 'Pengingat Posyandu',
              body: 'Sabtu, 14 Nov · Balai Dusun Krajan',
            ),
            SizedBox(height: 10),
            _MiniNotif(
              icon: Icons.menu_book_rounded,
              title: 'Artikel baru dari Bidan Ratna',
              body: 'MP-ASI Kaya Protein untuk Cegah Stunting',
            ),
            SizedBox(height: 10),
            _MiniNotif(
              icon: Icons.check_circle_rounded,
              title: 'Hasil kunjungan Aisyah',
              body: 'Status Gizi Baik · 24 Okt 2026',
              success: true,
            ),
          ],
        );
    }
  }
}

class _BigStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _BigStat({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.tint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: AppColors.deepOrange),
          ),
          const SizedBox(height: 14),
          Text(value, style: AppText.number.copyWith(fontSize: 22)),
          const SizedBox(height: 2),
          Text(label, style: AppText.label.copyWith(fontSize: 10)),
        ],
      ),
    );
  }
}

class _MiniNotif extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final bool success;

  const _MiniNotif({
    required this.icon,
    required this.title,
    required this.body,
    this.success = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: success ? AppColors.statusNormalBg : AppColors.tint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 19,
              color: success ? AppColors.statusNormal : AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.title.copyWith(fontSize: 14)),
                const SizedBox(height: 2),
                Text(body, style: AppText.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
