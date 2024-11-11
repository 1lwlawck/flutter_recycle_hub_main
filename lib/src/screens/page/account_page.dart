import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_account_page/daftar_alamat_page.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_account_page/edit_profile_page.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_account_page/kebijakan_privasi_page.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_account_page/panduan_page.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_account_page/syarat_ketentuan_page.dart';
import '../../widgets/custom_bottom_navbar.dart';

class AccountPage extends StatelessWidget {
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
        backgroundColor: const Color.fromARGB(255, 43, 75, 250),
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
            color: const Color.fromARGB(255, 43, 74, 250),
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blueAccent, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: const AssetImage(
                            'assets/images/icons/pict_profile.png'),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Asep",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "0 Points",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Rounded background untuk menu utama
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                              builder: (context) => EditProfilePage()),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  buildCard(context, [
                    buildListTile(
                      context,
                      icon: Icons.report_gmailerrorred_outlined,
                      title: "Laporkan Masalah",
                    ),
                    ListTile(
                      leading: Icon(Icons.info_outline, color: Colors.grey),
                      title: Text("Versi Aplikasi"),
                      trailing: Text("beta 0.1"),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout_outlined, color: Colors.red),
                      title: Text(
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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
      ),
    );
  }

  Widget buildCard(BuildContext context, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      color: Colors.grey[100],
      child: Column(children: children),
    );
  }

  Widget buildListTile(BuildContext context,
      {required IconData icon, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
      onTap: onTap,
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
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
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Apakah Anda yakin ingin log out?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Tutup dialog
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: const Text(
                        "Batal",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Tutup dialog
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(color: Colors.white),
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
