import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String iconPath; // Image path for custom icon
  final String text;
  final String subtext;
  final Color textColor; // Add a text color parameter
  final Gradient gradient; // Add gradient as a new parameter
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.subtext,
    required this.textColor,
    required this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Make button fill the available width
      height: 110, // Fixed height
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 8), // Space between buttons
      decoration: BoxDecoration(
        gradient: gradient, // Use passed gradient
        borderRadius: BorderRadius.circular(10), // Smaller radius
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // Lighter shadow color
            offset: const Offset(4, 4), // Reduced offset
            blurRadius: 8, // Slight blur for softer shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon and text
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), // Background for icon
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.contain, // Ensure the image fits well
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtext,
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Arrow icon (wrapped with GestureDetector for button functionality)
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9), // Background for icon
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
