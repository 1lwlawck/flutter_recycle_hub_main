import 'package:flutter/material.dart';
import '../../home/widgets/waste_bank_card.dart';

class NearbyWasteBankPage extends StatefulWidget {
  const NearbyWasteBankPage({super.key});

  @override
  _NearbyWasteBankPageState createState() => _NearbyWasteBankPageState();
}

class _NearbyWasteBankPageState extends State<NearbyWasteBankPage> {
  String? selectedWasteBank;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  color: Colors.blue.shade100,
                  child: const Center(
                    child: Text(
                      'Map Area',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 15.0),
                      child: Container(
                        child: const Text(
                          "Bank Sampah Terdekat",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        children: [
                          WasteBankCard(
                            name: "Bank Sampah Dewi Sinta",
                            address: "Jl. Andora, Citraland",
                            status: "Tersedia",
                            statusColor: Colors.green,
                            isSelected:
                                selectedWasteBank == "Bank Sampah Dewi Sinta",
                            onTap: () {
                              setState(() {
                                selectedWasteBank = selectedWasteBank ==
                                        "Bank Sampah Dewi Sinta"
                                    ? null
                                    : "Bank Sampah Dewi Sinta";
                              });
                            },
                          ),
                          WasteBankCard(
                            name: "Bank Sampah Mawar Kuning",
                            address: "Jl. Cendanya, Mitra10",
                            status: "Penuh",
                            statusColor: Colors.red,
                            isSelected:
                                selectedWasteBank == "Bank Sampah Mawar Kuning",
                            onTap: () {
                              setState(() {
                                selectedWasteBank = selectedWasteBank ==
                                        "Bank Sampah Mawar Kuning"
                                    ? null
                                    : "Bank Sampah Mawar Kuning";
                              });
                            },
                          ),
                          WasteBankCard(
                            name: "Bank Sampah Jaya",
                            address: "Jl. Taman Bunga, Citraland",
                            status: "Penuh",
                            statusColor: Colors.red,
                            isSelected: selectedWasteBank == "Bank Sampah Jaya",
                            onTap: () {
                              setState(() {
                                selectedWasteBank =
                                    selectedWasteBank == "Bank Sampah Jaya"
                                        ? null
                                        : "Bank Sampah Jaya";
                              });
                            },
                          ),
                          WasteBankCard(
                            name: "Bank Sampah Tulip Jaya",
                            address: "Jl. Pahlawan, Citraland",
                            status: "Tersedia",
                            statusColor: Colors.green,
                            isSelected:
                                selectedWasteBank == "Bank Sampah Tulip Jaya",
                            onTap: () {
                              setState(() {
                                selectedWasteBank = selectedWasteBank ==
                                        "Bank Sampah Tulip Jaya"
                                    ? null
                                    : "Bank Sampah Tulip Jaya";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Bank Sampah',
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          if (selectedWasteBank != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi saat tombol "Selanjutnya" ditekan
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.black.withOpacity(0.2),
                  elevation: 6,
                ),
                child: const Text(
                  "Selanjutnya",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
