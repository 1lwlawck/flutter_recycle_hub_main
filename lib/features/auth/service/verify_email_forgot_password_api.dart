import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_recycle_hub/core/services/config.dart';

class EmailVerificationService {
  // URL API endpoint Anda (ganti sesuai dengan server Anda)
  static const String APP_URL = '${Config.API_URL}/api/auth/forgot';

  // Fungsi untuk mengirim permintaan reset password ke server
  Future<Map<String, dynamic>> sendResetPasswordRequest(String email) async {
    if (email.isEmpty) {
      return {'success': false, 'message': 'Email tidak boleh kosong'};
    }

    final url = Uri.parse(APP_URL);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData; // Menyimpan data respons dari server
      } else {
        return {
          'success': false,
          'message': 'Terjadi kesalahan, coba lagi nanti.'
        };
      }
    } catch (e) {
      // Tangani error koneksi
      return {
        'success': false,
        'message': 'Terjadi kesalahan, coba lagi nanti.'
      };
    }
  }
}
