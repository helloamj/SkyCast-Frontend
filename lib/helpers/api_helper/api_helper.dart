import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skycast/constants/api_constants.dart';

class ApiHelper {
  static Future<dynamic> get(String url,
      {Map<String, dynamic> queryParams = const {}}) async {
    try {
      queryParams['appid'] = ApiConstants.apiKey;
      final response = await http.get(
        Uri.https(ApiConstants.baseURL, url, queryParams),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*"
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> post(String url, dynamic data) async {
    // Your code here
  }

  static Future<dynamic> put(String url, dynamic data) async {
    // Your code here
  }

  static Future<dynamic> delete(String url) async {
    // Your code here
  }
}
