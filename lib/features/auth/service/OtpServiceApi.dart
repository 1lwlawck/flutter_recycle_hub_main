// lib/features/auth/service/otp_service_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_recycle_hub/core/services/config.dart';

class OtpServiceApi {
  final http.Client client;

  OtpServiceApi({http.Client? client}) : client = client ?? http.Client();
  Future<Map<String, dynamic>?> verifyOtp(String email, String otp) async {
    final url =
        '${Config.API_URL}/api/auth/verify-otp'; // Ganti dengan URL yang sesuai

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'otp': otp}),
      );

      if (response.statusCode == 200) {
        return json
            .decode(response.body); // Kembalikan response dalam format Map
      } else {
        throw Exception('Failed to verify OTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      return null;
    }
  }
}
