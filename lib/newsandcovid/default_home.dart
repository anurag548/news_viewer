import 'package:flutter/material.dart';
import 'package:news_viewer/newsandcovid/drawer_menu.dart';
import 'package:news_viewer/newsandcovid/news_tile.dart';

class NewsRoom extends StatefulWidget {
  const NewsRoom({Key? key}) : super(key: key);

  @override
  State<NewsRoom> createState() => _NewsRoomState();
}

class _NewsRoomState extends State<NewsRoom> {
  var title = ['Title Here', 'TestTitle'];
  var desc = ['Description her', 'Test Description'];
  var content = ['Content Here', 'Here Content'];
  var url = 'Test Url';
  var imageURL =
      'https://i.kym-cdn.com/photos/images/original/001/555/449/7ce.jpg';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: const DrawerMenu(),
          appBar: AppBar(title: const Text('News')),
          //TODO: Make a list of Api to builld the news
          body: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return NewsTile(
                    title[index], desc[index], content[index], url, imageURL);
              }),
        ));
  }
}
