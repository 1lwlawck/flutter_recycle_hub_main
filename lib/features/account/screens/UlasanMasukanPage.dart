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
            title: const Text('Ulasan Berhasil'),
            content:
                Text('Ulasan Anda telah dikirim. Terima kasih atas ulasannya!'),
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
            const Text(
              'Tulis Ulasan Anda',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006769),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
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
                  elevation: 5,
                  shadowColor: Colors.black45,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
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
