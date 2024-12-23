import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserGreeting extends StatelessWidget {
  const UserGreeting({super.key});

  // Fungsi untuk mendapatkan pesan sapaan berdasarkan waktu
  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 9) {
      return "Selamat Pagi 🌞";
    } else if (hour >= 12 && hour < 18) {
      return "Selamat Siang ☀️";
    } else if (hour >= 18 && hour < 21) {
      return "Selamat Sore 🌅";
    } else {
      return "Selamat Malam 🌙";
    }
  }

  // Fungsi untuk mengambil nama pengguna dari SharedPreferences
  Future<String> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name') ??
        "Pengguna"; // Default "Pengguna" jika tidak ada
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getUserName(), // Memanggil fungsi untuk mengambil nama pengguna
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child:
                CircularProgressIndicator(), // Tampilkan loading jika data sedang diambil
          );
        } else if (snapshot.hasError) {
          return const Center(
            child:
                Text('Terjadi kesalahan!'), // Menampilkan pesan error jika ada
          );
        } else if (snapshot.hasData) {
          final userName = snapshot.data!; // Mendapatkan nama pengguna
          return Container(
            width: double.infinity,
            height: 120,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(8, 8),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Greeting text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getGreetingMessage(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userName, // Menampilkan nama pengguna
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      "Ubah Sampah Plastik Jadi Nilai",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                // Profile Picture
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(4, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/icons/pict_profile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Tidak ada data'), // Jika tidak ada data
          );
        }
      },
    );
  }
}
