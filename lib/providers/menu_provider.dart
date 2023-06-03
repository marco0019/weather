import 'package:flutter/cupertino.dart';

class MenuProvider with ChangeNotifier {
  int _currentIndex = 1;

  int get currentIndex => _currentIndex;

  set currentIndex(value) {
    _currentIndex = value;
    notifyListeners();
  }

  void setIndex(int value) {
    currentIndex = value;
  }
}
