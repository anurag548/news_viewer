import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_viewer/models/favorites.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsTile extends StatefulWidget {
  String title, description, url, imageUrl;
  final Function()? favFunc;
  bool isFavoritePage;
  NewsTile(
      {required this.title,
      required this.description,
      required this.url,
      required this.imageUrl,
      required this.isFavoritePage,
      required this.favFunc});
  @override
  State<StatefulWidget> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  bool isFavNew = false;

  List<Favorites> favorites = <Favorites>[];
  var ref = FirebaseAuth.instance.currentUser;
  var appendd;
  late var passTo = FirebaseFirestore.instance
      .collection('users')
      .doc(ref!.uid)
      .collection('favorites');

  //String? nameForDoc;

  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  addData() async {
    setState(() {
      //isFavNew = true;
      appendd = Favorites(
          widget.description, widget.title, widget.imageUrl, widget.url);

      // if (!favorites.contains(appendd)) {
      //   favorites.add(appendd);
      // }

      // favorites.forEach((element) async {
      //   await passTo.set({
      //     "title": element.title,
      //     "ImageURL": element.iurl,
      //     "Description": element.description,
      //     "url": widget.url
      //   });
      // });
    });
    if (checkExistingNews()) {
      print('true');
    }

    // var qs = await passTo.get().then((value) => (value.docs.forEach((element) {
    //       print(element['title'] == widget.title);
    //     })));
  }

  checkExistingNews() async {
    bool checkVal = false;
    var qs = await passTo.get();
    qs.docs.forEach((element) {
      if (element['title'] == widget.title) {
        checkVal = true;
      }
    });
    return checkVal;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openUrl(urlToOpen: widget.url),
      // TODO: Add a function for webview
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
                      // widget.isFavoritePage
                      //     ?
                      IconButton(
                          onPressed: () {
                            addData();
                            setState(() {
                              isFavNew = !isFavNew;
                            });
                            // addData();
                            // print('Data uploaded');
                          },
                          icon: Icon(isFavNew
                              ? Icons.star_rounded
                              : Icons.star_border_rounded))
                      // : IconButton(
                      //     onPressed: () => widget.favFunc!(),
                      //     icon: Icon(Icons.star_rounded))
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Future _openUrl({required String urlToOpen}) async {
    if (await canLaunchUrlString(urlToOpen)) {
      launchUrlString(urlToOpen, mode: LaunchMode.inAppWebView);
    }
  }
}
