import 'package:http/http.dart' as http;
import 'dart:convert';


class HttpRequests {
  static Future<dynamic> getRequest(String baseUrl) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return {
          "status": "success",
          "result": data
        };
      }else{
        return {
          "status": "failure",
          "result": {}
        };
      }
    } catch (e) {
      return {
        "status": "failure",
        "result": {}
      };
    }

  }
}
