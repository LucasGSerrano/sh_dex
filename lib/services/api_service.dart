import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@lazySingleton
class APIService {
  fetchData({required String url}) async {
    final fetchUrl = Uri.parse(url);
    final headers = {"Accept": "application/json"};

    final response = await http.get(fetchUrl, headers: headers);

    if (response.statusCode != 200) {
      throw "Error While Retrieving Data";
    }

    JsonDecoder _decoder = new JsonDecoder();

    return _decoder.convert(response.body);
  }
}
