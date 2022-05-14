import 'package:flutter/cupertino.dart';

class favModel {
  String? title;
  String? description;
  String? url;
  String? iurl;
  favModel({this.description, this.title, this.iurl, this.url});

  // factory favModel.fromMap(map) {
  //   return favModel(
  //       description: map['Description'],
  //       title: map['title'],
  //       iurl: map['iurl'],
  //       url: map['url']);
  // }
}
