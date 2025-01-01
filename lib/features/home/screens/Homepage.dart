import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/GrettingCard.dart';
import '../../../widgets/custom_bottom_navbar.dart';
import '../widgets/PointsCard.dart';
import '../widgets/CustomBtnCardService.dart';
import '../widgets/CarouselCard.dart';
import 'package:flutter_recycle_hub/features/image-detection/screens/ImageDetection.dart';

class HomePage extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  HomePage({super.key});

  Future<void> _openCamera(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      print("Gambar berhasil diambil: ${pickedFile.path}");
      // Pindahkan ke halaman ImageDetection dan kirimkan path gambar
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageDetection(imagePath: pickedFile.path),
        ),
      );
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
                  Color(0xFF006769),
                  Color.fromARGB(255, 255, 255, 255),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.2, 0.9],
              ),
            ),
            height: screenHeight,
          ),

          // White container with gradient
          Positioned(
            top: screenHeight * 0.3,
            child: Container(
              height: screenHeight * 0.7,
              width: screenWidth,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 230, 240, 255),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(8, 8),
                    blurRadius: 0,
                  ),
                ],
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
            top: screenHeight * 0.40,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
                        CustomButton(
                          iconPath: 'assets/images/icons/chat-icon.png',
                          text: 'Chatbot',
                          subtext: 'Tanya Jawab Seputar Recycle',
                          textColor: Colors.green,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFE8F5E9),
                              Color(0xFFC8E6C9),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/chatbot');
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
                      viewportFraction: 0.9,
                    ),
                    items: [
                      const CarouselCard(
                        title: "RecycleHub",
                        description:
                            "Tukarkan Points Kamu & Dapatkan Promo Menarik",
                        backgroundColor: Colors.red,
                        imagePath: "assets/images/icons/tukarpoints.png",
                      ),
                      const CarouselCard(
                        title: "RecycleHub",
                        description: "Tukarkan Points Jadi Souvenir Menarik",
                        backgroundColor: Colors.blue,
                        imagePath: "assets/images/icons/redeempoints.png",
                      ),
                      const CarouselCard(
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
            bottom: 30,
            right: screenWidth * 0.05,
            child: GestureDetector(
              onTap: () => _openCamera(context), // Navigasi ke ImageDetection
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF006769),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(4, 4),
                      blurRadius: 0,
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
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
