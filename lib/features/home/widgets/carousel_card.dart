// lib/src/widgets/carousel_card.dart
import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final String imagePath;

  const CarouselCard({
    super.key,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin:
          const EdgeInsets.symmetric(vertical: 10), // Add margin for spacing
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10), // Small radius for brutalism
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(6, 6), // Slight offset for depth
            blurRadius: 6, // Subtle blur for softer shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text section
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70, // Softer white for description
                  ),
                ),
              ],
            ),
          ),
          // Image section
          Expanded(
            flex: 1,
            child: Container(
              width: 80,
              height: 80,
              padding:
                  const EdgeInsets.all(8), // Add padding inside the container
              decoration: BoxDecoration(
                color:
                    Colors.white.withOpacity(0.9), // Light background for image
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(4, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
