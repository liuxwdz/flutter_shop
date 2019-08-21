import 'package:flutter/material.dart';
import '../model/catogery_data.dart';

class ChildCatogery with ChangeNotifier {
  List<BxMallSubDto> childCatogeryList = [];

  void changeChildCatogeryList(List<BxMallSubDto> list) {
    childCatogeryList = list;
    notifyListeners();
  }
}
