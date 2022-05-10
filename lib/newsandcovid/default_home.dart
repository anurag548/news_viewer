import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_viewer/models/news.dart';
import 'package:news_viewer/newsandcovid/drawer_menu.dart';
import 'package:news_viewer/newsandcovid/news_tile.dart';

class NewsRoom extends StatefulWidget {
  const NewsRoom({Key? key}) : super(key: key);

  @override
  State<NewsRoom> createState() => _NewsRoomState();
}

class _NewsRoomState extends State<NewsRoom> {
  News news = News();
  bool _loading = true;
  List<ArticleModel> articles = <ArticleModel>[];

  // var title = ['Title Here', 'TestTitle'];
  // var desc = ['Description her', 'Test Description'];
  // var content = ['Content Here', 'Here Content'];
  // var url = 'Test Url';
  // var imageURL =
  //     'https://i.kym-cdn.com/photos/images/original/001/555/449/7ce.jpg';

  @override
  void initState() {
    waitForNews();
    super.initState();
  }

  waitForNews() async {
    await news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });
    print('All done');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: const DrawerMenu(),
          appBar: AppBar(title: const Text('News')),
          // //TODO: Make a list of Api to builld the news
          // body: Center(
          //     child: ElevatedButton(
          //   child: const Text('Press me'),
          //   onPressed: getNews,
          // )),
          body: _loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return NewsTile(
                        title: articles[index].title,
                        description: articles[index].decriptions,
                        imageUrl: articles[index].urlToImage,
                        url: articles[index].url);
                  }),
          // CarouselSlider(
          //     options: CarouselOptions(height: 400.0),
          //     items: articles.map((i) {
          //       return Builder(
          //         builder: (BuildContext context) {
          //           return NewsTile(
          //               title: articles[i].title,
          //               description: description,
          //               content: content,
          //               url: url,
          //               imageUrl: imageUrl);
          //         },
          //       );
          //     }).toList(),
          //   )
        ));
  }
}
