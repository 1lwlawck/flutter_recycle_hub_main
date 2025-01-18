// pages/ArticleListPage.dart
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../services/ArticleService.dart';
import '../../../core/models/Article.dart';
import '../../../widgets/custom_bottom_navbar.dart';
import '../../../core/services/Config.dart';
import 'ArticlePage.dart'; // Import halaman detail artikel

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<List<Article>> _articlesFuture;
  final ArticleService _articleService = ArticleService();

  @override
  void initState() {
    super.initState();
    _articlesFuture = _articleService.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF006769),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Articles',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: FutureBuilder<List<Article>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles available.'));
          }

          final articles = snapshot.data!;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticlePage(articleId: article.id),
                    ),
                  );
                },
                child: _buildArticleItem(article),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 2,
      ),
    );
  }

  Widget _buildArticleItem(Article article) {
    // Gabungkan base URL dengan nama file untuk mendapatkan URL gambar
    final String imageUrl =
        '${Config.API_URL}/static/uploads/image_artikel/${article.articleImage}';

    // Potong konten HTML menjadi 150 kata
    final String truncatedContent = _truncateHtmlContent(article.content, 150);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.articleImage.isNotEmpty)
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Html(
                  data: truncatedContent,
                  style: {
                    "body": Style(
                      fontSize: FontSize(14.0),
                      color: Colors.grey[700],
                    ),
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  article.publishedDate,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Fungsi untuk memotong konten HTML menjadi 150 kata
  String _truncateHtmlContent(String htmlContent, int wordLimit) {
    final words = htmlContent.split(RegExp(r'[\s]+')); // Pisahkan kata
    if (words.length > wordLimit) {
      return words.take(wordLimit).join(' ') + '...';
    }
    return htmlContent;
  }
}
