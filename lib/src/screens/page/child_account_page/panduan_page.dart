import 'package:flutter/material.dart';

class PanduanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Panduan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
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
        ExpansionTile(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (int i = 0; i < steps.length; i++)
                    Text(
                      "${i + 1}. ${steps[i]}",
                      style: TextStyle(
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
      ],
    );
  }
}
