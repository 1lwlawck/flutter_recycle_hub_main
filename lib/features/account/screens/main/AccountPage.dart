import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/features/account/screens/DaftarAlamatPage.dart';
import 'package:flutter_recycle_hub/features/account/screens/EditProfilePage.dart';
import 'package:flutter_recycle_hub/features/account/screens/KebijakanPrivasiPage.dart';
import 'package:flutter_recycle_hub/features/account/screens/PanduanPenggunaPage.dart';
import 'package:flutter_recycle_hub/features/account/screens/SyaratKetentuanPage.dart';
import 'package:flutter_recycle_hub/features/account/screens/UlasanMasukanPage.dart';
import 'package:flutter_recycle_hub/core/models/Users.dart';
import 'package:flutter_recycle_hub/core/services/Config.dart';
import 'package:flutter_recycle_hub/features/account/services/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../widgets/custom_bottom_navbar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late Future<User?> user;

  @override
  void initState() {
    super.initState();
    user = _getUserData();
  }

  Future<User?> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId == null) {
      return null; // User belum login
    }
    return await UserService.getUser(userId);
  }

  void _refreshUserData() {
    setState(() {
      user = _getUserData();
    });
  }

  Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data di SharedPreferences
    print("All session data cleared");
  }

  @override
  Widget build(BuildContext context) {
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
          Card(
            color: const Color(0xFF006769),
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  FutureBuilder<User?>(
                    future: _getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError || !snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey,
                            child: const Icon(Icons.person, size: 50),
                          ),
                        );
                      } else {
                        final user = snapshot.data!;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            '${Config.API_URL}/static/uploads/avatars/${user.avatar}',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey,
                                child: const Icon(Icons.person, size: 50),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<User?>(
                        future: _getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "Loading...",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          } else if (snapshot.hasError || !snapshot.hasData) {
                            return const Text(
                              "Error",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            final user = snapshot.data!;
                            return Text(
                              user.namaUser,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder<User?>(
                        future: _getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "Loading Points...",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            );
                          } else if (snapshot.hasError || !snapshot.hasData) {
                            return const Text(
                              "0 Points",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            );
                          } else {
                            final user = snapshot.data!;
                            return Text(
                              "${user.points} Points",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
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
                        ).then((_) => _refreshUserData());
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
                    buildListTile(
                      context,
                      icon: Icons.feedback_outlined,
                      title: "Ulasan & Masukan",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UlasanMasukanPage(),
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
                      leading: Icon(Icons.info_outline, color: Colors.grey),
                      title: Text("Versi Aplikasi"),
                      trailing: Text("beta 0.1"),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.logout_outlined, color: Colors.red),
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
  }

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

  Widget buildListTile(BuildContext context,
      {required IconData icon, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF006769)),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF006769)),
      onTap: onTap,
    );
  }

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
