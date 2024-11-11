import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNavBar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _selectedIndex;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/orders');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/fill-messages');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/account');
        break;
    }
  }

  Future<void> _openCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      print("Gambar berhasil diambil: ${pickedFile.path}");
    } else {
      print("Tidak ada gambar yang diambil.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          Navigator.pushReplacementNamed(context, '/home');
          return false;
        }
        return true;
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Bottom Navigation Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedItemColor: Color.fromARGB(255, 67, 117, 255),
              unselectedItemColor: inActiveIconColor,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/icons/svg/home_icon.svg',
                    color: inActiveIconColor,
                    height: 30, // Mengatur ukuran ikon lebih besar
                    width: 30,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/images/icons/svg/home_icon.svg',
                    color: Color.fromARGB(255, 67, 117, 255),
                    height: 30, // Mengatur ukuran ikon lebih besar
                    width: 30,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/icons/svg/order_icon.svg',
                    color: inActiveIconColor,
                    height: 30,
                    width: 30,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/images/icons/svg/order_icon.svg',
                    color: Color.fromARGB(255, 67, 117, 255),
                    height: 30,
                    width: 30,
                  ),
                  label: "Orders",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/icons/svg/message_icon.svg',
                    color: inActiveIconColor,
                    height: 30,
                    width: 30,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/images/icons/svg/message_icon.svg',
                    color: Color.fromARGB(255, 67, 117, 255),
                    height: 30,
                    width: 30,
                  ),
                  label: "Messages",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/icons/svg/user_icon.svg',
                    color: inActiveIconColor,
                    height: 30,
                    width: 30,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/images/icons/svg/user_icon.svg',
                    color: Color.fromARGB(255, 67, 117, 255),
                    height: 30,
                    width: 30,
                  ),
                  label: "Account",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
