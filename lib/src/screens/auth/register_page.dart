import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/src/widgets/btn_login.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      labelText: hintText,
      filled: true,
      fillColor: const Color(0xFFF4F4F4), // Warna latar untuk input
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Menghindari tumpang tindih keyboard
      backgroundColor: const Color(0xFF006769), // Latar belakang abu-abu terang
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 60.0),
          child: Center(
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(20.0),
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
                    'Buat Akun Baru Kamu',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input Nama
                  TextField(
                    decoration: buildInputDecoration('Nama Lengkap'),
                  ),
                  const SizedBox(height: 16),

                  // Input Email
                  TextField(
                    decoration: buildInputDecoration('Masukan Email'),
                  ),
                  const SizedBox(height: 16),

                  // Input Password
                  TextField(
                    obscureText: true,
                    decoration: buildInputDecoration('Masukan Kata Sandi'),
                  ),
                  const SizedBox(height: 16),

                  // Checkbox Syarat & Ketentuan
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (bool? value) {},
                        activeColor: const Color(0xFF006769),
                      ),
                      const Expanded(
                        child: Text(
                          'Dengan mendaftar, Anda menyetujui Syarat & Ketentuan dan Kebijakan Privasi kami.',
                          style: TextStyle(fontSize: 13),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Tombol Daftar
                  LoginButton(
                    buttonText: 'Daftar',
                    onPressed: () {
                      print('Sign Up button pressed');
                    },
                    backgroundColor: const Color(0xFF006769),
                    textColor: Colors.white,
                    borderRadius: 8,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  const SizedBox(height: 20),

                  // Divider "Atau daftar dengan"
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
                          'Atau daftar dengan',
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
                  const SizedBox(height: 10),

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

                  // Bagian Masuk
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah Punya Akun?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Kembali ke LoginScreen
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF006769),
                        ),
                        child: const Text('Masuk'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
