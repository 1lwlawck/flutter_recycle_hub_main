import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController?
      controller; // Tambahkan controller sebagai parameter opsional

  const InputField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller, // Inisialisasi controller
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Pasangkan controller
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon:
            isPassword ? const Icon(Icons.lock) : const Icon(Icons.person),
      ),
    );
  }
}
