import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  String cartData = '[]';

  save(String goodsId, String goodsName, double price, int count,
      String img) async {
    List<Map> temp = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var string = sharedPreferences.getString('cartGoods');
    bool contain = false;
    if (string != null) {
      var decode = json.decode(string);
      temp = (decode as List).cast();
      temp.forEach((item) {
        if (item['goodsId'] == goodsId) {
          item['count'] = item['count'] + 1;
          contain = true;
        }
      });
    }

    if (!contain) {
      temp.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'price': price,
        'count': count,
        'img': img,
      });
    }

    cartData = json.encode(temp).toString();
    print(cartData);
    sharedPreferences.setString('cartGoods', cartData);
    notifyListeners();
  }

  cleanCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('cartGoods');
    cartData = '[]';
    notifyListeners();
  }
}
