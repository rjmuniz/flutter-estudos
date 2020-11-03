import 'dart:convert';

import 'package:bytebank_app/http/webclient.dart';
import 'package:http/http.dart';

const String MESSAGE_URI = ""
    "https://gist.githubusercontent.com/rjmuniz/239496d624f9df10370e7e498c657da6/raw/ef162a8d334110f8619a183c5f23c9d10627eeed/";

class I18NWebClient {
  final String _language;
  final String _viewKey;

  I18NWebClient(this._language, this._viewKey);


  Future<Map<String, dynamic>> findAll() async {
    final Response response = await WebClient.client.get("$MESSAGE_URI$_viewKey-$_language.json");
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }


}
