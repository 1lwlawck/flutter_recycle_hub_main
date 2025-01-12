import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_recycle_hub/core/services/Config.dart';
import 'package:flutter_recycle_hub/core/models/Users.dart';

class UserService {
  static final String apiUrl = '${Config.API_URL}/api/users';

  /// Mendapatkan data pengguna
  static Future<User?> getUser(int userId) async {
    try {
      final response =
          await http.get(Uri.parse('$apiUrl/get-users?id=$userId '));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['user'] != null) {
          return User.fromJson(data['user']);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  /// Memperbarui data pengguna menggunakan JSON
  static Future<bool> updateUser({
    required int userId,
    required Map<String, String> userData,
    File? avatarFile, // Tambahkan parameter untuk file avatar
  }) async {
    try {
      final uri = Uri.parse('$apiUrl/update/$userId');

      // Gunakan MultipartRequest untuk menangani multipart/form-data
      final request = http.MultipartRequest('PUT', uri);

      // Tambahkan data pengguna ke form
      userData.forEach((key, value) {
        request.fields[key] = value;
      });

      // Tambahkan file avatar jika ada
      if (avatarFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'avatar', // Nama field sesuai dengan yang diharapkan server
          avatarFile.path,
        ));
      }

      // Kirim request
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);
        return data['success'] == true;
      }

      return false;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }
}
