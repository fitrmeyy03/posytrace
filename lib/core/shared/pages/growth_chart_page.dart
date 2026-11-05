import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/demo_data.dart';
import '../../models/user_role.dart';
import '../../theme/app_layout.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_mascot.dart';
import '../../widgets/app_widgets.dart';

/// Grafik Pertumbuhan (KMS Digital) — kurva anak di atas pita standar WHO.
class GrowthChartPage extends StatefulWidget {
  final String childName;
  final UserRole role;
  final bool embedded;

  const GrowthChartPage({
    super.key,
    this.childName = 'Aisyah Putri',
    this.role = UserRole.parent,
    this.embedded = false,
  });

  @override
  State<GrowthChartPage> createState() => _GrowthChartPageState();
}

class _GrowthChartPageState extends State<GrowthChartPage> {
  int _metric = 0;
  static const _metrics = ['BB/U', 'TB/U', 'BB/TB'];

  @override
  Widget build(BuildContext context) {
    final child = DemoData.byName(widget.childName);
    final isWeight = _metric == 0;
    final values = child.visits
        .map((v) => isWeight ? v.weight : v.height)
        .toList()
        .reversed
        .toList();
    final ages = child.visits.map((v) => v.ageMonths).toList().reversed.toList();
    final lastValue = values.isEmpty ? 0.0 : values.last;
    final unit = isWeight ? 'kg' : 'cm';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: widget.embedded
          ? null
          : const AppBarHeader(title: 'Grafik pertumbuhan'),
      body: SafeArea(
        top: widget.embedded,
        bottom: false,
        child: ListView(
        padding: widget.embedded
            ? const EdgeInsets.fromLTRB(20, 12, 20, 24)
            : AppSpacing.pagePadding,
        children: [
          if (widget.embedded) ...[
            const PageHeading(
              title: 'Grafik pertumbuhan',
              subtitle: 'Kurva anak dibanding standar WHO',
            ),
            const SizedBox(height: AppSpacing.gapMd),
          ] else ...[
            Text(
              'Kurva anak dibanding standar WHO',
              style: AppText.caption,
            ),
            const SizedBox(height: AppSpacing.gapSm),
          ],
          AppCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                AppAvatar(initial: child.initial),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(child.name, style: AppText.title),
                      Text(
                        '${child.gender} · ${child.ageMonths} bulan',
                        style: AppText.caption,
                      ),
                    ],
                  ),
                ),
                StatusChip(child.status, compact: true),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          SegmentTabs(
            labels: _metrics,
            index: _metric,
            onChanged: (i) => setState(() => _metric = i),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      isWeight ? 'BB (kg)' : 'TB (cm)',
                      style: AppText.label.copyWith(fontSize: 11),
                    ),
                    const Spacer(),
                    const _LegendDot(
                      color: AppColors.primary,
                      label: 'Anak',
                    ),
                    const SizedBox(width: 12),
                    const _LegendDot(
                      color: AppColors.statusNormalBg,
                      label: 'WHO',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: _GrowthPainter(
                      ages: ages,
                      values: values,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Center(
                  child: Text('Umur (bulan)', style: AppText.caption),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gapMd),
          AppCard(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PENGUKURAN TERAKHIR · ${child.lastVisit.toUpperCase()}',
                  style: AppText.label.copyWith(fontSize: 9),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${_num(lastValue)} $unit   ·   Z ${_num(child.zWeightAge)} SD',
                        style: AppText.h3,
                      ),
                    ),
                    const SizedBox(width: 10),
                    StatusChip(child.status, compact: true),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gapSm),
          AppCard(
            color: AppColors.tint,
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const AppMascot(size: 56, circular: false),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Berat naik ${_num(child.weightGain)} kg dari bulan lalu. '
                        'Pertahankan pola makan bergizi.',
                        style: AppText.caption.copyWith(
                          color: AppColors.deepOrange,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pertumbuhan tetap di rentang normal.',
                        style: AppText.caption.copyWith(
                          fontSize: 11,
                          height: 1.5,
                        ),
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
}

String _num(double value) => value.toStringAsFixed(1).replaceAll('.', ',');

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(label, style: AppText.caption.copyWith(fontSize: 10)),
      ],
    );
  }
}

class _GrowthPainter extends CustomPainter {
  final List<int> ages;
  final List<double> values;

  _GrowthPainter({required this.ages, required this.values});

  void _text(Canvas canvas, String text, Offset at,
      {Color color = AppColors.textMuted,
      double size = 9,
      TextAlign align = TextAlign.left}) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: TextStyle(fontSize: size, color: color)),
      textDirection: TextDirection.ltr,
      textAlign: align,
    )..layout();
    final dx = switch (align) {
      TextAlign.center => at.dx - tp.width / 2,
      TextAlign.right => at.dx - tp.width,
      _ => at.dx,
    };
    tp.paint(canvas, Offset(dx, at.dy));
  }

  @override
  void paint(Canvas canvas, Size size) {
    const left = 30.0;
    const right = 6.0;
    const bottom = 18.0;
    const top = 6.0;
    final w = size.width - left - right;
    final h = size.height - bottom - top;

    if (values.isEmpty) return;

    // Rentang umur & nilai dari data anak (bukan 0–30 bln).
    final minAge = (ages.reduce((a, b) => a < b ? a : b) - 1).clamp(0, 60);
    final maxAge = ages.reduce((a, b) => a > b ? a : b) + 1;
    final span = (maxAge - minAge) == 0 ? 1 : (maxAge - minAge);

    var minV = values.reduce((a, b) => a < b ? a : b);
    var maxV = values.reduce((a, b) => a > b ? a : b);
    final pad = (maxV - minV) * 0.45 + 0.4;
    minV -= pad;
    maxV += pad;
    final rangeV = maxV - minV;

    // Pita rentang normal WHO (kawasan hijau).
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top + h * 0.25, w, h * 0.5),
        const Radius.circular(8),
      ),
      Paint()..color = AppColors.statusNormalBg,
    );

    // Garis bantu + label sumbu-Y.
    final grid = Paint()
      ..color = AppColors.divider
      ..strokeWidth = 1;
    for (var i = 0; i <= 2; i++) {
      final y = top + h * i / 2;
      canvas.drawLine(Offset(left, y), Offset(left + w, y), grid);
      final v = maxV - rangeV * i / 2;
      _text(
        canvas,
        v.toStringAsFixed(1).replaceAll('.', ','),
        Offset(left - 6, y - 5),
        align: TextAlign.right,
      );
    }

    Offset point(int index) {
      final x = left + w * (ages[index] - minAge) / span;
      final y = top + h - ((values[index] - minV) / rangeV) * h;
      return Offset(x, y);
    }

    if (values.length >= 2) {
      final line = Paint()
        ..color = AppColors.primary
        ..strokeWidth = 2.6
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final path = Path();
      for (var i = 0; i < values.length; i++) {
        final p = point(i);
        if (i == 0) {
          path.moveTo(p.dx, p.dy);
        } else {
          path.lineTo(p.dx, p.dy);
        }
      }
      canvas.drawPath(path, line);
    }

    for (var i = 0; i < values.length; i++) {
      final p = point(i);
      canvas.drawCircle(p, 4.5, Paint()..color = AppColors.surface);
      canvas.drawCircle(
        p,
        4.5,
        Paint()
          ..color = AppColors.primary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4,
      );
    }

    // Label umur: hanya titik pertama, tengah, dan terakhir agar tidak tumpang tindih.
    final labelIndexes = <int>{0, values.length ~/ 2, values.length - 1};
    for (final i in labelIndexes) {
      final p = point(i);
      _text(
        canvas,
        '${ages[i]}',
        Offset(p.dx, top + h + 5),
        align: TextAlign.center,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GrowthPainter oldDelegate) =>
      oldDelegate.values != values || oldDelegate.ages != ages;
}
