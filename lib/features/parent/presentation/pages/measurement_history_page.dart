import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class MeasurementHistoryPage extends StatelessWidget {
  const MeasurementHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Riwayat Pengukuran',
          style: GoogleFonts.lexend(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Child info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    'B',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budi Santoso',
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      'Lahir: 15 Januari 2022',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // History list
          _buildHistoryCard(
            date: '15 Oktober 2025',
            location: 'Posyandu Melati',
            weight: '12.5',
            height: '88',
            headCircumference: '47',
            status: 'Sesuai Usia',
            statusColor: AppColors.secondary,
          ),
          _buildHistoryCard(
            date: '15 September 2025',
            location: 'Posyandu Melati',
            weight: '12.2',
            height: '87',
            headCircumference: '47',
            status: 'Sesuai Usia',
            statusColor: AppColors.secondary,
          ),
          _buildHistoryCard(
            date: '15 Agustus 2025',
            location: 'Posyandu Melati',
            weight: '12.0',
            height: '86',
            headCircumference: '46.5',
            status: 'Sesuai Usia',
            statusColor: AppColors.secondary,
          ),
          _buildHistoryCard(
            date: '15 Juli 2025',
            location: 'Posyandu Melati',
            weight: '11.8',
            height: '85',
            headCircumference: '46',
            status: 'Perlu Perhatian',
            statusColor: AppColors.error,
          ),
          _buildHistoryCard(
            date: '15 Juni 2025',
            location: 'Posyandu Melati',
            weight: '11.5',
            height: '84',
            headCircumference: '46',
            status: 'Sesuai Usia',
            statusColor: AppColors.secondary,
          ),
          _buildHistoryCard(
            date: '15 Mei 2025',
            location: 'Posyandu Melati',
            weight: '11.2',
            height: '83',
            headCircumference: '45.5',
            status: 'Sesuai Usia',
            statusColor: AppColors.secondary,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHistoryCard({
    required String date,
    required String location,
    required String weight,
    required String height,
    required String headCircumference,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: AppColors.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                location,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildMeasurementChip(
                Icons.monitor_weight_outlined,
                '$weight kg',
              ),
              const SizedBox(width: 8),
              _buildMeasurementChip(
                Icons.height,
                '$height cm',
              ),
              const SizedBox(width: 8),
              _buildMeasurementChip(
                Icons.circle_outlined,
                '$headCircumference cm',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
