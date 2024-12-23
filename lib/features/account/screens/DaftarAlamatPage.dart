import 'package:flutter/material.dart';

class AlamatPage extends StatefulWidget {
  const AlamatPage({super.key});

  @override
  State<AlamatPage> createState() => _AlamatPageState();
}

class _AlamatPageState extends State<AlamatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Daftar Alamat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white, // Set background to white
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card untuk alamat utama
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.3), // Shadow lebih tegas dan kasar
                    offset:
                        const Offset(3, 3), // Shadow hanya di kanan dan bawah
                    spreadRadius:
                        5, // Spread lebih besar untuk kesan lebih keras
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'No. Ponsel: 085860346754',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Alamat Utama',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Jl. Jasmine, RT 002 / RW 003, No 90\nDESA MAJU MUNDUR',
                    style: TextStyle(
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (bool? value) {},
                            activeColor: Colors.blue,
                          ),
                          const Text("Jadikan Alamat Utama"),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Fungsi untuk mengubah alamat
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                              0xFF006769), // Menggunakan warna sesuai permintaan
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: Colors.black,
                                width: 2), // Border hitam tegas
                          ),
                          elevation: 0, // Tidak ada elevasi (bayangan lembut)
                        ),
                        child: const Text(
                          'Ubah',
                          style: TextStyle(
                            color:
                                Colors.white, // Warna putih untuk teks tombol
                            fontWeight: FontWeight.bold,
                            letterSpacing:
                                2, // Mempertegas teks dengan jarak antar huruf
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Tombol Tambahkan Alamat
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Fungsi untuk menambahkan alamat
                  Navigator.pushNamed(context, '/tambah_alamat');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF006769), // Warna sesuai dengan permintaan
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0, // Tidak ada elevasi (bayangan lembut)
                ),
                child: const Text(
                  'Tambahkan Alamat',
                  style: TextStyle(
                    color: Colors.white, // Warna putih untuk teks tombol
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing:
                        2, // Mempertegas teks dengan jarak antar huruf
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
