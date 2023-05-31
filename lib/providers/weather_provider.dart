import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../utils/dependencies.dart';

class WeatherProvider with ChangeNotifier {
  String title = 'placeholder';
  String countryCode = 'it';
  double latitude = 42;
  double longitude = 12;
  late Future<Map<String, dynamic>> weather;

  void setData(
      {required String ti,
      required String cCode,
      required double lat,
      required double lon}) {
    title = ti;
    countryCode = cCode;
    latitude = lat;
    longitude = lon;
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchWeather(
      {required double latitude, required double longitude}) async {
    final response = await get(Uri.parse(
        "${dotenv.env['API_METEO_URL']}&latitude=$latitude&longitude=$longitude"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<Map<String, dynamic>> fetchWeatherOff(
      {required double latitude, required double longitude}) async {
    String jsonString = await rootBundle.loadString('assets/weather.json');
    return jsonDecode(jsonString);
  }

  Future<Map<String, dynamic>> fetchMapsGeoCoding(String city,
      {int limit = 10, String language = 'en'}) async {
    final response = await get(Uri.parse(
        '${dotenv.env['API_GEOCODING_BASE_URL']}?name=$city&count=$limit&language=$language&format=json'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cities');
    }
  }

  Future<List<dynamic>> fetchMapsOff(String city) async {
    String jsonString = await rootBundle.loadString('assets/city.json');
    return jsonDecode(jsonString);
  }

  Future<Map<String, dynamic>> fetchAirQuality(
      {required double lat, required double lon}) async {
    final response = await get(Uri.parse(
        '${dotenv.env['API_AIR_QUALITY_BASE_URL']}&latitude=$lat&longitude=$lon'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cities');
    }
  }
  Future<Map<String, dynamic>> fetchAirQualityOff({
    required double lat, required double lon
  }) async{
    String jsonString = await rootBundle.loadString('assets/air.json');
    return jsonDecode(jsonString);
  }
}
