// lib/widgets/user_greeting.dart
import 'package:flutter/material.dart';

class UserGreeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390, // Set fixed width
      height: 120, // Set fixed height
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: const [
              Text(
                "Selamat Pagi",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 5), // Adjust spacing
              Text(
                "Muhammad Asep",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5), // Adjust spacing
              Text(
                "Yuk jual sampah plastik disini!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 40, // Avatar size
            backgroundImage: AssetImage(
                'assets/images/icons/pict_profile.png'), // Replace with actual image path
          ),
        ],
      ),
    );
  }
}
