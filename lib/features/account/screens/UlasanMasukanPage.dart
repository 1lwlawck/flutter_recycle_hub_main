import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/features/account/services/UlasanService.dart'; // Pastikan import sesuai struktur file Anda

class UlasanMasukanPage extends StatefulWidget {
  const UlasanMasukanPage({super.key});

  @override
  State<UlasanMasukanPage> createState() => _UlasanMasukanPageState();
}

class _UlasanMasukanPageState extends State<UlasanMasukanPage> {
  final TextEditingController _ulasanController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitUlasan() async {
    if (_ulasanController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ulasan tidak boleh kosong')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await UlasanService.postUlasan(_ulasanController.text);

    setState(() {
      _isLoading = false;
    });

    if (result["success"] == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white, // Background dialog putih
            title: const Text(
              'Ulasan Berhasil',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Ulasan Anda telah dikirim. Terima kasih atas ulasannya!',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              side: const BorderSide(
                  color: Color(0xFF006769), width: 2), // Border tebal hitam
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Tutup',
                  style: TextStyle(color: Color(0xFF006769)),
                ),
              ),
            ],
            elevation: 10, // Shadow yang lebih besar
          );
        },
      );
      _ulasanController.clear(); // Hapus teks setelah pengiriman
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim ulasan: ${result["error"]}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006769),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Ulasan & Masukan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: const Color(0xFF006769), width: 3),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF006769).withOpacity(1),
                    offset: const Offset(4, 4), // Shadow kanan dan bawah
                    blurRadius: 0, // Blur lebih besar
                  ),
                ],
              ),
              child: TextField(
                controller: _ulasanController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Masukkan ulasan atau masukan Anda di sini...',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006769),
                  foregroundColor: Colors.white,
                  elevation:
                      15, // Meningkatkan elevasi untuk shadow lebih dramatis
                  shadowColor:
                      Colors.black.withOpacity(0.7), // Shadow lebih gelap
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Radius lebih besar
                    side: const BorderSide(
                        color: Color(0xFF006769), width: 2), // Border tebal
                  ),
                ),
                onPressed: _isLoading ? null : _submitUlasan,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Kirim',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
