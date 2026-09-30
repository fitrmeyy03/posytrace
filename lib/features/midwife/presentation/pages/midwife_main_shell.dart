import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'midwife_dashboard_page.dart';
import 'midwife_growth_page.dart';
import 'midwife_schedule_page.dart';
import 'midwife_articles_page.dart';
import 'midwife_profile_page.dart';

// Bottom nav sesuai desain HTML (ungu Vibrant, pill aktif #E8DEFF)
class _Nav {
  static const bg = Colors.white;
  static const primary = Color(0xFF632CE5);
  static const primaryFixed = Color(0xFFE8DEFF);
  static const inactive = Color(0xFF494455);
}

class MidwifeMainShell extends StatefulWidget {
  const MidwifeMainShell({super.key});

  @override
  State<MidwifeMainShell> createState() => _MidwifeMainShellState();
}

class _MidwifeMainShellState extends State<MidwifeMainShell> {
  int _currentIndex = 0;

  void _switchTab(int index) {
    setState(() => _currentIndex = index);
  }

  late final List<Widget> _pages = [
    MidwifeDashboardPage(onTabChange: _switchTab),
    const MidwifeGrowthPage(),
    const MidwifeSchedulePage(),
    const MidwifeArticlesPage(),
    const MidwifeProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: _Nav.bg.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF651FFF)
                .withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 68,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Beranda',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.fact_check,
                label: 'Validasi',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.show_chart,
                label: 'Status Gizi',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.bar_chart,
                label: 'Laporan',
                index: 3,
              ),
              _buildNavItem(
                icon: Icons.badge,
                label: 'Profil',
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        height: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 28,
              decoration: BoxDecoration(
                color: isActive
                    ? _Nav.primaryFixed
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                size: 22,
                color: isActive
                    ? _Nav.primary
                    : _Nav.inactive,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.visible,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isActive
                    ? _Nav.primary
                    : _Nav.inactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
