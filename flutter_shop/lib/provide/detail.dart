import 'package:flutter/material.dart';
import '../model/goods_detail.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailGoodProvide with ChangeNotifier {
  GoodsDetail goodsDetail;

  void getDetailById(String goodId) {
    var data = {'goodId': goodId};
    postRequest('getGoodDetailById', formData: data).then((value) {
      var decode = json.decode(value.toString());
      goodsDetail = GoodsDetail.fromJson(decode);
      notifyListeners();
    });
  }
}
