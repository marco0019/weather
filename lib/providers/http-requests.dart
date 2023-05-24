import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather/utils/globals.dart';

class HttpRequest with ChangeNotifier {
  late Future<Map<String, dynamic>> weather;
  HttpRequest() {
    weather = fetchFile();
  }

  Future<Map<String, dynamic>> fetchJSON() async {
    final response = await get(Uri.parse(GLOBAL.WEATHER_DEFAULT_REQUEST));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Map<String, dynamic>> fetchFile() async {
    String jsonString = await rootBundle.loadString('assets/weather.json');
    return jsonDecode(jsonString);
  }
}
