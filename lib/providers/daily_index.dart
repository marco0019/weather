import 'package:flutter/material.dart';

class DailyIndex with ChangeNotifier {
  DailyIndex();
  int _currentDay = 0;
  int get currentDay => _currentDay;
  set currentDay(value) {
    _currentDay = value;
    notifyListeners();
  }

  void setCurrentDay(int value) {
    currentDay = value;
    notifyListeners();
  }
}
