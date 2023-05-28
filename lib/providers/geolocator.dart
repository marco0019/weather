/*
import 'package:flutter/material.dart';
import '../utils/dependecies.dart';
class GeoLocatorProvider with ChangeNotifier {
  Map<String, double> coordinate = {'lat': 0, 'lon': 0};
  GeoLocatorProvider() {
    getCurrentPosition();
    debugPrint(coordinate['lat'].toString());
  }
  void getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    coordinate = {'lat': position.latitude, 'lon': position.longitude};
    notifyListeners();
  }
}
*/