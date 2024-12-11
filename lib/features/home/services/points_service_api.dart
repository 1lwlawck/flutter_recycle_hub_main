import 'package:http/http.dart' as http;
import 'package:flutter_recycle_hub/utils/shared_prefs_util.dart';
import 'dart:convert';
import 'package:flutter_recycle_hub/core/services/config.dart';

class PointsCardService {
  static Future<int> getUserPoints() async {
    final String token = await SharedPrefsUtil.getAccessToken();
    final url = Uri.parse('${Config.API_URL}/api/points/');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['points'];
    } else {
      throw Exception('Failed to fetch points');
    }
  }
}
