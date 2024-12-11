import 'package:flutter/material.dart';
import '../../../widgets/custom_bottom_navbar.dart'; // Import your custom bottom navbar widget

class EmptyOrderPage extends StatelessWidget {
  const EmptyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 74, 250),
        elevation: 0,
        title: const Text(
          'My Order',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
            // Menavigasi ke halaman home dan membersihkan stack navigasi sebelumnya
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(
                  context, '/history'); // Navigate to Order History Page
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Order icon
              Image.asset(
                'assets/images/icons/order_icon.png', // Replace with actual image path
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              // "Tidak ada Order" text
              const Text(
                "Tidak ada Order",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Description text
              Text(
                "Ayo, daur ulang sampahmu sekarang!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 1, // Set to 1 as Orders is the second tab
      ),
    );
  }
}
