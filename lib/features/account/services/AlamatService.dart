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
        final data = json.decode(response.body) as List;
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
}
