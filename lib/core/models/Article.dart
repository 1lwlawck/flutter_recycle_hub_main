// Model: Article.dart
class Article {
  final int id;
  final String title;
  final String author;
  final String content;
  final String publishedDate;
  final String profilePicture;
  final String articleImage;

  Article({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.publishedDate,
    required this.profilePicture,
    required this.articleImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      content: json['content'],
      publishedDate: json['published_date'],
      profilePicture: json['profile_picture'],
      articleImage: json['article_image'],
    );
  }
}
