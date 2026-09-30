import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _C {
  static const bg = Color(0xFFFBF9F6);
  static const primary = Color(0xFF954A00);
  static const primaryContainer = Color(0xFFE8863A);
  static const secondaryContainer = Color(0xFFFEA45F);
  static const onSurface = Color(0xFF1B1C1A);
  static const onSurfaceVariant = Color(0xFF554338);
  static const outline = Color(0xFF887366);
  static const outlineVariant = Color(0xFFDBC2B3);
  static const surfaceLow = Color(0xFFF5F3F0);
  static const surfaceLowest = Colors.white;
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _id = TextEditingController();
  final _pw = TextEditingController();
  bool _obscure = true;
  bool _remember = true;
  int _role = 0; // 0 ortu, 1 kader, 2 bidan

  @override
  void dispose() {
    _id.dispose();
    _pw.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_role == 2) {
      Navigator.pushReplacementNamed(context, '/midwife-home');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: Stack(
        children: [
          Positioned(
            top: -96, left: -80,
            child: Container(
              width: 256, height: 256,
              decoration: BoxDecoration(
                color: _C.primaryContainer
                    .withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 320, right: -96,
            child: Container(
              width: 288, height: 288,
              decoration: BoxDecoration(
                color: _C.secondaryContainer
                    .withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                  20, 24, 20, 28),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // Brand header
                  Row(
                    children: [
                      Container(
                        width: 48, height: 48,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: _C.surfaceLowest,
                          borderRadius:
                              BorderRadius.circular(16),
                          border: Border.all(
                              color: _C.outlineVariant
                                  .withValues(
                                      alpha: 0.3)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(
                                        0xFFB89678)
                                    .withValues(
                                        alpha: 0.12),
                                blurRadius: 24,
                                offset:
                                    const Offset(0, 8)),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                            errorBuilder:
                                (ctx, err, stack) =>
                                    const Icon(
                              Icons.child_care_rounded,
                              color: _C.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.w700,
                                      letterSpacing: -0.3,
                                      color:
                                          _C.onSurface),
                              children: const [
                                TextSpan(text: 'Posy'),
                                TextSpan(
                                    text: 'Trace',
                                    style: TextStyle(
                                        color: _C
                                            .primaryContainer)),
                              ],
                            ),
                          ),
                          Text('KMS & POSYANDU DIGITAL',
                              style: GoogleFonts
                                  .plusJakartaSans(
                                      fontSize: 10,
                                      letterSpacing: 1.0,
                                      color: _C.outline)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Greeting
                  Text('Selamat Datang, Ayah & Bunda!',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          height: 1.3)),
                  const SizedBox(height: 6),
                  Text(
                    'Masuk untuk memantau rekam medis balita, jadwal imunisasi, dan KMS digital.',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        height: 1.5,
                        color: _C.onSurfaceVariant),
                  ),
                  const SizedBox(height: 18),
                  // Segmented Masuk / Daftar
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _C.surfaceLow,
                      borderRadius:
                          BorderRadius.circular(28),
                      border: Border.all(
                          color: _C.outlineVariant
                              .withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        _seg('Masuk', true, null),
                        _seg('Daftar', false, () {
                          Navigator.pushNamed(
                              context, '/register');
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Role (pertahankan routing peran)
                  _roles(),
                  const SizedBox(height: 16),
                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _label('WhatsApp / No. HP / Email'),
                        TextFormField(
                          controller: _id,
                          validator: (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Wajib diisi'
                                  : null,
                          decoration: _dec(
                            hint:
                                'Contoh: 08123456789 atau bunda@email.com',
                            icon: Icons.call,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _label('Kata Sandi'),
                        TextFormField(
                          controller: _pw,
                          obscureText: _obscure,
                          validator: (v) {
                            if (v == null ||
                                v.isEmpty) {
                              return 'Kata sandi wajib diisi';
                            }
                            if (v.length < 6) {
                              return 'Minimal 6 karakter';
                            }
                            return null;
                          },
                          decoration: _dec(
                            hint:
                                'Masukkan kata sandi akun',
                            icon: Icons.lock,
                            suffix: IconButton(
                              onPressed: () =>
                                  setState(() =>
                                      _obscure =
                                          !_obscure),
                              icon: Icon(
                                  _obscure
                                      ? Icons.visibility
                                      : Icons
                                          .visibility_off,
                                  size: 20,
                                  color: _C.outline),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() =>
                                  _remember =
                                      !_remember),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _remember,
                                    activeColor: _C
                                        .primaryContainer,
                                    onChanged: (v) =>
                                        setState(() =>
                                            _remember =
                                                v ??
                                                    false),
                                  ),
                                  Text('Ingat Saya',
                                      style: GoogleFonts
                                          .plusJakartaSans(
                                              fontSize: 12,
                                              fontWeight:
                                                  FontWeight
                                                      .w500)),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(
                                      context,
                                      '/forgot-password'),
                              child: Text(
                                  'Lupa Kata Sandi?',
                                  style: GoogleFonts
                                      .plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight:
                                              FontWeight
                                                  .w600,
                                          color: _C
                                              .primary)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _C.primaryContainer,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(28)),
                              elevation: 6,
                              shadowColor: _C
                                  .primaryContainer
                                  .withValues(
                                      alpha: 0.4),
                            ),
                            child: const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                              children: [
                                Text(
                                    'Masuk ke Akun PosyTrace',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight:
                                            FontWeight
                                                .w700,
                                        color:
                                            Colors.white)),
                                SizedBox(width: 8),
                                Icon(
                                    Icons.arrow_forward,
                                    size: 18,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _seg(
      String t, bool active, VoidCallback? onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding:
              const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active
                ? _C.surfaceLowest
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            boxShadow: active
                ? [
                    BoxShadow(
                        color: const Color(0xFFB89678)
                            .withValues(alpha: 0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(t,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: active
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: active
                      ? _C.primary
                      : _C.outline)),
        ),
      ),
    );
  }

  Widget _roles() {
    final defs = [
      {'icon': Icons.favorite, 'label': 'Orang Tua'},
      {'icon': Icons.assignment_turned_in, 'label': 'Kader'},
      {'icon': Icons.medical_services, 'label': 'Bidan'},
    ];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _C.surfaceLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: List.generate(3, (i) {
          final active = _role == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _role = i),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 9),
                decoration: BoxDecoration(
                  color: active
                      ? _C.surfaceLowest
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(20),
                  boxShadow: active
                      ? [
                          BoxShadow(
                              color: const Color(
                                      0xFFB89678)
                                  .withValues(
                                      alpha: 0.12),
                              blurRadius: 8,
                              offset:
                                  const Offset(0, 2))
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Icon(defs[i]['icon'] as IconData,
                        size: 16,
                        color: active
                            ? _C.primary
                            : _C.outline),
                    const SizedBox(width: 4),
                    Text(defs[i]['label'] as String,
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 11,
                                fontWeight:
                                    FontWeight.w700,
                                color: active
                                    ? _C.primary
                                    : _C.outline)),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _label(String t) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(t,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _C.onSurfaceVariant)),
      ),
    );
  }

  InputDecoration _dec(
      {required String hint,
      required IconData icon,
      Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          color: _C.outline.withValues(alpha: 0.6)),
      prefixIcon:
          Icon(icon, size: 20, color: _C.outline),
      suffixIcon: suffix,
      filled: true,
      fillColor: _C.surfaceLowest,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
              color: _C.outlineVariant
                  .withValues(alpha: 0.5))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
              color: _C.outlineVariant
                  .withValues(alpha: 0.5))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(
              color: _C.primaryContainer, width: 2)),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 14),
    );
  }
}
