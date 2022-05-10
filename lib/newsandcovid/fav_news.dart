import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    var getId = FirebaseAuth.instance.currentUser!.uid;
    var firestore = FirebaseFirestore.instance;
    print(getId);
    var qn = await firestore
        .collection('users')
        .doc(getId)
        .collection('favorites')
        .get();
    return qn;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              //drawer: DrawerMenu(),
              appBar: AppBar(
                title: Text('Favourites'),
                centerTitle: true,
              ),
              // body: ListView.builder(
              //   itemBuilder: (context, index) {
              //     return Text(snapshot.data.docs.elementAt(index).get('title'));
              //   },
              //   itemCount: snapshot.data.docs.length,
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     print(snapshot.data['title']);
              //   },
              // child: Text("No name"),
              // )
              body: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: ((context, index) {
                    return NewsTile(
                        title: snapshot.data.docs.elementAt(index).get('title'),
                        description: snapshot.data.docs
                            .elementAt(index)
                            .get('Description'),
                        url: snapshot.data.docs.elementAt(index).get('url'),
                        imageUrl: snapshot.data.docs
                            .elementAt(index)
                            .get('ImageURL'));
                  })),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
