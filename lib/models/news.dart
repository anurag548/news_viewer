import 'package:news_viewer/services/base_client.dart';
import 'dart:core';

class News {
  List<ArticleModel> news = [];
  var totalResults;

  getNews() async {
    var response = await BaseClient().get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=',
        'b0dd779723ea4f569aa9c5c794a04594');
    //print(response);

    if (response['status'] == 'ok') {
      totalResults = response['totalResults'];
      response["articles"].forEach((elements) {
        if (elements['urlToImage'] != null &&
            elements['description'] != null &&
            elements['author'] != null &&
            elements['url'] != null &&
            elements['title'] != null &&
            elements['content'] != null) {
          ArticleModel articleModel = ArticleModel(
              author: elements['author'],
              decriptions: elements['description'],
              content: elements['content'],
              title: elements['title'],
              url: elements['url'],
              urlToImage: elements['urlToImage']);
          news.add(articleModel);
        }
      });
    } else {
      print('error');
    }
  }
}

class ArticleModel {
  String title;
  String decriptions;
  String url;
  String urlToImage;
  String content;
  String author;

  ArticleModel(
      {required this.author,
      required this.decriptions,
      required this.content,
      required this.title,
      required this.url,
      required this.urlToImage});
}
