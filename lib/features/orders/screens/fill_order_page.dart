import 'package:flutter/material.dart';
import '../../../widgets/custom_bottom_navbar.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF006769),
        elevation: 4,
        title: const Text(
          'Order Saya',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buildOrderCard(
            context,
            title: "Drop Off",
            date: "28 Oktober 2024",
            description: "High Density Polyethylene (HDPE)\n5 Kg",
            details: "Total Uang Tunai\nRp 10.000 s.d Rp 25.000",
            status: "Menunggu Konfirmasi",
            icon: Icons.local_shipping,
          ),
          buildOrderCard(
            context,
            title: "Drop Off",
            date: "28 Oktober 2024",
            description: "Polyethylene Terephthalate (PET)\n1 Kg",
            details: "Rp 10.000",
            status: "Menunggu Konfirmasi",
            icon: Icons.local_shipping,
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 1,
      ),
    );
  }

  Widget buildOrderCard(BuildContext context,
      {required String title,
      required String date,
      required String description,
      required String details,
      required String status,
      required IconData icon}) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/rincian-order');
      },
      child: Container(
        // Replace Card with Container for custom decoration
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(5, 5), // Shadow effect to the right and down
              blurRadius: 0, // Slight blur for depth effect
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Container with Strong Neon Effect and Raw Look
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.redAccent, // Warna latar belakang yang mencolok
                  border: Border.all(
                    color: Colors.black.withOpacity(0.6),
                    width: 2,
                  ),
                  shape:
                      BoxShape.rectangle, // Bentuk kotak untuk kontainer ikon
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(4, 4),
                      blurRadius: 0, // Bayangan tajam pada ikon
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Status Badge with Sharp Borders
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.yellowAccent.withOpacity(0.4),
                            borderRadius:
                                BorderRadius.circular(0), // Sudut tajam
                            border: Border.all(
                              color: Colors.yellow.withOpacity(0.7),
                              width: 3,
                            ),
                          ),
                          child: Text(
                            status,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Date with Strong Contrast
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 14),
                    // Description with Bold and Simple Font
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      details,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
