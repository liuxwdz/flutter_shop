import 'package:flutter/material.dart';
import '../model/catogery_data.dart';

class ChildCatogery with ChangeNotifier {
  int currentIndex = 0;
  List<BxMallSubDto> childCatogeryList = [];
  String curMallCategoryId = '4';
  String curSubCategoryId = '';

  void changeChildCatogeryList(List<BxMallSubDto> list, String mallCategoryId) {
    curMallCategoryId = mallCategoryId;
    curSubCategoryId = '';
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

  void changeCurrentIndex(int clickIndex, String subCategoryId) {
    currentIndex = clickIndex;
    curSubCategoryId = subCategoryId;
    notifyListeners();
  }
}
