import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _C {
  static const bg = Color(0xFFFBF9F6);
  static const primary = Color(0xFF954A00);
  static const primaryContainer = Color(0xFFE8863A);
  static const secondaryFixed = Color(0xFFFFDCC5);
  static const onSecondaryFixed = Color(0xFF301400);
  static const onSurface = Color(0xFF1B1C1A);
  static const onSurfaceVariant = Color(0xFF554338);
  static const outline = Color(0xFF887366);
  static const outlineVariant = Color(0xFFDBC2B3);
  static const surfaceLow = Color(0xFFF5F3F0);
  static const surfaceLowest = Colors.white;
  static const tertiary = Color(0xFF226A55);
  static const tertiaryFixedDim = Color(0xFF8FD4BB);
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _input = TextEditingController(text: '812-9840-2341');
  final _nik = TextEditingController();
  int _method = 0; // 0 WA, 1 email
  bool _kiaOpen = false;
  bool _sent = false;

  @override
  void dispose() {
    _input.dispose();
    _nik.dispose();
    super.dispose();
  }

  bool get _isWa => _method == 0;

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg,
          style: GoogleFonts.plusJakartaSans(fontSize: 12)),
      backgroundColor: const Color(0xFF30312F),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)),
    ));
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sent = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: Stack(
        children: [
          Positioned(
            top: -64, left: 50, right: 50,
            child: Container(
              height: 288,
              decoration: BoxDecoration(
                color: _C.primaryContainer
                    .withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                  20, 12, 20, 28),
              child: _sent ? _success() : _form(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _form() {
    return Column(
      children: [
        // Top bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: _C.surfaceLowest,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: _C.outlineVariant
                          .withValues(alpha: 0.4)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xFFB89678)
                            .withValues(alpha: 0.12),
                        blurRadius: 24,
                        offset: const Offset(0, 8)),
                  ],
                ),
                child: const Icon(Icons.chevron_left,
                    size: 20, color: _C.onSurface),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: _C.surfaceLowest
                    .withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: _C.outlineVariant
                        .withValues(alpha: 0.3)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _PulseDot(),
                  SizedBox(width: 6),
                  Text('Bantuan Masuk',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _C.primary)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _toast(
                  'Menghubungkan ke Kader Posyandu...'),
              child: Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: _C.surfaceLowest,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: _C.outlineVariant
                          .withValues(alpha: 0.4)),
                ),
                child: const Icon(Icons.support_agent,
                    size: 20,
                    color: _C.primaryContainer),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Hero
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 80, height: 80,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _C.surfaceLowest,
                shape: BoxShape.circle,
                border: Border.all(
                    color: _C.primaryContainer
                        .withValues(alpha: 0.3),
                    width: 2),
                boxShadow: [
                  BoxShadow(
                      color: _C.primaryContainer
                          .withValues(alpha: 0.22),
                      blurRadius: 28,
                      offset: const Offset(0, 12)),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (ctx, err, stack) =>
                      const Icon(
                          Icons.child_care_rounded,
                          size: 36,
                          color: _C.primary),
                ),
              ),
            ),
            Positioned(
              bottom: -4, right: -4,
              child: Container(
                width: 28, height: 28,
                decoration: BoxDecoration(
                  color: _C.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: _C.surfaceLowest,
                      width: 2),
                ),
                child: const Icon(Icons.lock_reset,
                    size: 15, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text('Lupa Kata Sandi Akun?',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4)),
        const SizedBox(height: 6),
        Text(
          'Jangan khawatir, Bunda & Ayah. Masukkan nomor WhatsApp atau Email terdaftar untuk menerima kode OTP verifikasi pemulihan.',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              height: 1.5,
              color: _C.onSurfaceVariant),
        ),
        const SizedBox(height: 16),
        // Method tabs
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: _C.surfaceLow,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
                color: _C.outlineVariant
                    .withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              _tab(0, Icons.chat, 'WhatsApp', true),
              _tab(1, Icons.mail, 'Email', false),
            ],
          ),
        ),
        const SizedBox(height: 14),
        // Input card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _C.surfaceLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: _C.outlineVariant
                    .withValues(alpha: 0.4)),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFFB89678)
                      .withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8)),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                            _isWa
                                ? Icons.phone_iphone
                                : Icons.mail,
                            size: 16,
                            color:
                                _C.primaryContainer),
                        const SizedBox(width: 6),
                        Text(
                            _isWa
                                ? 'Nomor WhatsApp Terdaftar'
                                : 'Alamat Email Terdaftar',
                            style: GoogleFonts
                                .plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight.w700)),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.verified,
                            size: 14,
                            color: _C.tertiary),
                        SizedBox(width: 2),
                        Text('Aktif',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight:
                                    FontWeight.w700,
                                color: _C.tertiary)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _input,
                  keyboardType: _isWa
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Wajib diisi';
                    }
                    if (!_isWa && !v.contains('@')) {
                      return 'Email tidak valid';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        _C.surfaceLow.withValues(
                            alpha: 0.7),
                    prefixIcon: _isWa
                        ? Padding(
                            padding:
                                const EdgeInsets.only(
                                    left: 14,
                                    right: 8),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Text('+62',
                                    style: GoogleFonts
                                        .plusJakartaSans(
                                            fontSize: 12,
                                            fontWeight:
                                                FontWeight
                                                    .w700)),
                                Container(
                                    width: 1,
                                    height: 16,
                                    margin:
                                        const EdgeInsets
                                            .only(
                                                left:
                                                    8),
                                    color: _C
                                        .outlineVariant
                                        .withValues(
                                            alpha:
                                                0.6)),
                              ],
                            ),
                          )
                        : null,
                    suffixIcon: IconButton(
                      onPressed: () =>
                          _input.clear(),
                      icon: const Icon(Icons.cancel,
                          size: 18,
                          color: _C.outline),
                    ),
                    hintText: _isWa
                        ? '812-3456-7890'
                        : 'bunda@email.com',
                    hintStyle: GoogleFonts
                        .plusJakartaSans(
                            fontSize: 14,
                            color: _C.outline
                                .withValues(alpha: 0.6)),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                        borderSide: BorderSide(
                            color: _C.outlineVariant
                                .withValues(
                                    alpha: 0.4))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                        borderSide: BorderSide(
                            color: _C.outlineVariant
                                .withValues(
                                    alpha: 0.4))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(
                                color: _C
                                    .primaryContainer,
                                width: 2)),
                    contentPadding:
                        const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.check_circle,
                        size: 15, color: _C.tertiary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        _isWa
                            ? 'Pastikan nomor aktif dan terhubung ke WhatsApp Bunda/Ayah.'
                            : 'Tautan pemulihan instan akan dikirim ke email.',
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 12,
                                color: _C.outline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // KIA fallback accordion
        Container(
          decoration: BoxDecoration(
            color: _C.surfaceLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: _C.outlineVariant
                    .withValues(alpha: 0.4)),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => setState(
                    () => _kiaOpen = !_kiaOpen),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(
                            color: _C.secondaryFixed
                                .withValues(alpha: 0.5),
                            shape: BoxShape.circle),
                        child: const Icon(
                            Icons.menu_book,
                            size: 18,
                            color: _C
                                .onSecondaryFixed),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Text(
                                'Lupa Nomor WhatsApp & Email?',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight.w700)),
                            Text(
                                'Gunakan No. Buku KIA / NIK Anak',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: _C.outline)),
                          ],
                        ),
                      ),
                      AnimatedRotation(
                        turns: _kiaOpen ? 0.5 : 0,
                        duration: const Duration(
                            milliseconds: 200),
                        child: const Icon(
                            Icons.expand_more,
                            color: _C.outline),
                      ),
                    ],
                  ),
                ),
              ),
              if (_kiaOpen)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                      14, 10, 14, 14),
                  decoration: BoxDecoration(
                    color: _C.surfaceLow
                        .withValues(alpha: 0.3),
                    border: Border(
                        top: BorderSide(
                            color: _C.outlineVariant
                                .withValues(
                                    alpha: 0.3))),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Nomor Identitas Anak (NIK) / No. KIA',
                          style: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight.w600,
                                  color: _C
                                      .onSurfaceVariant)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _nik,
                        keyboardType:
                            TextInputType.number,
                        decoration: InputDecoration(
                          hintText:
                              'Contoh: 3201234567890001',
                          hintStyle: GoogleFonts
                              .plusJakartaSans(
                                  fontSize: 12,
                                  color: _C.outline
                                      .withValues(
                                          alpha: 0.5)),
                          filled: true,
                          fillColor:
                              _C.surfaceLowest,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      12),
                              borderSide: BorderSide(
                                  color: _C
                                      .outlineVariant
                                      .withValues(
                                          alpha:
                                              0.5))),
                          contentPadding:
                              const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10),
                        ),
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Sistem mencocokkan rekam posyandu dan mengirim kode via verifikasi Kader.',
                        style: GoogleFonts
                            .plusJakartaSans(
                                fontSize: 11,
                                height: 1.4,
                                color: _C.outline),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity, height: 52,
          child: ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: _C.primaryContainer,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(28)),
              elevation: 6,
              shadowColor: _C.primaryContainer
                  .withValues(alpha: 0.4),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Kirim Kode Verifikasi (OTP)',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward,
                    size: 18, color: Colors.white),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer,
                size: 15, color: _C.outline),
            SizedBox(width: 4),
            Text(
                'Kode verifikasi 6-digit dikirim instan.',
                style: TextStyle(
                    fontSize: 12, color: _C.outline)),
          ],
        ),
        const SizedBox(height: 16),
        // Security card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _C.surfaceLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: _C.outlineVariant
                    .withValues(alpha: 0.4)),
          ),
          child: Column(
            children: [
              const Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  _Shield(),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text('Keamanan Akun Terjamin',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.w700)),
                        SizedBox(height: 2),
                        Text(
                            'PosyTrace tidak pernah meminta kata sandi atau OTP via jalur pribadi.',
                            style: TextStyle(
                                fontSize: 12,
                                height: 1.4,
                                color: _C
                                    .onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _C.outlineVariant
                                .withValues(
                                    alpha: 0.3)))),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.contact_support,
                            size: 16,
                            color: _C.outline),
                        SizedBox(width: 4),
                        Text(
                            'Nomor sudah tidak aktif?',
                            style: TextStyle(
                                fontSize: 12,
                                color: _C.outline)),
                      ],
                    ),
                    GestureDetector(
                      onTap: null,
                      child: const Row(
                        children: [
                          Text('Bidan / Kader Posyandu',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight.w700,
                                  color: _C
                                      .primaryContainer)),
                          Icon(Icons.arrow_outward,
                              size: 14,
                              color:
                                  _C.primaryContainer),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ingat kata sandi Anda?',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: _C.onSurfaceVariant)),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text('Kembali ke Masuk',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _C.primaryContainer)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tab(
      int idx, IconData icon, String label, bool badge) {
    final active = _method == idx;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _method = idx),
        child: Container(
          padding:
              const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: active
                ? _C.surfaceLowest
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            boxShadow: active
                ? [
                    BoxShadow(
                        color: const Color(0xFFE8863A)
                            .withValues(alpha: 0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 18,
                  color: active
                      ? _C.tertiary
                      : _C.outline),
              const SizedBox(width: 4),
              Text(label,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: active
                          ? _C.onSurface
                          : _C.outline)),
              if (badge && active) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: _C.tertiary
                          .withValues(alpha: 0.15),
                      borderRadius:
                          BorderRadius.circular(10)),
                  child: Text('Cepat',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: _C.tertiary)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _success() {
    final dest = _isWa
        ? '+62 ${_input.text}'
        : _input.text;
    return Column(
      children: [
        const SizedBox(height: 24),
        Container(
          width: 96, height: 96,
          decoration: BoxDecoration(
            color:
                _C.tertiary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.mark_email_read_outlined,
              size: 48, color: _C.tertiary),
        ),
        const SizedBox(height: 20),
        Text('Kode OTP Terkirim!',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 24, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text(
          'Masukkan 6-digit kode yang dikirim ke:',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 14, color: _C.onSurfaceVariant),
        ),
        const SizedBox(height: 6),
        Text(dest,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _C.primary)),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity, height: 52,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _C.primaryContainer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
            ),
            child: Text('Kembali ke Masuk',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () =>
              setState(() => _sent = false),
          child: Text('Kirim Ulang Kode',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _C.primary)),
        ),
      ],
    );
  }
}

class _PulseDot extends StatelessWidget {
  const _PulseDot();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 8, height: 8,
        decoration: const BoxDecoration(
            color: _C.primaryContainer,
            shape: BoxShape.circle));
  }
}

class _Shield extends StatelessWidget {
  const _Shield();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(
          color: _C.tertiaryFixedDim
              .withValues(alpha: 0.4),
          shape: BoxShape.circle),
      child: const Icon(Icons.shield,
          size: 18, color: _C.tertiary),
    );
  }
}
