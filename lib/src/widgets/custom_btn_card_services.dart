import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String iconPath; // Image path for custom icon
  final String text;
  final String subtext;
  final Color textColor; // Add a text color parameter
  final Gradient gradient; // Add gradient as a new parameter
  final VoidCallback? onTap;

  CustomButton({
    required this.iconPath,
    required this.text,
    required this.subtext,
    required this.textColor, // Add textColor as required
    required this.gradient, // Add gradient as required
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390, // Set fixed width
      height: 110, // Set fixed height
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 8), // Space between buttons
      decoration: BoxDecoration(
        gradient: gradient, // Use passed gradient
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Lighter shadow color
            blurRadius: 6, // Reduced blur for a softer shadow
            spreadRadius: 1, // Reduced spread for a thinner shadow
            offset: const Offset(2, 2), // Slightly offset to bottom-right
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon and text
          Row(
            children: [
              Image.asset(
                iconPath,
                width: 60,
                height: 60,
                fit: BoxFit.contain, // Ensure the image fits well in the space
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
                      color: textColor, // Use the passed text color
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
            onTap: onTap, // Trigger onTap action only for the icon
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
