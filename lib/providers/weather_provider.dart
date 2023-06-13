import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:weather/providers/local_storage.dart';
import '../utils/dependencies.dart';

class WeatherProvider with ChangeNotifier {
  String title = 'placeholder';
  String countryCode = 'it';
  bool isSaved = false;
  double? latitude;
  double? longitude;
  late Future<Map<String, dynamic>> weather;
  late Future<Map<String, dynamic>> airQuality;
  late Future<List<Map<String, dynamic>>> recentlyPlace;
  late Future<List<Map<String, dynamic>>> savedPlaces;
  int _currentIndex = 1;

  int get currentIndex => _currentIndex;

  set currentIndex(value) {
    _currentIndex = value;
    notifyListeners();
  }

  void setIndex(int value) {
    currentIndex = value;
  }

  WeatherProvider() {
    if (LocalStorage.db.isOpen) {
      LocalStorage.initTabla();
      initData();
    }
  }

  void initData() async {
    List<Map<String, dynamic>> places = await LocalStorage.getItems('Recently');
    //debugPrint(places.toString());
    if (places.isNotEmpty) {
      setData(
          ti: places[0]['place'],
          cCode: places[0]['country'],
          lat: places[0]['latitude'],
          lon: places[0]['longitude'],
          notify: false);
      setIndex(0);
    }
  }

  void setData(
      {required String ti,
      required String cCode,
      required double lat,
      required double lon,
      bool notify = true,
      bool setData = true,
      bool airQ = true}) {
    title = ti;
    countryCode = cCode;
    latitude = lat;
    longitude = lon;
    LocalStorage.contains('PlaceSaved', latitude: lat, longitude: lon)
        .then((value) {
      isSaved = value;
      notifyListeners();
    });
    if (setData) weather = fetchWeather(latitude: lat, longitude: lon);
    if (airQ) airQuality = fetchAirQuality(lat: lat, lon: lon);
    if (notify) notifyListeners();
  }

  void setSavedPlace(bool value) {
    isSaved = value;
    notifyListeners();
  }

  void setRecentlyPlaces({bool notify = false}) {
    recentlyPlace = LocalStorage.getItems('Recently');
    if (notify) notifyListeners();
  }

  void setSavedPlaces({bool notify = false}) {
    savedPlaces = LocalStorage.getItems('PlaceSaved');
    if (notify) notifyListeners();
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
      {int limit = 10, String language = 'it'}) async {
    final response = await get(Uri.parse(
        '${dotenv.env['API_GEOCODING_BASE_URL']}?name=$city&count=$limit&language=$language&format=json'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cities');
    }
  }

  Future<Map<String, dynamic>> fetchAirQuality(
      {required double lat, required double lon}) async {
    final response = await get(Uri.parse(
        '${dotenv.env['API_AIR_QUALITY_URL_BASIC']}&latitude=$lat&longitude=$lon'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cities');
    }
  }
}
