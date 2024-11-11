import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';

class TambahAlamatPage extends StatefulWidget {
  @override
  _TambahAlamatPageState createState() => _TambahAlamatPageState();
}

class _TambahAlamatPageState extends State<TambahAlamatPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController fullAddressController = TextEditingController();

  List<dynamic> provinsiList = [];
  List<dynamic> kabupatenList = [];
  List<dynamic> kecamatanList = [];
  List<dynamic> desaList = [];

  String? selectedProvinsi;
  String? selectedKabupaten;
  String? selectedKecamatan;
  String? selectedDesa;

  @override
  void initState() {
    super.initState();
    fetchProvinsi();
  }

  Future<void> fetchProvinsi() async {
    final response = await http.get(
      Uri.parse(
          'https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json'),
    );
    if (response.statusCode == 200) {
      setState(() {
        provinsiList = json.decode(response.body);
      });
    }
  }

  Future<void> fetchKabupaten(String provinsiId) async {
    final response = await http.get(
      Uri.parse(
          'https://www.emsifa.com/api-wilayah-indonesia/api/regencies/$provinsiId.json'),
    );
    if (response.statusCode == 200) {
      setState(() {
        kabupatenList = json.decode(response.body);
        kecamatanList = [];
        desaList = [];
      });
    }
  }

  Future<void> fetchKecamatan(String kabupatenId) async {
    final response = await http.get(
      Uri.parse(
          'https://www.emsifa.com/api-wilayah-indonesia/api/districts/$kabupatenId.json'),
    );
    if (response.statusCode == 200) {
      setState(() {
        kecamatanList = json.decode(response.body);
        desaList = [];
      });
    }
  }

  Future<void> fetchDesa(String kecamatanId) async {
    final response = await http.get(
      Uri.parse(
          'https://www.emsifa.com/api-wilayah-indonesia/api/villages/$kecamatanId.json'),
    );
    if (response.statusCode == 200) {
      setState(() {
        desaList = json.decode(response.body);
      });
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
        borderSide: BorderSide(color: Colors.blueAccent),
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Tambah Alamat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white, // Background warna putih
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: inputDecoration("No. Ponsel"),
            ),
            const SizedBox(height: 16),

            // Dropdown untuk Provinsi
            DropdownSearch<String>(
              items: provinsiList
                  .map((provinsi) => provinsi['name'] as String)
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedProvinsi = value;
                  selectedKabupaten = null;
                  selectedKecamatan = null;
                  selectedDesa = null;
                });
                final provinsiId = provinsiList
                    .firstWhere((provinsi) => provinsi['name'] == value)['id'];
                fetchKabupaten(provinsiId);
              },
              selectedItem: selectedProvinsi,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: inputDecoration("Pilih Provinsi"),
              ),
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                fit: FlexFit.loose,
                containerBuilder: (ctx, popupWidget) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: popupWidget,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown untuk Kabupaten
            DropdownSearch<String>(
              items: kabupatenList
                  .map((kabupaten) => kabupaten['name'] as String)
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedKabupaten = value;
                  selectedKecamatan = null;
                  selectedDesa = null;
                });
                final kabupatenId = kabupatenList.firstWhere(
                    (kabupaten) => kabupaten['name'] == value)['id'];
                fetchKecamatan(kabupatenId);
              },
              selectedItem: selectedKabupaten,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    inputDecoration("Pilih Kabupaten/Kota"),
              ),
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                fit: FlexFit.loose,
                containerBuilder: (ctx, popupWidget) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: popupWidget,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown untuk Kecamatan
            DropdownSearch<String>(
              items: kecamatanList
                  .map((kecamatan) => kecamatan['name'] as String)
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedKecamatan = value;
                  selectedDesa = null;
                });
                final kecamatanId = kecamatanList.firstWhere(
                    (kecamatan) => kecamatan['name'] == value)['id'];
                fetchDesa(kecamatanId);
              },
              selectedItem: selectedKecamatan,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: inputDecoration("Pilih Kecamatan"),
              ),
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                fit: FlexFit.loose,
                containerBuilder: (ctx, popupWidget) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: popupWidget,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown untuk Desa
            DropdownSearch<String>(
              items: desaList.map((desa) => desa['name'] as String).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDesa = value;
                });
              },
              selectedItem: selectedDesa,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: inputDecoration("Pilih Desa"),
              ),
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                fit: FlexFit.loose,
                containerBuilder: (ctx, popupWidget) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: popupWidget,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Input Kode Pos
            TextField(
              controller: postalCodeController,
              decoration: inputDecoration("Kode Pos"),
            ),
            const SizedBox(height: 16),

            // Input Alamat Lengkap
            TextField(
              controller: fullAddressController,
              maxLines: 3,
              decoration: inputDecoration("Alamat Lengkap"),
            ),
            const SizedBox(height: 16),

            // Checkbox untuk alamat utama
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                  activeColor: Colors.blue,
                ),
                const Text("Jadikan alamat utama"),
              ],
            ),
            const Spacer(),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan logika untuk menyimpan alamat
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.white,
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
