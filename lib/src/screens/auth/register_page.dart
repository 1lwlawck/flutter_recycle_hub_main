import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/src/widgets/btn_login.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  // Fungsi untuk dekorasi `InputDecoration` yang sama dengan halaman Login
  InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      labelText: hintText,
      filled: true,
      fillColor: Colors.grey[100],
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat Datang!',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Buat Akun Baru Kamu',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Input untuk Nama
            TextField(
              decoration: buildInputDecoration('Nama Lengkap'),
            ),
            const SizedBox(height: 16),

            // Input untuk Email
            TextField(
              decoration: buildInputDecoration('Masukan Email'),
            ),
            const SizedBox(height: 16),

            // Input untuk Password
            TextField(
              obscureText: true,
              decoration: buildInputDecoration('Masukan Kata Sandi'),
            ),
            const SizedBox(height: 16),

            // Checkbox untuk menyetujui Syarat & Ketentuan
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: true,
                  onChanged: (bool? value) {},
                  activeColor: Colors.blue,
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

            // Tombol Sign Up
            LoginButton(
              buttonText: 'Daftar',
              onPressed: () {
                // Fungsi yang dijalankan saat tombol Sign Up ditekan
                print('Sign Up button pressed');
              },
              backgroundColor: Colors.blueAccent,
              textColor: Colors.white,
              borderRadius: 20,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            const SizedBox(height: 20),

            // Divider "Atau" dengan garis di kiri dan kanan
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

            // Ikon Google dan Facebook untuk opsi sign up lain
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // Aksi untuk daftar dengan Google
                  },
                  icon: Image.asset(
                    'assets/images/icons/google_icons.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 20),

            // Bagian teks "Sudah Punya Akun?" dan "Masuk"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sudah Punya Akun?'),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke LoginScreen
                  },
                  child: const Text('Masuk'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
