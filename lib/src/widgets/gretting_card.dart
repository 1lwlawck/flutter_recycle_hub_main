// lib/widgets/user_greeting.dart
import 'package:flutter/material.dart';

class UserGreeting extends StatelessWidget {
  const UserGreeting({super.key});

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return "Selamat Pagi 🌞";
    } else if (hour >= 12 && hour < 18) {
      return "Selamat Siang ☀️";
    } else if (hour >= 18 && hour < 21) {
      return "Selamat Sore 🌅";
    } else {
      return "Selamat Malam 🌙";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width
      height: 120, // Fixed height
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Small radius
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(8, 8),
            blurRadius: 0, // Neo-brutalism style shadow
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
              const Text(
                "Muhammad Asep",
                style: TextStyle(
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
              color: const Color(0xFFF4F4F4), // Light background for the avatar
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10), // Small radius
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
                'assets/images/icons/pict_profile.png', // Replace with actual image path
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
