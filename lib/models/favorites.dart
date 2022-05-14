import 'package:firebase_auth/firebase_auth.dart';

class Favorites {
  String? title;

  String? description;
  String? url;
  String? iurl;
  Favorites({this.description, this.title, this.iurl, this.url});
}
