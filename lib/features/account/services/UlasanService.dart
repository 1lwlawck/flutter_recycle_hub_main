import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_recycle_hub/core/services/config.dart';

class UlasanService {
  static const _endpoint = '/api/sentiment/analyze';

  /// Mengirim ulasan ke API
  static Future<Map<String, dynamic>> postUlasan(String ulasan) async {
    final url = Uri.parse('${Config.API_URL}$_endpoint');

    try {
      // Debugging request
      print('POST $url');
      print('Payload: ${jsonEncode({'text': ulasan})}');

      // Kirim request ke API
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': ulasan}), // Menggunakan kunci 'text'
      );

      // Debugging response
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Jika sukses
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          "success": true,
          "data": data, // Data yang berhasil dibuat
        };
      }

      // Jika gagal, kembalikan error dari API
      final error = jsonDecode(response.body);
      return {
        "success": false,
        "error": error["error"] ?? "Unknown error",
      };
    } catch (e) {
      // Menangani error yang tidak terduga
      print('Error: $e');
      return {
        "success": false,
        "error": "Failed to connect to the server. Please try again.",
      };
    }
  }
}
