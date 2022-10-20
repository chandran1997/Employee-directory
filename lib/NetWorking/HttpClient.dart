import 'dart:convert';

import 'package:employee_directory/NetWorking/ApiUrl.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  static final HttpClient _instance = HttpClient();

  static HttpClient get instance => _instance;

  Future<Map<String, dynamic>> fetchData(String endPoint) async {
    var responseData;
    try {
      var url = Uri.https(AppUrls.baseUrl, endPoint);
      final response = await http.get(url);

      responseData = _responseData(response);
    } catch (e) {
      print(e.toString());
    }
    return {"employee": responseData};
  }
}

dynamic _responseData(http.Response response) {
  try {
    return json.decode(response.body);
  } catch (exception) {
    throw Exception(exception.toString());
  }
}
