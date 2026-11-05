import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/user_role.dart';
import '../../../../core/shared/pages/profile_page.dart';
import '../../../../core/widgets/app_widgets.dart';
import 'midwife_articles_page.dart';
import 'midwife_dashboard_page.dart';
import 'surveillance_page.dart';

/// Shell Bidan — 4 menu bawah: Beranda, Balita, Artikel, Profil.
class MidwifeMainShell extends StatefulWidget {
  const MidwifeMainShell({super.key});

  @override
  State<MidwifeMainShell> createState() => _MidwifeMainShellState();
}

class _MidwifeMainShellState extends State<MidwifeMainShell> {
  int _index = 0;

  void _switchTab(int i) => setState(() => _index = i);

  late final List<Widget> _pages = [
    MidwifeDashboardPage(onTabChange: _switchTab),
    const SurveillancePage(),
    const MidwifeArticlesPage(),
    const ProfilePage(role: UserRole.bidan),
  ];

  static const _items = [
    AppNavItem('Beranda', Icons.home_outlined, Icons.home_rounded),
    AppNavItem('Balita', Icons.people_outline, Icons.people_rounded),
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
