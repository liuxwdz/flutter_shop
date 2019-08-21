import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int value = 0;

  Counter(this.value);

  void increment() {
    value++;
    notifyListeners();
  }
}
