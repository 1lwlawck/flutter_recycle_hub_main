import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/AlamatService.dart';
import 'package:flutter_recycle_hub/core/models/Alamat.dart';
import 'TambahAlamatPage.dart';

class AlamatPage extends StatefulWidget {
  const AlamatPage({super.key});

  @override
  State<AlamatPage> createState() => _AlamatPageState();
}

class _AlamatPageState extends State<AlamatPage> {
  late Future<List<Alamat>> alamatList;

  @override
  void initState() {
    super.initState();
    _loadAlamat();
  }

  Future<void> _loadAlamat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId != null) {
      setState(() {
        alamatList = AlamatService.getAlamatByUserId(userId);
      });
    } else {
      print('User ID not found');
      setState(() {
        alamatList = Future.value([]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006769),
        elevation: 0,
        title: const Text(
          'Daftar Alamat',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Alamat>>(
        future: alamatList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada alamat ditemukan.'));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final alamat = data[index];
                return AlamatCard(
                  alamat: alamat,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TambahAlamatPage(alamat: alamat.toJson()),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class AlamatCard extends StatelessWidget {
  final Alamat alamat;
  final VoidCallback onEdit;

  const AlamatCard({super.key, required this.alamat, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(3, -3),
            spreadRadius: 2,
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            alamat.alamatLengkap ?? 'Alamat tidak tersedia',
            style: const TextStyle(
                color: Colors.black87, fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 10),
          if (alamat.provinsi != null) Text('Provinsi: ${alamat.provinsi}'),
          if (alamat.kabupatenKota != null)
            Text('Kabupaten/Kota: ${alamat.kabupatenKota}'),
          if (alamat.kecamatan != null) Text('Kecamatan: ${alamat.kecamatan}'),
          if (alamat.desa != null) Text('Desa: ${alamat.desa}'),
          if (alamat.kodePos != null) Text('Kode Pos: ${alamat.kodePos}'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onEdit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006769),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.black, width: 2),
              ),
            ),
            child: const Text(
              'Ubah',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
          ),
        ],
      ),
    );
  }
}
