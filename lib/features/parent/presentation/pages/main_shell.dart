import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'growth_page.dart';
import 'schedule_page.dart';
import 'articles_page.dart';
import '../../../../core/shared/pages/profile_page.dart';

// Floating pill dock sesuai desain HTML (warm orange)
class _Nav {
  static const bg = Colors.white;
  static const active = Color(0xFFE8863A);
  static const inactive = Color(0xFF887366);
  static const border = Color(0xFFDBC2B3);
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _switchTab(int index) {
    setState(() => _currentIndex = index);
  }

  late final List<Widget> _pages = [
    DashboardPage(onTabChange: _switchTab),
    const GrowthPage(),
    const SchedulePage(),
    const ArticlesPage(),
    const ProfilePage(),
  ];

  static const _icons = [
    Icons.home,
    Icons.query_stats,
    Icons.calendar_month,
    Icons.menu_book,
    Icons.person,
  ];

  static const _labels = [
    'Beranda',
    'Grafik',
    'Jadwal',
    'Edukasi',
    'Profil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 76),
              child: _pages[_currentIndex],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 20),
                child: Center(child: _dock()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dock() {
    return Semantics(
      label: 'Navigasi Utama',
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: _Nav.bg,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
              color: _Nav.border.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA0785A)
                  .withValues(alpha: 0.14),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (i) {
            final active = i == _currentIndex;
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 2),
              child: GestureDetector(
                onTap: () =>
                    setState(() => _currentIndex = i),
                behavior: HitTestBehavior.opaque,
                child: Semantics(
                  label: _labels[i],
                  button: true,
                  child: AnimatedContainer(
                    duration: const Duration(
                        milliseconds: 150),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: active
                          ? _Nav.active
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      boxShadow: active
                          ? [
                              BoxShadow(
                                color: _Nav.active
                                    .withValues(
                                        alpha: 0.3),
                                blurRadius: 12,
                                offset:
                                    const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      _icons[i],
                      size: 22,
                      color: active
                          ? Colors.white
                          : _Nav.inactive,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
