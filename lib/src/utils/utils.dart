import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  static void toast({required String message, required double fontSize}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: fontSize);
  }

  static String mapToQueryParams(Map<String, String> params) {
    if (params.isEmpty) return '';

    // Join each key-value pair with '=' and then concatenate pairs with '&'
    return params.entries.map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}').join('&');
  }

}