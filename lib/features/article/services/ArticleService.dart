// services/ArticleService.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_recycle_hub/core/models/Article.dart';
import 'package:flutter_recycle_hub/core/services/Config.dart'; // Import Config

class ArticleService {
  // Ambil semua artikel
  Future<List<Article>> fetchArticles() async {
    final String apiUrl = '${Config.API_URL}api/articles/list';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles: ${response.statusCode}');
    }
  }

  // Ambil artikel berdasarkan ID
  Future<Article> fetchArticleById(int id) async {
    final String apiUrl = '${Config.API_URL}api/articles/get/$id';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Article.fromJson(data);
    } else {
      throw Exception(
          'Failed to load article with ID $id: ${response.statusCode}');
    }
  }
}
