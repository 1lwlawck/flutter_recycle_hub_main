import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../widgets/gretting_card.dart';
import '../../widgets/custom_bottom_navbar.dart';
import '../../widgets/points_card.dart';
import '../../widgets/custom_btn_card_services.dart';
import '../../widgets/carousel_card.dart';

class HomePage extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 43, 74, 250),
                  Color.fromARGB(255, 255, 255, 255),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.2, 0.9],
              ),
            ),
            height: screenHeight,
          ),

          // White container with a gradient at the bottom for the Service Card and Carousel background
          Positioned(
            top: screenHeight * 0.3,
            child: Container(
              height: screenHeight * 0.7,
              width: screenWidth,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 230, 240, 255),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),

          // Greeting card fixed at the top
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: UserGreeting(),
          ),

          // Points section fixed below Greeting card
          Positioned(
            top: screenHeight * 0.25,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: PointsSection(),
          ),

          // Scrollable Service Cards and Carousel
          Positioned(
            top: screenHeight * 0.40, // Start scrolling a bit higher
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Service Cards section with reduced top margin
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      children: [
                        CustomButton(
                          iconPath: 'assets/images/icons/pickup_icon.png',
                          text: 'Pickup (Coming soon)',
                          subtext: 'Mitra Akan Jemput Sampahmu',
                          textColor: Colors.blue,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFE3F2FD),
                              Color(0xFFBBDEFB),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/pickup');
                          },
                        ),
                        const SizedBox(
                            height: 10), // Reduced space between cards
                        CustomButton(
                          iconPath: 'assets/images/icons/dropoff_icon.png',
                          text: 'Drop Off',
                          subtext: 'Antarkan langsung sampahmu',
                          textColor: Colors.purple,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFF3E5F5),
                              Color(0xFFE1BEE7),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/dropoff');
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          iconPath: 'assets/images/icons/rewards.png',
                          text: 'Rewards (Coming soon)',
                          subtext: 'Tukar Points Kamu ',
                          textColor: Colors.orange,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFFF3E0),
                              Color(0xFFFFE0B2),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/rewards');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Full-width Carousel Section
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 150.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9, // Full width for the carousel
                    ),
                    items: [
                      CarouselCard(
                        title: "RecycleHub",
                        description:
                            "Tukarkan Points Kamu & Dapatkan Promo Menarik",
                        backgroundColor: Colors.red,
                        imagePath: "assets/images/icons/tukarpoints.png",
                      ),
                      CarouselCard(
                        title: "RecycleHub",
                        description: "Tukarkan Points Jadi Souvenir Menarik",
                        backgroundColor: Colors.blue,
                        imagePath: "assets/images/icons/redeempoints.png",
                      ),
                      CarouselCard(
                        title: "RecycleHub",
                        description:
                            "Daur Ulang Botol PET dapatkan bonus Points",
                        backgroundColor: Colors.green,
                        imagePath: "assets/images/icons/daurulangpet.png",
                      ),
                    ].map((card) => card).toList(),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // Floating Camera Button
          Positioned(
            bottom: 10,
            right: screenWidth * 0.5 - 190,
            child: GestureDetector(
              onTap: _openCamera,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 67, 117, 255),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/icons/svg/camera_icon.svg',
                    color: Colors.white,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
