import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final bool isDisabled; // Tambahkan flag untuk status tombol
  final bool isLoading; // Tambahkan flag untuk loading state

  const LoginButton({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 15.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.isDisabled = false, // Default tidak dinonaktifkan
    this.isLoading = false, // Default tidak dalam mode loading
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled || isLoading
              ? Colors.grey // Warna tombol saat disabled/loading
              : backgroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                buttonText,
                style: TextStyle(fontSize: 18, color: textColor),
              ),
      ),
    );
  }
}
