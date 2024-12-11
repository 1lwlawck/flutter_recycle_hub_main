import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_recycle_hub/core/services/config.dart';
import 'package:flutter_recycle_hub/utils/shared_prefs_util.dart';

class AuthLoginService {
  // Fungsi untuk login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required bool remember,
  }) async {
    final url = Uri.parse('${Config.API_URL}/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'remember': remember,
        }),
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        // Simpan email dan nama pengguna setelah login berhasil
        String userEmail = responseBody['user']['email'];
        String userName = responseBody['user']['nama_user'];
        int userId = responseBody['user']['id']; // Ambil user_id
        String accessToken = responseBody['access_token'];
        String refreshToken = responseBody['refresh_token'];

        // Simpan data menggunakan SharedPrefsUtil
        await SharedPrefsUtil.saveUserEmail(userEmail);
        await SharedPrefsUtil.saveUserName(userName);
        await SharedPrefsUtil.saveUserId(userId);
        await SharedPrefsUtil.saveAccessToken(accessToken);
        await SharedPrefsUtil.saveRefreshToken(refreshToken);

        return {
          'success': true,
          'access_token': accessToken,
          'refresh_token': refreshToken,
        };
      } else {
        return {'success': false, 'message': responseBody['message']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan saat login: $e'};
    }
  }
}
