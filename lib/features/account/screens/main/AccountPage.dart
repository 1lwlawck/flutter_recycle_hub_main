import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/features/account/screens/DaftarAlamatPage.dart';
import 'package:flutter_recycle_hub/features/account/screens/EditProfilePage.dart';
import 'package:flutter_recycle_hub/features/account/screens/KebijakanPrivasiPage.dart';
import 'package:flutter_recycle_hub/features/account/screens/PanduanPenggunaPage.dart';
import 'package:flutter_recycle_hub/features/account/screens/SyaratKetentuanPage.dart';
import 'package:flutter_recycle_hub/features/home/services/PointServiceApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../widgets/custom_bottom_navbar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  // Fungsi untuk mengambil nama pengguna dari SharedPreferences
  Future<String> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name') ?? "Pengguna"; // Default "Pengguna"
  }

  // Fungsi untuk mengambil points dari PointsCardService
  Future<int> _getUserPoints() async {
    try {
      return await PointsCardService.getUserPoints();
    } catch (e) {
      print('Error fetching points: $e');
      return 0; // Default points jika gagal
    }
  }

  Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data di SharedPreferences
    print("All session data cleared");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getUserName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Terjadi kesalahan!'),
          );
        } else if (snapshot.hasData) {
          final userName = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Account"),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: const Color(0xFF006769),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
            ),
            body: Column(
              children: [
                // Section pertama dengan background biru solid
                Container(
                  color: const Color(0xFF006769),
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(4, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(
                                  'assets/images/icons/pict_profile.png'),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                FutureBuilder<int>(
                                  future: _getUserPoints(),
                                  builder: (context, pointsSnapshot) {
                                    if (pointsSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (pointsSnapshot.hasError) {
                                      return const Text(
                                        "Error loading points",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                        ),
                                      );
                                    } else if (pointsSnapshot.hasData) {
                                      return Text(
                                        "${pointsSnapshot.data} Points",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        "0 Points",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Section kedua untuk menu utama
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        const Text(
                          "Account",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        buildCard(context, [
                          buildListTile(
                            context,
                            icon: Icons.person_outline,
                            title: "Edit profile",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(),
                                ),
                              );
                            },
                          ),
                          buildListTile(
                            context,
                            icon: Icons.location_pin,
                            title: "Alamat",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AlamatPage(),
                                ),
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 20),
                        const Text(
                          "Support & About",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        buildCard(context, [
                          buildListTile(
                            context,
                            icon: Icons.info_outline,
                            title: "Panduan",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PanduanPage(),
                                ),
                              );
                            },
                          ),
                          buildListTile(
                            context,
                            icon: Icons.policy_outlined,
                            title: "Syarat & Ketentuan",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SyaratKetentuanPage(),
                                ),
                              );
                            },
                          ),
                          buildListTile(
                            context,
                            icon: Icons.security_outlined,
                            title: "Kebijakan Privasi",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => KebijakanPrivasiPage(),
                                ),
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 20),
                        const Text(
                          "Other",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        buildCard(context, [
                          buildListTile(
                            context,
                            icon: Icons.report_gmailerrorred_outlined,
                            title: "Laporkan Masalah",
                          ),
                          const ListTile(
                            leading:
                                Icon(Icons.info_outline, color: Colors.grey),
                            title: Text("Versi Aplikasi"),
                            trailing: Text("beta 0.1"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout_outlined,
                                color: Colors.red),
                            title: const Text(
                              "Log Out",
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              showLogoutDialog(context);
                            },
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const CustomBottomNavBar(
              currentIndex: 3,
            ),
          );
        } else {
          return const Center(
            child: Text('Tidak Ada Data'),
          );
        }
      },
    );
  }

  // Membuat widget Card untuk kategori menu
  Widget buildCard(BuildContext context, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
      color: Colors.grey[100],
      child: Column(children: children),
    );
  }

  // Membuat widget ListTile dengan ikon dan fungsi onTap
  Widget buildListTile(BuildContext context,
      {required IconData icon, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF006769)),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF006769)),
      onTap: onTap,
    );
  }

  // Fungsi untuk menampilkan dialog logout
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 40,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Apakah Anda yakin ingin log out?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: const Text(
                        "Batal",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await clearSession();
                        Navigator.of(context).pop();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
