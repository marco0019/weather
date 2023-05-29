import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int _currentDay = 0;
  int get currentDay => _currentDay;
  set currentDay(value) {
    _currentDay = value;
    notifyListeners();
  }

  PageController _controller = PageController();
  PageController get controller => _controller;
  set controller(value) {
    _controller = value;
    notifyListeners();
  }

  void setCurrentDay(int value) {
    currentDay = value;
    notifyListeners();
  }
}
