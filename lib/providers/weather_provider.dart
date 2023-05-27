import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../utils/dependecies.dart';

class WeatherProvider with ChangeNotifier {
  late Future<Map<String, dynamic>> weather;

  WeatherProvider() {
    weather = fetchJSON();
  }

  Future<Map<String, dynamic>> fetchJSON() async {
    final response =
        await get(GLOBAL.GET_OPEN_METEO_DATA(latitude: 45.4, longitude: 12.1));
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

  /// **This method return the list of cities from a string**</br>
  /// [LocationIQ](https://locationiq.com/docs)</br>
  Future<List<dynamic>> fetchMaps(String city) async {
    final response = await get(Uri.parse(GLOBAL.GET_LOCATION_FROM_TEXT(city)));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cities');
    }
  }
  Future<List<dynamic>> fetchMapsOff(String city) async{
    String jsonString = await rootBundle.loadString('assets/city.json');
    return jsonDecode(jsonString);
  }
}
