import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNavBar({super.key, required this.currentIndex});

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
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, -6), // Reduced shadow offset
                  blurRadius: 8, // Softer shadow blur
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedItemColor:
                  const Color(0xFF006769), // Consistent blue color
              unselectedItemColor: inActiveIconColor,
              elevation: 0, // Remove extra elevation
              items: [
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/images/icons/svg/home_icon.svg',
                      isSelected: _selectedIndex == 0),
                  activeIcon: _buildIcon(
                      'assets/images/icons/svg/home_icon.svg',
                      isSelected: true),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/images/icons/svg/order_icon.svg',
                      isSelected: _selectedIndex == 1),
                  activeIcon: _buildIcon(
                      'assets/images/icons/svg/order_icon.svg',
                      isSelected: true),
                  label: "Orders",
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/images/icons/svg/message_icon.svg',
                      isSelected: _selectedIndex == 2),
                  activeIcon: _buildIcon(
                      'assets/images/icons/svg/message_icon.svg',
                      isSelected: true),
                  label: "Messages",
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/images/icons/svg/user_icon.svg',
                      isSelected: _selectedIndex == 3),
                  activeIcon: _buildIcon(
                      'assets/images/icons/svg/user_icon.svg',
                      isSelected: true),
                  label: "Account",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String assetPath, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF006769).withOpacity(0.1)
            : Colors.transparent,
        shape: BoxShape.circle,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFF006769).withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                ),
              ]
            : [],
      ),
      child: SvgPicture.asset(
        assetPath,
        color: isSelected ? const Color(0xFF006769) : inActiveIconColor,
        height: 30,
        width: 30,
      ),
    );
  }
}
