import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_viewer/models/favorites.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsTile extends StatefulWidget {
  String title, description, url, imageUrl;
  NewsTile(
      {required this.title,
      required this.description,
      required this.url,
      required this.imageUrl});
  @override
  State<StatefulWidget> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  List<Favorites> favorites = <Favorites>[];
  var ref = FirebaseAuth.instance.currentUser;
  var appendd;
  late var passTo = FirebaseFirestore.instance.collection('favorites').doc();
  String? nameForDoc;
  addData() {
    setState(() {
      appendd = Favorites(
          widget.description, widget.title, widget.imageUrl, widget.url);
      if (!favorites.contains(appendd)) {
        favorites.add(appendd);
      }
      favorites.forEach((element) async {
        await passTo.set({
          "title": element.title,
          "ImageURL": element.iurl,
          "Description": element.description,
          "url": widget.url
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        //color: Colors.amber,
        margin: const EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Container(
            //color: Colors.pink,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(6))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      widget.imageUrl,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(widget.title,
                      maxLines: 2,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.description,
                    maxLines: 2,
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 90,
                      ),
                      IconButton(
                          onPressed: () {
                            addData();
                          },
                          icon: const Icon(Icons.star_border))
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
