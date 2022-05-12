import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_viewer/models/favorites.dart';
import 'package:news_viewer/newsandcovid/drawer_menu.dart';
import 'package:news_viewer/newsandcovid/news_tile.dart';

/*


Displays Favorite News by fetching data from firestore


*/
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

  var getId = FirebaseAuth.instance.currentUser!.uid;
  var firestore = FirebaseFirestore.instance;
  getData() async {
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
    return //RefreshIndicator(
        // onRefresh: () async {
        //   setState(() {
        //     getData();
        //   });
        // },
        FutureBuilder(
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
                  // body: ElevatedButton(
                  //   onPressed: () async {
                  //     print(snapshot.data.docs[0].reference.id.toString());
                  //   },
                  //   child: Text("No name"),
                  // )
                  body: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: ((context, index) {
                        return NewsTile(
                          title:
                              snapshot.data.docs.elementAt(index).get('title'),
                          description: snapshot.data.docs
                              .elementAt(index)
                              .get('Description'),
                          url: snapshot.data.docs.elementAt(index).get('url'),
                          imageUrl: snapshot.data.docs
                              .elementAt(index)
                              .get('ImageURL'),
                          isFavoritePage: false,
                          favFunc: () => {
                            firestore
                                .collection('users')
                                .doc(getId)
                                .collection('favorites')
                                .doc(snapshot.data.docs[index].reference.id
                                    .toString())
                                .delete()
                                .then((value) => setState(() {
                                      getData();
                                    }))
                          },
                        );
                      })),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            });
  }
}
