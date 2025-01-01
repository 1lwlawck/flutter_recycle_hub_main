import 'package:flutter/material.dart';

class KebijakanPrivasiPage extends StatelessWidget {
  const KebijakanPrivasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006769), // Warna sesuai permintaan`
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Kebijakan Privasi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5, // Agar lebih tegas dan modern
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
            // Judul Kebijakan Privasi
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
              child: const Text(
                'Kebijakan Privasi RecycleHub',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Mulai dari Oktober 2024',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),

            // Konten Kebijakan Privasi
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
                  child: const Text(
                    '1. **Pengenalan**\n\n'
                    'Kami, di RecycleHub, berkomitmen untuk melindungi privasi Anda. '
                    'Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda ketika Anda menggunakan aplikasi kami.\n\n'
                    '2. **Informasi yang Kami Kumpulkan**\n\n'
                    'Kami mengumpulkan informasi yang Anda berikan saat mendaftar atau menggunakan aplikasi kami. Informasi ini dapat mencakup nama, alamat email, nomor telepon, serta data penggunaan aplikasi.\n\n'
                    '3. **Penggunaan Informasi**\n\n'
                    'Kami menggunakan informasi yang kami kumpulkan untuk:\n'
                    '  - Memberikan, mengelola, dan meningkatkan layanan kami\n'
                    '  - Meningkatkan pengalaman pengguna\n'
                    '  - Mengirimkan pemberitahuan atau informasi terkait dengan layanan kami\n\n'
                    '4. **Keamanan Data**\n\n'
                    'Kami menggunakan langkah-langkah keamanan teknis dan organisasi untuk melindungi data pribadi Anda dari kehilangan, penyalahgunaan, atau akses yang tidak sah. Namun, tidak ada metode pengiriman data melalui internet yang sepenuhnya aman, dan kami tidak dapat menjamin keamanan 100%.\n\n'
                    '5. **Pengungkapan Data Pribadi**\n\n'
                    'Kami tidak akan menjual atau menyewakan data pribadi Anda kepada pihak ketiga. Namun, kami dapat mengungkapkan data pribadi Anda jika diwajibkan oleh hukum atau jika kami percaya bahwa pengungkapan tersebut diperlukan untuk melindungi hak-hak kami atau pihak lain.\n\n'
                    '6. **Cookie dan Teknologi Pelacakan**\n\n'
                    'Kami menggunakan cookie dan teknologi pelacakan lainnya untuk meningkatkan pengalaman pengguna dan mengumpulkan informasi analitik terkait penggunaan aplikasi. Anda dapat menonaktifkan cookie melalui pengaturan perangkat Anda, namun hal ini dapat memengaruhi fungsi beberapa fitur dalam aplikasi.\n\n'
                    '7. **Hak Anda atas Data Pribadi**\n\n'
                    'Anda berhak untuk mengakses, memperbarui, atau menghapus data pribadi Anda yang kami simpan. Jika Anda ingin melakukan salah satu dari hal tersebut, Anda dapat menghubungi kami melalui kontak yang tersedia dalam aplikasi.\n\n'
                    '8. **Perubahan dalam Kebijakan Privasi**\n\n'
                    'Kami dapat memperbarui Kebijakan Privasi ini dari waktu ke waktu untuk mencerminkan perubahan dalam cara kami mengumpulkan atau menggunakan informasi Anda. Kami akan memberi tahu Anda tentang perubahan tersebut melalui pemberitahuan dalam aplikasi atau melalui email.\n\n'
                    '9. **Hubungi Kami**\n\n'
                    'Jika Anda memiliki pertanyaan atau kekhawatiran terkait dengan Kebijakan Privasi ini, atau ingin mengakses, memperbarui, atau menghapus informasi pribadi Anda, Anda dapat menghubungi kami di: support@recyclehub.com\n\n',
                    style: TextStyle(fontSize: 16, height: 1.5),
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
