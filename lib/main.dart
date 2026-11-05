import 'package:flutter/material.dart';
import 'features/shared/presentation/pages/child_detail_page.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/kader/presentation/pages/kader_main_shell.dart';
import 'features/midwife/presentation/pages/midwife_main_shell.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/onboarding/presentation/pages/splash_screen.dart';
import 'features/parent/presentation/pages/main_shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PosyTrace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const MainShell(),
        '/kader-home': (context) => const KaderMainShell(),
        '/midwife-home': (context) => const MidwifeMainShell(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/child-detail') {
          final args = settings.arguments;
          final name = args is String ? args : 'Aisyah Putri';
          return MaterialPageRoute(
            builder: (_) => ChildDetailPage(childName: name),
          );
        }
        return null;
      },
    );
  }
}
