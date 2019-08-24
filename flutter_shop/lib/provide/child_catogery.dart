import 'package:flutter/material.dart';
import '../model/catogery_data.dart';

class ChildCatogery with ChangeNotifier {
  int currentIndex = 0;
  List<BxMallSubDto> childCatogeryList = [];

  void changeChildCatogeryList(List<BxMallSubDto> list) {
    currentIndex = 0;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubName = '全部';
    all.mallCategoryId = '00';
    all.mallSubId = '00';
    all.comments = '';
    childCatogeryList = [all];
    childCatogeryList.addAll(list);
    notifyListeners();
  }

  void changeCurrentIndex(int clickIndex) {
    currentIndex = clickIndex;
    notifyListeners();
  }
}
