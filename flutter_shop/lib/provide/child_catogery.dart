import 'package:flutter/material.dart';
import '../model/catogery_data.dart';

class ChildCatogery with ChangeNotifier {
  List<BxMallSubDto> childCatogeryList = [];

  void changeChildCatogeryList(List<BxMallSubDto> list) {
    BxMallSubDto all = BxMallSubDto();
    all.mallSubName = '全部';
    all.mallCategoryId = '00';
    all.mallSubId = '00';
    all.comments = '';
    childCatogeryList = [all];
    childCatogeryList.addAll(list);
    notifyListeners();
  }
}
