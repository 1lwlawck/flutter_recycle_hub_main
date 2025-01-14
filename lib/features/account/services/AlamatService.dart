import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_recycle_hub/core/models/Alamat.dart';
import 'package:flutter_recycle_hub/core/services/Config.dart';

class AlamatService {
  static const String apiUrl = '${Config.API_URL}/api/alamat';

  static Future<List<Alamat>> getAlamatByUserId(int userId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl?user_id=$userId'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Alamat.fromJson(json)).toList();
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching alamat: $e');
      return [];
    }
  }

  static Future<bool> createAlamat(Map<String, dynamic> alamatData) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(alamatData),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error creating alamat: $e');
      return false;
    }
  }

  static Future<Alamat?> getAlamatById(int id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Alamat.fromJson(data);
      } else {
        print('Failed to fetch alamat by ID: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching alamat by ID: $e');
      return null;
    }
  }

  static Future<bool> deleteAlamat(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));

      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting alamat: $e');
      return false;
    }
  }

  static Future<bool> updateAlamat(
      int id, Map<String, dynamic> updatedData) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedData),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating alamat: $e');
      return false;
    }
  }

  static Future<bool> saveAlamat(Map<String, dynamic> alamatData) async {
    try {
      if (alamatData.containsKey('id') && alamatData['id'] != null) {
        return await updateAlamat(alamatData['id'], alamatData);
      } else {
        return await createAlamat(alamatData);
      }
    } catch (e) {
      print('Error saving alamat: $e');
      return false;
    }
  }
}
