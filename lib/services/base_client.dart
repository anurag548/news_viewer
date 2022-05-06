import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:news_viewer/services/app_exceptions.dart';

class BaseClient {
  static const int TO_DURATION = 20;

  //get
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var repsonse =
          await http.get(uri).timeout(Duration(seconds: TO_DURATION));
      return _proccessResponse(repsonse);
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Api down right now', uri.toString());
    }
  }

  Future<dynamic> post(String baseUrl, String api, dynamic sendPayload) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.decode(sendPayload);

    try {
      var repsonse = await http
          .post(uri, body: payload)
          .timeout(Duration(seconds: TO_DURATION));
      return _proccessResponse(repsonse);
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Api down right now', uri.toString());
    }
  }

//Response Handling
  dynamic _proccessResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      //break;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());

      case 403:
        throw UnauthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
        throw FetchDataException(
            'Error occured with code: ${response.statusCode}',
            response.request!.url.toString());
      default:
    }
  }
}
