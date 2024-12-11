import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/splash/splash2.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay 3 detik sebelum berpindah halaman dengan transisi geser
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SplashScreen2(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Arah transisi dari kanan ke kiri
            const end = Offset.zero;
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
      backgroundColor: const Color(0xFF006769),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/icons/recycle_hub.png', // Sesuaikan path logo kamu
              width: 400,
              height: 400,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
