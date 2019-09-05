import 'package:flutter/material.dart';

class CatogeryMan extends ChangeNotifier {
  int currentIndex = 0;

  changeCurreneIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
