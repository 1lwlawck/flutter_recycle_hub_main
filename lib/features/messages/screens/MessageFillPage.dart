import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/widgets/custom_bottom_navbar.dart';
import 'package:flutter_recycle_hub/features/messages/screens/MessagePage.dart'; // Import halaman pesan

class FillMessagePage extends StatelessWidget {
  const FillMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF006769), // Warna app bar yang tegas
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Tombol back berwarna putih
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 5, // Jumlah pesan yang ingin ditampilkan
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigasi ke halaman pesan saat card diklik
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MessagePage()),
                );
              },
              child: _buildMessageItem(
                avatar: 'assets/images/icons/pict_profile.png', // Path avatar
                name: 'Bank Sampah Mawar Merah',
                date: '8 Okt', // Tanggal
                messagePreview:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ultricies...',
              ),
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
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12.0), // Menambah ketegasan pada card
      ),
      elevation: 8,
      margin: const EdgeInsets.symmetric(
          vertical: 12.0), // Menambah jarak antar card
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Warna shadow
              offset: Offset(4, 4), // Posisi shadow
              blurRadius: 0, // Blur radius untuk efek kedalaman
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(18.0),
          leading: CircleAvatar(
            backgroundImage: AssetImage(avatar),
            radius: 35, // Ukuran avatar
            backgroundColor:
                const Color(0xFF006769), // Menambahkan transparansi di avatar
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            messagePreview,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          trailing: Text(
            date,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.bold, // Memberikan ketegasan pada tanggal
            ),
          ),
        ),
      ),
    );
  }
}
