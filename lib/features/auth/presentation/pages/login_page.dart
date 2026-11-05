import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/demo_data.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_mascot.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../../core/widgets/brand_logo.dart';

/// Login — satu layar masuk untuk kader, bidan, dan orang tua.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phone = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  String? _phoneError;
  String? _passwordError;

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    final phone = _phone.text.replaceAll(RegExp(r'\D'), '');
    setState(() {
      _phoneError = phone.length < 10 ? 'Nomor HP minimal 10 digit' : null;
      _passwordError =
          _password.text.length < 6 ? 'Kata sandi minimal 6 karakter' : null;
    });
    if (_phoneError != null || _passwordError != null) return;
    FocusScope.of(context).unfocus();
    _chooseRole();
  }

  /// Tanpa backend, peran dipilih setelah login agar semua layar bisa dibuka.
  Future<void> _chooseRole() async {
    final role = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Masuk sebagai', style: AppText.h2),
            const SizedBox(height: 4),
            Text(
              'Pilih peran akun untuk melanjutkan.',
              style: AppText.caption,
            ),
            const SizedBox(height: 12),
            _RoleOption(
              title: 'Kader',
              subtitle: 'Pencatatan kunjungan & data balita',
              icon: Icons.assignment_ind_outlined,
              onTap: () => Navigator.pop(context, 'kader'),
            ),
            const SizedBox(height: 8),
            _RoleOption(
              title: 'Bidan',
              subtitle: 'Pemantauan lintas posyandu & artikel',
              icon: Icons.medical_services_outlined,
              onTap: () => Navigator.pop(context, 'bidan'),
            ),
            const SizedBox(height: 8),
            _RoleOption(
              title: 'Orang Tua',
              subtitle: 'Pantau grafik anak & baca edukasi',
              icon: Icons.family_restroom_rounded,
              onTap: () => Navigator.pop(context, 'orangtua'),
            ),
          ],
        ),
      ),
    );
    if (!mounted || role == null) return;
    final route = switch (role) {
      'kader' => '/kader-home',
      'bidan' => '/midwife-home',
      _ => '/home',
    };
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                  boxShadow: [AppColors.cardShadow],
                ),
                child: const AppMascot(size: 88),
              ),
            ),
            const SizedBox(height: 14),
            const Center(child: BrandWordmark(fontSize: 26)),
            const SizedBox(height: 6),
            Center(
              child: Text(
                'Pemantauan tumbuh kembang balita',
                style: AppText.caption,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 2),
            Center(
              child: Text(
                DemoData.posyanduName,
                style: AppText.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepOrange,
                ),
              ),
            ),
            const SizedBox(height: 28),
            AppTextField(
              label: 'Nomor HP',
              hint: '0812 3456 7890',
              icon: Icons.phone_outlined,
              controller: _phone,
              keyboardType: TextInputType.phone,
              errorText: _phoneError,
            ),
            const SizedBox(height: 14),
            AppTextField(
              label: 'Kata Sandi',
              hint: '••••••••',
              icon: Icons.lock_outline_rounded,
              controller: _password,
              obscure: _obscure,
              errorText: _passwordError,
              suffix: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppButton('Masuk', expanded: true, onPressed: _submit),
            const SizedBox(height: 14),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppText.caption,
                children: const [
                  TextSpan(text: 'Lupa kata sandi? Minta reset ke '),
                  TextSpan(
                    text: 'kader posyandu',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepOrange,
                    ),
                  ),
                  TextSpan(text: ' Anda.'),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const InfoNote(
              'Akun dibuatkan oleh kader atau bidan posyandu — tidak ada pendaftaran mandiri.',
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _RoleOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.tint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: AppColors.deepOrange),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.title),
                Text(subtitle, style: AppText.caption),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
