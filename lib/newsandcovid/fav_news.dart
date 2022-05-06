import 'package:flutter/material.dart';
import 'package:news_viewer/newsandcovid/drawer_menu.dart';
import 'package:news_viewer/newsandcovid/news_tile.dart';

class FavNews extends StatefulWidget {
  const FavNews({Key? key}) : super(key: key);

  @override
  State<FavNews> createState() => _FavNewsState();
}

class _FavNewsState extends State<FavNews> {
  var title = ['Title Here', 'TestTitle'];
  var desc = ['Description her', 'Test Description'];
  var content = ['Content Here', 'Here Content'];
  var url = 'Test Url';
  var imageURL =
      'https://i.kym-cdn.com/photos/images/original/001/555/449/7ce.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text('Favourites'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: ((context, index) {
            return NewsTile(
                title[index], desc[index], content[index], url, imageURL);
          })),
    );
  }
}
