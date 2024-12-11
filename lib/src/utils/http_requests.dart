import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpRequests {

  static Future<dynamic> getRequest(String baseUrl) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['results'];
      }
    } catch (e) {
      throw Exception('Server error - without return any value: $e');
    }
    throw Exception('Returns error value');
  }
}
