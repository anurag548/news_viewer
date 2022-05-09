import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_viewer/models/favorites.dart';
import 'package:news_viewer/newsandcovid/drawer_menu.dart';
import 'package:news_viewer/newsandcovid/news_tile.dart';

class FavNews extends StatefulWidget {
  const FavNews({Key? key}) : super(key: key);

  @override
  State<FavNews> createState() => _FavNewsState();
}

class _FavNewsState extends State<FavNews> {
  // var title = ['Title Here', 'TestTitle'];
  // var desc = ['Description her', 'Test Description'];
  // var content = ['Content Here', 'Here Content'];
  // var url = 'Test Url';
  // var imageURL =
  //     'https://i.kym-cdn.com/photos/images/original/001/555/449/7ce.jpg';

  Future getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('favorites').get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              //drawer: DrawerMenu(),
              appBar: AppBar(
                title: Text('Favourites'),
                centerTitle: true,
              ),
              // body: ElevatedButton(
              //   onPressed: () {
              //     print(snapshot.data[2]['title']);
              //   },
              //   child: Text("No name"),
              // )
              body: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: ((context, index) {
                    return NewsTile(
                        title: snapshot.data[index]['title'],
                        description: snapshot.data[index]['Description'],
                        url: snapshot.data[index]['url'],
                        imageUrl: snapshot.data[index]['ImageURL']);
                  })),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
