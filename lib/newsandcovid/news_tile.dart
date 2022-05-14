import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_viewer/controllers/fav_controller.dart';
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
  List<Favorites> favsM = <Favorites>[];

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
    getData();
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  addData() async {
    appendd = Favorites(
        description: widget.description,
        title: widget.title,
        iurl: widget.imageUrl,
        url: widget.url);
    bool isNewsThere = false;
    favsM.forEach((element) {
      if (element.title == appendd.title) {
        isNewsThere = true;
        return;
      }
    });
    if (isNewsThere) {
      setState(() {
        isFavNew = !isFavNew;
      });

      favsM.add(appendd);
      await passTo.doc().set({
        "title": appendd.title,
        "ImageURL": appendd.iurl,
        "Description": appendd.description,
        "url": appendd.url
      });
      print('yes');
    } else {
      print('no');
    }
    // if (!favsM.contains(appendd)) {

    // }
  }

  getData() async {
    var qs = await passTo.get();
    qs.docs.forEach((element) {
      var test = Favorites(
          description: element['Description'],
          title: element['title'],
          iurl: element['ImageURL'],
          url: element['url']);
      favsM.add(test);
    });
    print(favsM);
    // setState(() {
    //isFavNew = true;

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
    // });

    // if (checkExistingNews()) {
    //   print('true');
    // }
  }

  // checkExistingNews() async {
  //   bool checkVal = false;
  //   var qs = await passTo.get();
  //   qs.docs.forEach((element) {
  //     if (element['title'] == widget.title) {
  //       checkVal = true;
  //     }
  //   });
  //   return checkVal;
  // }

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
                      widget.isFavoritePage
                          ? IconButton(
                              onPressed: () {
                                addData();

                                // addData();
                                //print('Data uploaded');
                              },
                              icon: Icon(isFavNew
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded))
                          : IconButton(
                              onPressed: () => widget.favFunc!(),
                              icon: Icon(Icons.star_rounded))
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Future _openUrl({required String urlToOpen}) async {
    launchUrlString(urlToOpen, mode: LaunchMode.inAppWebView);
    // if (await canLaunchUrlString(urlToOpen)) {

    //   launchUrlString(urlToOpen, mode: LaunchMode.inAppWebView);
    // }
  }
}
