import 'package:supabase_flutter/supabase_flutter.dart';

class ArticleData {
  final Map<String, dynamic> _articleData;

  const ArticleData(this._articleData);

  Map<String, dynamic> get articleData => _articleData;
}

class Article {
  static final supabase = Supabase.instance.client;

  static Future<List<ArticleData>> fetchArticles() async {
    final response = await supabase.from('news_json')
        .select().order('fetched_at', ascending: false);

    List<ArticleData> articleData = [];
    for (final row in response) {
      final payload = row['payload'] as Map<String, dynamic>;
      final articles = payload['articles'] as List<dynamic>;

      for (final article in articles) {
        articleData.add(ArticleData(article));
      }

    }
    return articleData;
  }

}