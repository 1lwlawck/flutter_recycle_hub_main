import 'package:flutter/material.dart';

class TambahAlamatPage extends StatefulWidget {
  final Map<String, dynamic>? alamat; // Alamat yang dikirim untuk diubah

  const TambahAlamatPage({super.key, this.alamat});

  @override
  TambahAlamatPageState createState() => TambahAlamatPageState();
}

class TambahAlamatPageState extends State<TambahAlamatPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController provinsiController = TextEditingController();
  final TextEditingController kabupatenController = TextEditingController();
  final TextEditingController kecamatanController = TextEditingController();
  final TextEditingController desaController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController fullAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.alamat != null) {
      phoneController.text = widget.alamat?['nomor_hp'] ?? '';
      provinsiController.text = widget.alamat?['provinsi'] ?? '';
      kabupatenController.text = widget.alamat?['kabupaten_kota'] ?? '';
      kecamatanController.text = widget.alamat?['kecamatan'] ?? '';
      desaController.text = widget.alamat?['desa'] ?? '';
      postalCodeController.text = widget.alamat?['kode_pos'] ?? '';
      fullAddressController.text = widget.alamat?['alamat_lengkap'] ?? '';
    }
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[700]),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
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
          'Edit Alamat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: provinsiController,
              decoration: inputDecoration("Provinsi"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: kabupatenController,
              decoration: inputDecoration("Kabupaten/Kota"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: kecamatanController,
              decoration: inputDecoration("Kecamatan"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: desaController,
              decoration: inputDecoration("Desa"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: postalCodeController,
              decoration: inputDecoration("Kode Pos"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: fullAddressController,
              maxLines: 3,
              decoration: inputDecoration("Alamat Lengkap"),
            ),
            const SizedBox(height: 24),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006769),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
