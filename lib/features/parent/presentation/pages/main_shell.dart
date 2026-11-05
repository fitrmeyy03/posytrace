import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/user_role.dart';
import '../../../../core/shared/pages/profile_page.dart';
import '../../../../core/widgets/app_widgets.dart';
import 'articles_page.dart';
import 'dashboard_page.dart';
import 'schedule_page.dart';

/// Shell Orang Tua — 4 menu bawah: Beranda, Jadwal, Artikel, Profil.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  void _switchTab(int i) => setState(() => _index = i);

  late final List<Widget> _pages = [
    DashboardPage(onTabChange: _switchTab),
    const SchedulePage(),
    const ArticlesPage(),
    const ProfilePage(role: UserRole.parent),
  ];

  static const _items = [
    AppNavItem('Beranda', Icons.home_outlined, Icons.home_rounded),
    AppNavItem('Jadwal', Icons.calendar_month_outlined,
        Icons.calendar_month_rounded),
    AppNavItem('Artikel', Icons.menu_book_outlined, Icons.menu_book_rounded),
    AppNavItem('Profil', Icons.person_outline, Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: AppBottomNav(
        items: _items,
        index: _index,
        onTap: _switchTab,
      ),
    );
  }
}
