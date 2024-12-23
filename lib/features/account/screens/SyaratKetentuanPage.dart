import 'package:flutter/material.dart';

class SyaratKetentuanPage extends StatelessWidget {
  const SyaratKetentuanPage({super.key});

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
          'Syarat & Ketentuan',
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
            // Judul Syarat & Ketentuan
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(3, 3), // Shadow kanan dan bawah
                    blurRadius: 0, // Tanpa blur
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Syarat dan Ketentuan',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Konten teks syarat dan ketentuan
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(3, 3), // Shadow kanan dan bawah
                        blurRadius: 0, // Tanpa blur
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Maecenas eu magna eu turpis consectetur efficitur vel eget orci. '
                    'Duis laoreet sagittis nisi, vel vulputate enim eleifend eu. '
                    'Etiam finibus nibh nulla, eget interdum magna suscipit vel. '
                    'Integer dapibus sed neque ac pharetra. In hac habitasse platea dictumst. '
                    'Mauris dapibus, erat vitae faucibus consectetur, massa tortor maximus nulla, '
                    'at aliquet ligula justo et dolor.\n\n'
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Maecenas eu magna eu turpis consectetur efficitur vel eget orci. '
                    'Duis laoreet sagittis nisi, vel vulputate enim eleifend eu. '
                    'Etiam finibus nibh nulla, eget interdum magna suscipit vel. '
                    'Integer dapibus sed neque ac pharetra. In hac habitasse platea dictumst. '
                    'Mauris dapibus, erat vitae faucibus consectetur, massa tortor maximus nulla, '
                    'at aliquet ligula justo et dolor.\n\n',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      height: 1.5,
                    ),
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
