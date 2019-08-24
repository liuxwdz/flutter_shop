import 'package:flutter/material.dart';
import '../model/catogery_goods_data.dart';

class CatogeryGoodsListProvide with ChangeNotifier {
  List<DataListBean> goodsList = [];

  void changeGoodsList(List<DataListBean> goods) {
    goodsList = goods;
    notifyListeners();
  }

  void changeGoodsListMore(List<DataListBean> goods) {
    goodsList.addAll(goods);
    notifyListeners();
  }
}
