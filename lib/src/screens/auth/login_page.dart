import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/src/widgets/btn_login.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String dummyEmail = 'asep@gmail.com';
  final String dummyPassword = 'asep123';

  String? emailError;
  String? passwordError;

  void _login() {
    setState(() {
      emailError = null;
      passwordError = null;

      String enteredEmail = emailController.text.trim();
      String enteredPassword = passwordController.text;

      if (enteredEmail.isEmpty) {
        emailError = 'Email tidak boleh kosong';
      } else if (enteredEmail.toLowerCase() != dummyEmail.toLowerCase()) {
        emailError = 'Email tidak valid';
      }

      if (enteredPassword.isEmpty) {
        passwordError = 'Password tidak boleh kosong';
      } else if (enteredPassword != dummyPassword) {
        passwordError = 'Password salah';
      }

      if (emailError == null && passwordError == null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Periksa kembali email atau password Anda'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF006769),
      body: Center(
        child: Container(
          width: 385,
          padding:
              const EdgeInsets.only(top: 1, left: 15, right: 15, bottom: 0),
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
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Masuk Ke Akun Kamu',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Input Email
              _buildInputField(
                controller: emailController,
                label: 'Masukan Email',
                errorText: emailError,
              ),
              const SizedBox(height: 16),

              // Input Password
              _buildInputField(
                controller: passwordController,
                label: 'Masukan Kata Sandi',
                obscureText: true,
                errorText: passwordError,
              ),
              const SizedBox(height: 5),

              // Lupa Kata Sandi
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/verify_email');
                    },
                    child: const Text(
                      'Lupa Kata Sandi?',
                      style: TextStyle(color: Color(0xFF006769)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 3),

              // Tombol Login
              LoginButton(
                buttonText: 'Masuk',
                onPressed: _login,
                backgroundColor: const Color(0xff006769),
                textColor: Colors.white,
                borderRadius: 8,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              const SizedBox(height: 20),

              // Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Atau masuk dengan',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Ikon Google
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(5, 5),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/icons/google_icons.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Bagian Daftar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum Punya Akun?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF006769),
                    ),
                    child: const Text('Daftar'),
                  ),
                ],
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
