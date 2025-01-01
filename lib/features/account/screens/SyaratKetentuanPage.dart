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
                    'Syarat dan ketentuan penggunaan aplikasi ini ("Aplikasi") mengatur hak dan kewajiban pengguna dan penyedia aplikasi. '
                    'Dengan mengakses atau menggunakan Aplikasi, Anda setuju untuk mematuhi syarat dan ketentuan berikut: \n\n'
                    '1. **Penerimaan Syarat dan Ketentuan**\n'
                    'Dengan menggunakan Aplikasi, Anda menyatakan bahwa Anda telah membaca, memahami, dan menyetujui semua syarat dan ketentuan ini. '
                    'Jika Anda tidak setuju dengan syarat dan ketentuan ini, Anda tidak diperbolehkan untuk menggunakan Aplikasi.\n\n'
                    '2. **Penggunaan Aplikasi**\n'
                    'Aplikasi ini hanya boleh digunakan untuk tujuan yang sah dan sesuai dengan ketentuan yang ditetapkan dalam perjanjian ini. '
                    'Pengguna setuju untuk tidak menggunakan Aplikasi untuk aktivitas ilegal atau melanggar hukum yang berlaku.\n\n'
                    '3. **Akun Pengguna**\n'
                    'Anda mungkin diminta untuk membuat akun pengguna untuk mengakses beberapa fitur dari Aplikasi. '
                    'Anda bertanggung jawab untuk menjaga kerahasiaan informasi akun Anda dan setuju untuk memberi tahu kami jika ada penggunaan yang tidak sah dari akun Anda.\n\n'
                    '4. **Kebijakan Privasi**\n'
                    'Kami sangat menghargai privasi Anda. Informasi yang kami kumpulkan melalui Aplikasi akan digunakan sesuai dengan kebijakan privasi kami. '
                    'Harap baca Kebijakan Privasi kami untuk memahami bagaimana kami mengelola data Anda.\n\n'
                    '5. **Pembayaran dan Biaya**\n'
                    'Beberapa fitur atau layanan dalam Aplikasi mungkin dikenakan biaya. Anda setuju untuk membayar biaya yang berlaku, sesuai dengan harga yang tertera pada Aplikasi. '
                    'Kami berhak untuk mengubah biaya atau mengenakan biaya tambahan berdasarkan kebijakan yang kami tentukan.\n\n'
                    '6. **Hak Cipta dan Kepemilikan**\n'
                    'Seluruh konten dalam Aplikasi, termasuk namun tidak terbatas pada teks, gambar, logo, dan perangkat lunak, adalah milik penyedia Aplikasi atau pemegang hak cipta terkait. '
                    'Pengguna tidak diperkenankan untuk menduplikasi, memodifikasi, atau mendistribusikan materi tanpa izin tertulis dari pemilik hak cipta.\n\n'
                    '7. **Batasan Tanggung Jawab**\n'
                    'Aplikasi disediakan "sebagaimana adanya", dan kami tidak bertanggung jawab atas kerugian atau kerusakan yang timbul akibat penggunaan Aplikasi ini, termasuk namun tidak terbatas pada gangguan layanan, kesalahan teknis, atau kehilangan data.\n\n'
                    '8. **Perubahan pada Syarat dan Ketentuan**\n'
                    'Kami berhak untuk memperbarui atau mengubah syarat dan ketentuan ini sewaktu-waktu tanpa pemberitahuan terlebih dahulu. '
                    'Perubahan akan berlaku segera setelah dipublikasikan pada Aplikasi. Harap periksa secara berkala untuk mengetahui pembaruan terbaru.\n\n'
                    '9. **Hukum yang Berlaku**\n'
                    'Syarat dan ketentuan ini diatur oleh hukum yang berlaku di negara tempat penyedia Aplikasi berada. Setiap sengketa yang timbul akan diselesaikan melalui proses hukum yang berlaku di negara tersebut.\n\n',
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
