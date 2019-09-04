import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_info.dart';

class CartProvide with ChangeNotifier {
  List<CartInfo> cartInfos = [];

  int allCount = 0;
  double allPrice = 0.0;

  save(String goodsId, String goodsName, double price, double prePrice,
      int count, String img, bool isChecked) async {
    List<Map> temp = [];
    cartInfos.clear();
    allCount = 0;
    allPrice = 0.0;
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
        allCount += item['count'];
        allPrice += item['count'] * item['prePrice'];
        cartInfos.add(CartInfo.fromJson(item));
      });
    }

    if (!contain) {
      var value = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'price': price,
        'prePrice': prePrice,
        'isChecked': isChecked,
        'count': count,
        'img': img,
      };
      temp.add(value);
      cartInfos.add(CartInfo.fromJson(value));
      allCount += count;
      allPrice += count * prePrice;
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
    allCount = 0;
    allPrice = 0.0;
    if (string != null) {
      var decode = json.decode(string);
      List<Map> temp = (decode as List).cast();
      temp.forEach((item) {
        cartInfos.add(CartInfo.fromJson(item));
        allCount += item['count'];
        allPrice += item['count'] * item['prePrice'];
      });
    }
    notifyListeners();
  }

  cleanCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('cartGoods');
    allCount = 0;
    allPrice = 0.0;
    cartInfos.clear();
    notifyListeners();
  }

  delGoodsById(String goodsId) async {
    int index = -1;
    int tempIndex = 0;
    cartInfos.forEach((item) {
      if (item.goodsId == goodsId) {
        index = tempIndex;
        allCount -= item.count;
        allPrice -= item.count * item.prePrice;
      }
      tempIndex++;
    });

    if (index >= 0) {
      cartInfos.removeAt(index);
    }

    String cartData = json.encode(cartInfos).toString();
    print(cartData);
    print(cartInfos);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('cartGoods', cartData);
    notifyListeners();
  }
}
