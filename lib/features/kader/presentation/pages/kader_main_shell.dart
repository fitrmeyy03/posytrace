import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/user_role.dart';
import '../../../../core/shared/pages/profile_page.dart';
import '../../../../core/widgets/app_widgets.dart';
import 'children_page.dart';
import 'kader_dashboard_page.dart';
import 'kader_schedule_page.dart';

/// Shell Kader — 4 menu bawah: Beranda, Balita, Jadwal, Profil.
class KaderMainShell extends StatefulWidget {
  const KaderMainShell({super.key});

  @override
  State<KaderMainShell> createState() => _KaderMainShellState();
}

class _KaderMainShellState extends State<KaderMainShell> {
  int _index = 0;

  void _switchTab(int i) => setState(() => _index = i);

  late final List<Widget> _pages = [
    KaderDashboardPage(onTabChange: _switchTab),
    const ChildrenPage(),
    const KaderSchedulePage(),
    const ProfilePage(role: UserRole.kader),
  ];

  static const _items = [
    AppNavItem('Beranda', Icons.home_outlined, Icons.home_rounded),
    AppNavItem('Balita', Icons.people_outline, Icons.people_rounded),
    AppNavItem('Jadwal', Icons.calendar_today_outlined, Icons.calendar_month),
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
