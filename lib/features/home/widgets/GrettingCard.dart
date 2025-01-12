import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_recycle_hub/core/models/Users.dart';
import 'package:flutter_recycle_hub/core/services/Config.dart';
import 'package:flutter_recycle_hub/features/account/services/UserService.dart';

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

  // Fungsi untuk mendapatkan data pengguna
  Future<User?> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId == null) {
      return null; // User belum login
    }
    return await UserService.getUser(userId);
  }

  @override
  Widget build(BuildContext context) {
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
              FutureBuilder<User?>(
                future: _getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      "Loading...",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Text(
                      "Error",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  } else {
                    final user = snapshot.data!;
                    return Text(
                      user.namaUser,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  }
                },
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
          FutureBuilder<User?>(
            future: _getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.person, size: 50),
                );
              } else {
                final user = snapshot.data!;
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: (user.avatar != null && user.avatar!.isNotEmpty)
                        ? Image.network(
                            '${Config.API_URL}/static/uploads/avatars/${user.avatar}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person, size: 50);
                            },
                          )
                        : const Icon(Icons.person, size: 50),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
