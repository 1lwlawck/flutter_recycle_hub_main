import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/widgets/custom_bottom_navbar.dart';

class FillMessagePage extends StatelessWidget {
  const FillMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF006769), // App bar dengan warna yang sesuai
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Message',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10, // Jumlah pesan yang ingin ditampilkan
          itemBuilder: (context, index) {
            return _buildMessageItem(
              avatar: 'assets/images/icons/avatar.png', // Sesuaikan path avatar
              name: 'Bank Sampah Mawar Merah',
              date: '8 Okt', // Anda bisa menyesuaikan tanggal
              messagePreview:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ultricies... ',
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildMessageItem({
    required String avatar,
    required String name,
    required String date,
    required String messagePreview,
  }) {
    return Card(
      color: Colors.white, // Menambahkan warna putih pada card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Jarak antar pesan
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundImage: AssetImage(avatar),
          radius: 24,
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          messagePreview,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        trailing: Text(
          date,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
