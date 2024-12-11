import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/widgets/custom_bottom_navbar.dart';

class EmptyMessagePage extends StatelessWidget {
  const EmptyMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 74, 250),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Message',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white, // Warna hijau untuk tombol back
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ilustrasi atau gambar pesan kosong
            Image.asset(
              'assets/images/icons/empty_message.png', // Sesuaikan path dengan lokasi gambar ilustrasi
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 24),
            // Teks "Tidak ada Message"
            const Text(
              'Tidak ada Message',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            // Teks deskripsi tambahan
            const Text(
              'Ayo, daur ulang sampahmu sekarang!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}
