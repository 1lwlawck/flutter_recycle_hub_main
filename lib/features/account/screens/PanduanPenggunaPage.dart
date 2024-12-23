import 'package:flutter/material.dart';

class PanduanPage extends StatelessWidget {
  const PanduanPage({super.key});

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
          'Panduan Pengguna',
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
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            buildExpansionTile(
              "Registrasi",
              "Panduan Registrasi",
              [
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eu magna eu turpis consectetur efficitur vel eget orci.",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eu magna eu turpis consectetur efficitur vel eget orci.",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eu magna eu turpis consectetur efficitur vel eget orci.",
              ],
            ),
            buildExpansionTile(
              "Drop Off Sampah",
              "Panduan Drop Off Sampah",
              [
                "Instruksi untuk drop off sampah.",
                "Pastikan sampah sudah dipisahkan dengan benar sebelum drop off.",
              ],
            ),
            buildExpansionTile(
              "Jenis dan Harga Sampah",
              "Panduan Jenis dan Harga Sampah",
              [
                "Daftar jenis sampah dan harga.",
                "Setiap jenis sampah memiliki harga yang berbeda.",
              ],
            ),
            buildExpansionTile(
              "Menjadi Mitra",
              "Panduan Menjadi Mitra",
              [
                "Cara untuk menjadi mitra kami.",
                "Pastikan memenuhi syarat dan ketentuan untuk menjadi mitra.",
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat ExpansionTile dengan isi panduan
  Widget buildExpansionTile(String title, String subtitle, List<String> steps) {
    return Column(
      children: [
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
          child: ExpansionTile(
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.2,
                color: Colors.black,
              ),
            ),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (int i = 0; i < steps.length; i++)
                      Text(
                        "${i + 1}. ${steps[i]}",
                        style: const TextStyle(
                          color: Colors.black87,
                          height: 1.5,
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
