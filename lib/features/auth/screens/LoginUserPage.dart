import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_recycle_hub/features/auth/service/LoginServiceApi.dart';
import 'package:flutter_recycle_hub/utils/shared_prefs_util.dart'; // Utility SharedPreferences
import 'package:flutter_recycle_hub/features/auth/widgets/BtnLogin.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool isLoggingIn = false;

  String? emailError;
  String? passwordError;

  final AuthLoginService _authService = AuthLoginService();

  Future<void> _login() async {
    setState(() {
      emailError = null;
      passwordError = null;
      isLoggingIn = true;
    });

    String enteredEmail = emailController.text.trim();
    String enteredPassword = passwordController.text;

    // Validasi input
    if (enteredEmail.isEmpty) {
      setState(() {
        emailError = 'Email tidak boleh kosong';
        isLoggingIn = false;
      });
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
        .hasMatch(enteredEmail)) {
      setState(() {
        emailError = 'Email tidak valid';
        isLoggingIn = false;
      });
      return;
    }
    if (enteredPassword.isEmpty) {
      setState(() {
        passwordError = 'Password tidak boleh kosong';
        isLoggingIn = false;
      });
      return;
    }

    // Memanggil login service
    final result = await _authService.login(
      email: enteredEmail,
      password: enteredPassword,
      remember: rememberMe,
    );

    if (result['success']) {
      // Simpan akses token dan nama pengguna ke SharedPreferences
      await SharedPrefsUtil.saveAccessToken(result['access_token']);
      await SharedPrefsUtil.saveRefreshToken(result['refresh_token']);

      // Pindah ke halaman home setelah login berhasil
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Tampilkan pesan error jika login gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Login gagal')),
      );
    }

    setState(() {
      isLoggingIn = false;
    });
  }

  // Fungsi untuk membuka URL lupa kata sandi
  Future<void> openForgotPasswordLink() async {
    final Uri forgotPasswordUri =
        Uri.parse('http://192.168.1.9:5000/password/forgot');

    if (!await launchUrl(forgotPasswordUri)) {
      throw 'Tidak dapat membuka URL: $forgotPasswordUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF006769),
      body: Center(
        child: Container(
          width: 385,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(10, 10),
                blurRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Masuk Ke Akun Kamu',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: emailController,
                label: 'Masukan Email',
                errorText: emailError,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                controller: passwordController,
                label: 'Masukan Kata Sandi',
                obscureText: true,
                errorText: passwordError,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: openForgotPasswordLink,
                    child: const Text(
                      'Lupa Kata Sandi?',
                      style: TextStyle(
                        color: Color(0xFF006769),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              if (isLoggingIn)
                Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.green,
                    size: 50,
                  ),
                ),
              if (!isLoggingIn)
                LoginButton(
                  buttonText: 'Masuk',
                  onPressed: _login,
                  backgroundColor: const Color(0xff006769),
                  textColor: Colors.white,
                  borderRadius: 8,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    'Belum Punya Akun? Daftar Sekarang',
                    style: TextStyle(
                      color: Color(0xFF006769),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    String? errorText,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Color(0xFF333333)),
            filled: true,
            fillColor: const Color(0xFFF0F0F0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
