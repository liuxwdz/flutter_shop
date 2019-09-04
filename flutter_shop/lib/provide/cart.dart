import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_info.dart';

class CartProvide with ChangeNotifier {
  List<CartInfo> cartInfos = [];

  save(String goodsId, String goodsName, double price, double prePrice, int count,
      String img) async {
    List<Map> temp = [];
    cartInfos.clear();
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
        cartInfos.add(CartInfo.fromJson(item));
      });
    }

    if (!contain) {
      var value = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'price': price,
        'prePrice': prePrice,
        'count': count,
        'img': img,
      };
      temp.add(value);
      cartInfos.add(CartInfo.fromJson(value));
    }

    String cartData = json.encode(temp).toString();
    print(cartData);
    print(cartInfos);
    sharedPreferences.setString('cartGoods', cartData);
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var string = sharedPreferences.getString('cartGoods');
    cartInfos.clear();
    if (string != null) {
      var decode = json.decode(string);
      List<Map> temp = (decode as List).cast();
      temp.forEach((item) {
        cartInfos.add(CartInfo.fromJson(item));
      });
    }
    notifyListeners();
  }

  cleanCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('cartGoods');
    cartInfos.clear();
    notifyListeners();
  }
}
