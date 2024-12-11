import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/features/auth/screens/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // Import package animated_text_kit

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen2> {
  @override
  void initState() {
    super.initState();
    // Delay 10 detik sebelum berpindah halaman ke LoginScreen dengan transisi geser
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Arah transisi dari kanan ke kiri
            const begin = Offset(1.0, 0.0); // Dari kanan ke kiri
            const end = Offset.zero; // Posisi akhir transisi
            const curve = Curves.easeInOut; // Untuk transisi yang smooth

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(
              milliseconds: 1000), // Durasi transisi lebih smooth
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/icons/bg-pict.jpg'), // Gambar lokal
            fit: BoxFit.cover, // Menyesuaikan gambar dengan ukuran layar
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Teks Slogan dengan font Inconsolata dan efek mengetik
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0), // Padding kiri dan kanan
                child: AnimatedTextKit(
                  repeatForever: false, // Hanya ketik sekali
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Dari Langkah Kecil Untuk Perubahan Besar Bagi Lingkungan',
                      textAlign: TextAlign.center,
                      textStyle: GoogleFonts.inconsolata(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.normal, // Pastikan font normal
                      ),
                      speed: const Duration(
                          milliseconds: 100), // Kecepatan mengetik
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Hashtag dengan style Neo Brutalism dan Box
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0), // Padding kiri dan kanan
                child: Container(
                  width: 250, // Lebar container disesuaikan
                  height: 50, // Tinggi container lebih kecil
                  padding: const EdgeInsets.all(
                      12.0), // Padding dalam container lebih kecil
                  decoration: BoxDecoration(
                    color: Colors.white, // Latar belakang putih
                    borderRadius: BorderRadius.circular(10), // Sudut melengkung
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6), // Warna shadow
                        offset: const Offset(5, 5), // Posisi shadow lebih halus
                        blurRadius: 0, // Efek blur pada shadow
                      ),
                    ],
                  ),
                  child: Center(
                    // Memastikan teks tetap berada di tengah
                    child: Text(
                      '#ubahsampahjadinilai',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inconsolata(
                        fontSize:
                            18, // Ukuran font disesuaikan agar lebih proporsional
                        color:
                            Colors.black, // Teks berwarna hitam untuk kontras
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Arrow Icon (Menunjukkan arah ke halaman selanjutnya)
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LoginScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        // Arah transisi dari kanan ke kiri
                        const begin = Offset(1.0, 0.0); // Dari kanan ke kiri
                        const end = Offset.zero; // Posisi akhir transisi
                        const curve =
                            Curves.easeInOut; // Untuk transisi yang smooth

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                            position: offsetAnimation, child: child);
                      },
                      transitionDuration: const Duration(
                          milliseconds: 800), // Durasi transisi lebih smooth
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
