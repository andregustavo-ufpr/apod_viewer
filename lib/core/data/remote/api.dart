import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_apod_viewer/core/constants/api.dart';
import 'package:nasa_apod_viewer/core/data/exceptions/api.dart';

class Api {
  String url;

  Api({
    required this.url
  });

  Future<Map<String, dynamic>> get(String endpoint, {Map<String, dynamic>? params}) async {
    try{
      Uri uri = Uri(
        scheme: "https",
        host: url,
        path: endpoint,
        queryParameters: params
      );

      http.Response response = await http.get(uri);

      return _handleResponse(response);

    }
    on FailedToDecodeBody catch (e){
      debugPrint("Api get Exception: ${e.cause}");
      return {
        "success": false,
        "message": e.cause
      };
    }
  }

  // Auxiliar function that handle a response object and returns a Map
  Map<String, dynamic> _handleResponse(http.Response aResponse){
    Map<String, dynamic> result = {
      "success": successStatus.contains(aResponse.statusCode)
    };

    try{
      print(jsonDecode(utf8.decode(aResponse.bodyBytes)));
      result.addEntries(jsonDecode(utf8.decode(aResponse.bodyBytes)).entries);
    }
    catch(e){
      throw FailedToDecodeBody("Failed to decode response body");
    }

    return result;
  }
}