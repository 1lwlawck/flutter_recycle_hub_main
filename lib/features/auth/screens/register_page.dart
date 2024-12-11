import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/features/auth/service/register_service_api.dart';
import 'package:flutter_recycle_hub/features/auth/service/otp_service_api.dart';
import 'package:flutter_recycle_hub/features/auth/widgets/btn_login.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController =
      TextEditingController(); // Controller OTP
  bool _isChecked = false; // Checkbox untuk Syarat & Ketentuan
  bool otpSent = true; // Menandakan apakah OTP sudah dikirim
  bool isOtpVerified =
      false; // Variabel untuk menandai apakah OTP valid atau tidak
  String? message; // Pesan yang akan ditampilkan

  // Menyimpan error untuk setiap field
  String? namaError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  InputDecoration buildInputDecoration(String hintText, {String? errorText}) {
    return InputDecoration(
      labelText: hintText,
      filled: true,
      fillColor: const Color(0xFFF4F4F4),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      errorText: errorText, // Menambahkan errorText
    );
  }

  // Function untuk mengirim request registrasi
  Future<void> register(String namaUser, String email, String password) async {
    final registerService = RegisterServiceApi();
    final response = await registerService.register(
      namaUser,
      email,
      password,
      password,
    );

    if (response != null && response.containsKey('message')) {
      String responseMessage = response['message'] ?? 'Unknown error';
      print("Response Message: $responseMessage");

      setState(() {
        message = responseMessage;
        if (responseMessage == 'OTP telah dikirim ke email Anda.') {
          otpSent = true; // Menandakan bahwa OTP sudah dikirim
          // Kosongkan semua TextField
          namaController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        }
      });

      // Menghilangkan pesan setelah 5 detik
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            message = null;
          });
        }
      });
    } else {
      setState(() {
        message = 'Terjadi kesalahan, coba lagi nanti.';
        otpSent = false;
      });

      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            message = null;
          });
        }
      });
    }
  }

  Future<void> verifyOtp(String otp) async {
    final registerService = OtpServiceApi();
    final response = await registerService.verifyOtp(
      emailController
          .text, // Menggunakan email yang telah dimasukkan sebelumnya
      otp,
    );

    if (response != null && response.containsKey('message')) {
      String responseMessage = response['message'] ?? 'Unknown error';
      print("OTP Verification Message: $responseMessage");

      setState(() {
        message = responseMessage; // Menampilkan pesan berdasarkan respons
      });

      if (responseMessage == 'OTP valid') {
        setState(() {
          isOtpVerified = true; // Menandakan OTP berhasil diverifikasi
        });

        // Berhasil, pindah ke halaman Login
        Navigator.pushNamed(context, '/login');
      }

      // Menghilangkan pesan setelah 5 detik
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            message = null;
          });
        }
      });
    } else {
      setState(() {
        message = 'Terjadi kesalahan saat verifikasi OTP.';
      });
    }
  }

  // Validasi input
  bool validateInputs() {
    bool isValid = true;

    setState(() {
      namaError = namaController.text.isEmpty
          ? 'Nama Lengkap tidak boleh kosong'
          : null;
      emailError =
          emailController.text.isEmpty ? 'Email tidak boleh kosong' : null;
      passwordError = passwordController.text.isEmpty
          ? 'Kata Sandi tidak boleh kosong'
          : null;
      confirmPasswordError = confirmPasswordController.text.isEmpty
          ? 'Konfirmasi Kata Sandi tidak boleh kosong'
          : passwordController.text != confirmPasswordController.text
              ? 'Kata Sandi tidak sama'
              : null;

      // Validasi Checkbox
      if (!_isChecked) {
        message = 'Anda harus menyetujui syarat dan ketentuan';
        isValid = false;
      }

      // Jika ada error, return false
      if (namaError != null ||
          emailError != null ||
          passwordError != null ||
          confirmPasswordError != null) {
        isValid = false;
      }
    });

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF006769),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 100.0),
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

                  // Pesan error jika ada
                  if (message != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        message!,
                        style: TextStyle(
                          color: otpSent ? Colors.green : Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  // Input untuk Nama
                  TextField(
                    controller: namaController,
                    decoration: buildInputDecoration('Nama Lengkap',
                        errorText: namaError),
                  ),
                  const SizedBox(height: 16),

                  // Input untuk Email
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: buildInputDecoration('Masukkan Email',
                        errorText: emailError),
                  ),
                  const SizedBox(height: 16),

                  // Input untuk Kata Sandi
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: buildInputDecoration('Masukkan Kata Sandi',
                        errorText: passwordError),
                  ),
                  const SizedBox(height: 16),

                  // Input untuk Konfirmasi Kata Sandi
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: buildInputDecoration('Konfirmasi Kata Sandi',
                        errorText: confirmPasswordError),
                  ),
                  const SizedBox(height: 16),

                  // Checkbox Syarat & Ketentuan
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
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
                      String namaUser = namaController.text;
                      String email = emailController.text;
                      String password = passwordController.text;

                      if (validateInputs()) {
                        register(namaUser, email, password);
                      } else {
                        setState(() {
                          message =
                              'Pastikan semua input valid dan tidak kosong!';
                        });

                        Future.delayed(const Duration(seconds: 5), () {
                          if (mounted) {
                            setState(() {
                              message = null;
                            });
                          }
                        });
                      }
                    },
                    backgroundColor: const Color(0xFF006769),
                    textColor: Colors.white,
                    borderRadius: 8,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  const SizedBox(height: 16),
                  // Tombol Sudah Punya Akun? Masuk
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah punya akun? ',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF333333)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/login'); // Arahkan ke halaman login
                        },
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF006769),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  if (otpSent) ...[
                    // Input OTP dengan tombol verifikasi di dalamnya
                    TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Masukkan OTP',
                        filled: true,
                        fillColor: const Color(0xFFF4F4F4),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              String otp = otpController.text;
                              if (otp.isNotEmpty) {
                                verifyOtp(otp); // Verifikasi OTP
                              } else {
                                setState(() {
                                  message = 'OTP tidak boleh kosong';
                                });

                                Future.delayed(const Duration(seconds: 5), () {
                                  if (mounted) {
                                    setState(() {
                                      message = null;
                                    });
                                  }
                                });
                              }
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 8),
                              minimumSize: Size(0, 0), // Ukuran tombol kecil
                            ),
                            child: Text(
                              'Verifikasi',
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color(0xFF006769), // Warna teks
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
