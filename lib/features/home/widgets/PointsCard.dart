import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_recycle_hub/features/account/services/UserService.dart';

class PointsSection extends StatefulWidget {
  const PointsSection({super.key});

  @override
  _PointsSectionState createState() => _PointsSectionState();
}

class _PointsSectionState extends State<PointsSection> {
  int points = 0; // Default value for points
  bool isLoading = true; // Loading indicator

  @override
  void initState() {
    super.initState();
    _fetchUserPoints(); // Fetch points when widget initializes
  }

  Future<void> _fetchUserPoints() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id'); // Get user ID from preferences
      if (userId != null) {
        final user = await UserService.getUser(userId); // Fetch user data
        if (user != null) {
          setState(() {
            points = user.points; // Extract points from user object
            isLoading = false;
          });
        } else {
          setState(() {
            points = 0;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          points = 0; // Default to 0 if no user ID found
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching points: $e");
      setState(() {
        points = 0;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width
      height: 130, // Fixed height
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Small border radius
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(7, 0),
            blurRadius: 0, // Neo-brutalism shadow style
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left part (Points)
          Container(
            width: 200,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4), // Light grey background for box
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(4, 4),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Points",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        "$points",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
              ],
            ),
          ),

          // Right part (Redeem and Share)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Action for redeem
                  print("Redeem clicked");
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF006769), Color(0xFF00BFAE)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.card_giftcard_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Redeem",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
