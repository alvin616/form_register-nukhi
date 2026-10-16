import 'package:flutter/material.dart';

void main() => runApp(const RegistrationApp());

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBrown = Color(0xFF49372B);
    const cream = Color(0xFFF7F1E8);
    const mediumBrown = Color(0xFF92745D);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Registrasi',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: darkBrown,
          primary: darkBrown,
          secondary: mediumBrown,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFCFAF7),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE2D4C5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE2D4C5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: mediumBrown, width: 1.8),
          ),
        ),
      ),
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  String? _gender;
  String? _studyProgram;
  bool _acceptedTerms = false;
  bool _obscurePassword = true;

  final List<String> _programs = const [
    'Sistem Informasi',
    'Informatika',
    'Manajemen',
    'Akuntansi',
    'Pendidikan',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Silakan setujui Syarat & Ketentuan terlebih dahulu.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    if (_gender == null || _studyProgram == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Pilih jenis kelamin dan program studi terlebih dahulu.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFFFFFCF8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.verified_user_outlined, color: Color(0xFF49372B)),
            SizedBox(width: 10),
            Expanded(child: Text('Konfirmasi Registrasi')),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Periksa kembali data berikut sebelum melanjutkan:'),
              const SizedBox(height: 16),
              _summaryRow('Nama', _nameController.text.trim()),
              _summaryRow('Email', _emailController.text.trim()),
              _summaryRow('Jenis Kelamin', _gender!),
              _summaryRow('Program Studi', _studyProgram!),
              const SizedBox(height: 8),
              const Text(
                'Password tidak ditampilkan demi keamanan.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Periksa Lagi'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF49372B),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registrasi berhasil dikonfirmasi (demo).'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Konfirmasi'),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 112,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF92745D),
            ),
          ),
        ),
        const Text(': '),
        Expanded(child: Text(value)),
      ],
    ),
  );

  Widget _fieldLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Color(0xFF49372B),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF49372B),
        foregroundColor: const Color(0xFFFFF8F0),
        centerTitle: true,
        title: const Text(
          'FORM REGISTRASI',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Card(
                color: Colors.white,
                elevation: 3,
                shadowColor: const Color(0x2249372B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: const BorderSide(color: Color(0xFFE8DCCF)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFFF1E5D7),
                            child: Icon(
                              Icons.person_add_alt_1,
                              size: 30,
                              color: Color(0xFF49372B),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Center(
                          child: Text(
                            'Buat Akun Baru',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF49372B),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Center(
                          child: Text(
                            'Lengkapi data berikut untuk mendaftar.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        const SizedBox(height: 28),

                        _fieldLabel('Nama Lengkap'),
                        TextFormField(
                          controller: _nameController,
                          focusNode: _nameFocus,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_emailFocus),
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama lengkap',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nama lengkap tidak boleh kosong.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        _fieldLabel('Email'),
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_passwordFocus),
                          decoration: const InputDecoration(
                            hintText: 'contoh@email.com',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            final email = value?.trim() ?? '';
                            if (email.isEmpty) return 'Email tidak boleh kosong.';
                            if (!email.contains('@')) {
                              return 'Email harus mengandung tanda @.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        _fieldLabel('Password'),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submitForm(),
                          decoration: InputDecoration(
                            hintText: 'Minimal 6 karakter',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              tooltip: _obscurePassword
                                  ? 'Tampilkan password'
                                  : 'Sembunyikan password',
                              onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword,
                              ),
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong.';
                            }
                            if (value.length < 6) {
                              return 'Password minimal 6 karakter.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 22),

                        _fieldLabel('Jenis Kelamin'),
                        RadioGroup<String>(
                          groupValue: _gender,
                          onChanged: (value) => setState(() => _gender = value),
                          child: const Column(
                            children: [
                              RadioListTile<String>(
                                value: 'Laki-laki',
                                title: Text('Laki-laki'),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                              RadioListTile<String>(
                                value: 'Perempuan',
                                title: Text('Perempuan'),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        _fieldLabel('Program Studi'),
                        DropdownButtonFormField<String>(
                          value: _studyProgram,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.school_outlined),
                          ),
                          hint: const Text('Pilih program studi'),
                          items: _programs
                              .map((program) => DropdownMenuItem<String>(
                            value: program,
                            child: Text(program),
                          ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => _studyProgram = value),
                        ),
                        const SizedBox(height: 12),

                        CheckboxListTile(
                          value: _acceptedTerms,
                          onChanged: (value) =>
                              setState(() => _acceptedTerms = value ?? false),
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            'Saya setuju dengan Syarat & Ketentuan',
                            style: TextStyle(fontSize: 14),
                          ),
                          subtitle: const Text(
                            'Persetujuan diperlukan untuk melanjutkan registrasi.',
                            style: TextStyle(fontSize: 12),
                          ),
                          activeColor: const Color(0xFF49372B),
                        ),
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton.icon(
                            onPressed: _submitForm,
                            icon: const Icon(Icons.app_registration),
                            label: const Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF49372B),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
