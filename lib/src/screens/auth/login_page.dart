import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/src/widgets/btn_login.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller untuk input email dan password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Data Dummy untuk validasi login
  final String dummyEmail = 'asep@gmail.com';
  final String dummyPassword = 'asep123';

  // Variabel untuk menampung pesan kesalahan
  String? emailError;
  String? passwordError;

  // Fungsi untuk validasi login
  void _login() {
    setState(() {
      emailError = null;
      passwordError = null;

      String enteredEmail = emailController.text.trim();
      String enteredPassword = passwordController.text;

      print("Entered Email: $enteredEmail, Dummy Email: $dummyEmail");
      print(
          "Entered Password: $enteredPassword, Dummy Password: $dummyPassword");

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
              content: Text('Periksa kembali email atau password Anda')),
        );
      }
    });
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
              'Masuk Ke Akun Kamu',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Field Input Email dengan pesan kesalahan
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Masukan Email',
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                if (emailError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      emailError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Field Input Password dengan pesan kesalahan
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Masukan Kata Sandi',
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                if (passwordError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      passwordError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (bool? value) {}),
                    const Text('Ingat Saya'),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/verify_email');
                  },
                  child: const Text('Lupa Kata Sandi?'),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Tombol Login dengan fungsi _login sebagai onPressed
            LoginButton(
              buttonText: "Masuk",
              onPressed: _login,
              backgroundColor: Colors.blueAccent,
              textColor: Colors.white,
              borderRadius: 20,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            const SizedBox(height: 20),

            // Divider "Atau masuk dengan" dengan garis
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
            const SizedBox(height: 10),

            // Ikon Google untuk login
            IconButton(
              onPressed: () {
                // Tambahkan logika login Google
              },
              icon: Image.asset(
                'assets/images/icons/google_icons.png',
                width: 50,
                height: 50,
              ),
            ),

            const SizedBox(height: 10),

            // Bagian teks "Belum Punya Akun?" dan "Daftar"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Belum Punya Akun?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Daftar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
