import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class CurrentPage extends ChangeNotifier {
  int currentIndex = 0;

  changePages(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
