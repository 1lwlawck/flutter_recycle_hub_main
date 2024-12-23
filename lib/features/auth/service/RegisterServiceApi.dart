import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_recycle_hub/core/services/config.dart'; // Pastikan kamu import Config

class RegisterServiceApi {
  final http.Client client;

  RegisterServiceApi({http.Client? client}) : client = client ?? http.Client();
  Future<Map<String, dynamic>?> register(String nama, String email,
      String password, String confirmPassword) async {
    final url =
        '${Config.API_URL}/api/auth/register'; // Ganti dengan URL yang sesuai

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nama_user': nama,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to register: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
      return null;
    }
  }
}
