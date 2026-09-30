import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _C {
  static const bg = Color(0xFFFDF7FF);
  static const primary = Color(0xFF632CE5);
  static const primaryContainer = Color(0xFF7C4DFF);
  static const secondary = Color(0xFF4B00CC);
  static const onSurface = Color(0xFF1D1A25);
  static const onSurfaceVariant = Color(0xFF494455);
  static const outline = Color(0xFF7A7487);
  static const outlineVariant = Color(0xFFCAC3D8);
  static const surfaceContainer = Color(0xFFF2EBFB);
  static const surfaceHigh = Color(0xFFEDE5F5);
  static const fieldBg = Color(0xFFF7F5FC);
  static const error = Color(0xFFBA1A1A);
  static const tertiary = Color(0xFF00655A);
}

const _posyandu = [
  'Posyandu Melati 03 - Sukamaju (RW 05)',
  'Posyandu Melati 01 - Sukamaju (RW 02)',
  'Posyandu Mawar 02 - Mekarjaya (RW 03)',
  'Posyandu Kenanga 05 - Sukamaju (RW 08)',
];

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _wa = TextEditingController();
  final _nik = TextEditingController();
  final _pw = TextEditingController();
  final _pw2 = TextEditingController();
  int _role = 0; // 0 ortu, 1 kader
  String _pos = _posyandu[0];
  bool _ob1 = true;
  bool _ob2 = true;
  bool _agree = true;

  /// Kekuatan sandi 0..4. Diperbarui lewat listener sehingga
  /// hanya indikator meter yang rebuild, bukan seluruh form.
  final ValueNotifier<int> _strengthN = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _pw.addListener(_syncStrength);
  }

  void _syncStrength() {
    final v = _pw.text;
    final s = v.isEmpty
        ? 0
        : v.length < 6
            ? 1
            : v.length < 8
                ? 2
                : v.length < 10
                    ? 3
                    : 4;
    if (_strengthN.value != s) _strengthN.value = s;
  }

  @override
  void dispose() {
    _pw.removeListener(_syncStrength);
    _strengthN.dispose();
    _name.dispose();
    _wa.dispose();
    _nik.dispose();
    _pw.dispose();
    _pw2.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Centang persetujuan terlebih dahulu',
            style: GoogleFonts.plusJakartaSans(fontSize: 12)),
        backgroundColor: const Color(0xFF322F3A),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 44, height: 44,
                      decoration: const BoxDecoration(
                          color: _C.surfaceContainer,
                          shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_back,
                          color: _C.primary),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFF651FFF)
                                .withValues(alpha: 0.05),
                            blurRadius: 16,
                            offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 28, height: 28,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) =>
                                const Icon(
                                    Icons.child_care_rounded,
                                    color: _C.primary),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('POSY Trace',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: _C.primary)),
                      ],
                    ),
                  ),
                  Container(
                      width: 10, height: 10,
                      decoration: BoxDecoration(
                          color: _C.primaryContainer
                              .withValues(alpha: 0.3),
                          shape: BoxShape.circle)),
                ],
              ),
              const SizedBox(height: 16),
              // Headline
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                    color: _C.surfaceContainer,
                    borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.how_to_reg,
                        size: 14, color: _C.secondary),
                    SizedBox(width: 4),
                    Text('REGISTRASI DIGITAL POSYANDU',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            color: _C.secondary)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      color: _C.onSurface),
                  children: const [
                    TextSpan(text: 'Daftar Akun '),
                    TextSpan(
                        text: 'POSY Trace',
                        style: TextStyle(
                            color: _C.primaryContainer)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Bergabung untuk pantau gizi dan jadwal posyandu balita secara mudah.',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: _C.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              // Role
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text('Daftar sebagai apa?',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _C.onSurfaceVariant)),
                  const Row(
                    children: [
                      Icon(Icons.info,
                          size: 13, color: _C.primary),
                      SizedBox(width: 2),
                      Text('Pilih peran Anda',
                          style: TextStyle(
                              fontSize: 10,
                              color: _C.primary)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _roleCard(0)),
                  const SizedBox(width: 12),
                  Expanded(child: _roleCard(1)),
                ],
              ),
              const SizedBox(height: 16),
              // Form
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xFF651FFF)
                            .withValues(alpha: 0.05),
                        blurRadius: 16,
                        offset: const Offset(0, 4)),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _label('Nama Lengkap *'),
                      TextFormField(
                        controller: _name,
                        validator: (v) =>
                            (v == null || v.isEmpty)
                                ? 'Nama wajib diisi'
                                : null,
                        decoration: _dec(
                            hint:
                                'Sesuai KTP / KIA (misal: Bunda Siti)',
                            icon: Icons.person),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nomor WhatsApp Aktif *',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                          const Row(
                            children: [
                              Icon(Icons.notifications_active,
                                  size: 13,
                                  color: _C.tertiary),
                              SizedBox(width: 2),
                              Text('Pengingat Jadwal',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _C.tertiary)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _wa,
                        keyboardType: TextInputType.phone,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Nomor WA wajib diisi';
                          }
                          if (v.length < 9) {
                            return 'Nomor tidak valid';
                          }
                          return null;
                        },
                        decoration: _dec(
                          hint: '812-3456-7890',
                          icon: Icons.chat,
                          prefixText: '+62 ',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Untuk pengingat jadwal posyandu otomatis & pesan imunisasi.',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: _C.outline),
                      ),
                      const SizedBox(height: 12),
                      _label('Nomor Induk Kependudukan (NIK) *'),
                      TextFormField(
                        controller: _nik,
                        keyboardType: TextInputType.number,
                        maxLength: 16,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'NIK wajib diisi';
                          }
                          if (v.length != 16) {
                            return 'NIK harus 16 digit';
                          }
                          return null;
                        },
                        decoration: _dec(
                          hint: '16 digit NIK orang tua',
                          icon: Icons.badge,
                          suffixText: '16 digit',
                        ),
                      ),
                      const SizedBox(height: 12),
                      _label('Pilih Posyandu / Wilayah Binaan *'),
                      DropdownButtonFormField<String>(
                        initialValue: _pos,
                        items: _posyandu
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e,
                                    overflow:
                                        TextOverflow.ellipsis,
                                    style: GoogleFonts
                                        .plusJakartaSans(
                                            fontSize: 13))))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _pos = v!),
                        decoration: _dec(
                            hint: '', icon: Icons.location_on),
                      ),
                      Text(
                        'Data posyandu menentukan jadwal timbangan rutin Anda.',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: _C.outline),
                      ),
                      const SizedBox(height: 12),
                      _label('Kata Sandi *'),
                      TextFormField(
                        controller: _pw,
                        obscureText: _ob1,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Wajib diisi';
                          }
                          if (v.length < 8) {
                            return 'Minimal 8 karakter';
                          }
                          return null;
                        },
                        decoration: _dec(
                          hint: 'Minimal 8 karakter',
                          icon: Icons.lock,
                          suffix: IconButton(
                            onPressed: () => setState(
                                () => _ob1 = !_ob1),
                            icon: Icon(
                                _ob1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: _C.outline),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _label('Konfirmasi Kata Sandi *'),
                      TextFormField(
                        controller: _pw2,
                        obscureText: _ob2,
                        validator: (v) {
                          if (v != _pw.text) {
                            return 'Tidak cocok';
                          }
                          return null;
                        },
                        decoration: _dec(
                          hint: 'Ketik ulang kata sandi',
                          icon: Icons.lock_reset,
                          suffix: IconButton(
                            onPressed: () => setState(
                                () => _ob2 = !_ob2),
                            icon: Icon(
                                _ob2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: _C.outline),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder<int>(
                        valueListenable: _strengthN,
                        builder: (ctx, s, child) => Container(
                          padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8),
                          decoration: BoxDecoration(
                              color: _C.surfaceContainer
                                  .withValues(alpha: 0.6),
                              borderRadius:
                                  BorderRadius.circular(
                                      12)),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      width: 8,
                                      height: 8,
                                      decoration:
                                          const BoxDecoration(
                                              color: _C
                                                  .tertiary,
                                              shape: BoxShape
                                                  .circle)),
                                  const SizedBox(
                                      width: 6),
                                  Text(
                                      'Kekuatan Sandi: ${_strengthLabel(s)}',
                                      style: GoogleFonts
                                          .plusJakartaSans(
                                              fontSize:
                                                  10,
                                              fontWeight:
                                                  FontWeight
                                                      .w700,
                                              color: _C
                                                  .onSurfaceVariant)),
                                ],
                              ),
                              Row(
                                children:
                                    List.generate(4, (i) {
                                  return Container(
                                    width: 24,
                                    height: 6,
                                    margin: const EdgeInsets
                                        .only(left: 4),
                                    decoration:
                                        BoxDecoration(
                                      color: i < s
                                          ? _C
                                              .primaryContainer
                                          : _C
                                              .outlineVariant,
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                                  3),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => setState(
                            () => _agree = !_agree),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _agree,
                              activeColor:
                                  _C.primaryContainer,
                              onChanged: (v) => setState(
                                  () =>
                                      _agree = v ?? false),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts
                                      .plusJakartaSans(
                                          fontSize: 12,
                                          height: 1.5,
                                          color: _C
                                              .onSurfaceVariant),
                                  children: const [
                                    TextSpan(
                                        text:
                                            'Saya menyetujui '),
                                    TextSpan(
                                        text:
                                            'Syarat & Ketentuan',
                                        style: TextStyle(
                                            fontWeight:
                                                FontWeight.w700,
                                            color:
                                                _C.primary)),
                                    TextSpan(text: ' serta '),
                                    TextSpan(
                                        text:
                                            'Kebijakan Privasi',
                                        style: TextStyle(
                                            fontWeight:
                                                FontWeight.w700,
                                            color:
                                                _C.primary)),
                                    TextSpan(
                                        text:
                                            ' data medis anak di POSY Trace.'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity, height: 52,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _C.primaryContainer,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                        28)),
                            elevation: 6,
                          ),
                          child: const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text('Daftar Sekarang',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.w700,
                                      color: Colors.white)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward,
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: _C.surfaceContainer
                        .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(16)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.verified_user,
                        size: 18, color: _C.tertiary),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Data KMS & imunisasi dijamin rahasia & aman standar Dinkes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11,
                            color: _C.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sudah punya akun?',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: _C.onSurfaceVariant)),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text('Masuk di sini',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              decoration:
                                  TextDecoration.underline,
                              color: _C.primary)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _strengthLabel(int s) {
    if (s <= 1) return 'Lemah';
    if (s == 2) return 'Cukup';
    if (s == 3) return 'Baik';
    return 'Kuat';
  }

  Widget _roleCard(int idx) {
    final active = _role == idx;
    final isParent = idx == 0;
    return GestureDetector(
      onTap: () => setState(() => _role = idx),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: active
                  ? _C.surfaceContainer
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: active
                      ? _C.primaryContainer
                      : Colors.transparent,
                  width: 2),
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF651FFF)
                        .withValues(
                            alpha: active ? 0.16 : 0.05),
                    blurRadius: active ? 24 : 16,
                    offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                      color: active
                          ? Colors.white
                          : _C.surfaceContainer,
                      shape: BoxShape.circle),
                  child: Icon(
                      isParent
                          ? Icons.family_restroom
                          : Icons.assignment_turned_in,
                      size: 22,
                      color: active
                          ? _C.primaryContainer
                          : _C.outline),
                ),
                const SizedBox(height: 10),
                Text(
                    isParent
                        ? 'Orang Tua Balita'
                        : 'Kader Posyandu',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                Text(
                    isParent
                        ? 'Pantau KMS & BB anak'
                        : 'Perlu verifikasi Bidan',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: _C.onSurfaceVariant)),
              ],
            ),
          ),
          if (active)
            Positioned(
              top: -10, right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: _C.primaryContainer,
                    borderRadius:
                        BorderRadius.circular(20)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle,
                        size: 12, color: Colors.white),
                    SizedBox(width: 2),
                    Text('Dipilih',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _label(String t) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: RichText(
          text: TextSpan(
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _C.onSurface),
            children: [
              TextSpan(text: t.replaceAll(' *', '')),
              const TextSpan(
                  text: ' *',
                  style: TextStyle(color: _C.error)),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _dec(
      {required String hint,
      required IconData icon,
      Widget? suffix,
      String? suffixText,
      String? prefixText}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14, color: _C.outline.withValues(alpha: 0.7)),
      prefixIcon: Icon(icon, size: 20, color: _C.outline),
      prefixText: prefixText,
      prefixStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14, fontWeight: FontWeight.w700),
      suffixIcon: suffix ??
          (suffixText != null
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                        color: _C.surfaceHigh,
                        borderRadius:
                            BorderRadius.circular(6)),
                    child: Text(suffixText,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: _C.outline)),
                  ),
                )
              : null),
      filled: true,
      fillColor: _C.fieldBg,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
              color: _C.primaryContainer, width: 2)),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 14),
    );
  }
}
