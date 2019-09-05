import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_info.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartProvide with ChangeNotifier {
  List<CartInfo> cartInfos = [];

  int allCount = 0;
  double allPrice = 0.0;
  bool isAllSelected = false;

  save(String goodsId, String goodsName, double price, double prePrice,
      int count, String img, bool isChecked) async {
    List<Map> temp = [];
    cartInfos.clear();
    allCount = 0;
    allPrice = 0.0;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var string = sharedPreferences.getString('cartGoods');
    bool contain = false;
    bool hasNoChecked = false;
    if (string != null) {
      var decode = json.decode(string);
      temp = (decode as List).cast();
      temp.forEach((item) {
        if (item['goodsId'] == goodsId) {
          item['count'] = item['count'] + count;
          contain = true;
        }
        if (item['isChecked']) {
          allCount += item['count'];
          allPrice += item['count'] * item['prePrice'];
        } else {
          hasNoChecked = true;
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
        'isChecked': isChecked,
        'count': count,
        'img': img,
      };
      temp.add(value);
      cartInfos.add(CartInfo.fromJson(value));
      if (isChecked) {
        allCount += count;
        allPrice += count * prePrice;
      } else {
        hasNoChecked = true;
      }
    }

    isAllSelected = !hasNoChecked;
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
    bool hasNoChecked = false;
    if (string != null) {
      var decode = json.decode(string);
      List<Map> temp = (decode as List).cast();
      temp.forEach((item) {
        cartInfos.add(CartInfo.fromJson(item));
        if (item['isChecked']) {
          allCount += item['count'];
          allPrice += item['count'] * item['prePrice'];
        } else {
          hasNoChecked = true;
        }
      });
    }
    isAllSelected = !hasNoChecked;
    notifyListeners();
  }

  cleanCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('cartGoods');
    allCount = 0;
    allPrice = 0.0;
    cartInfos.clear();
    isAllSelected = false;
    notifyListeners();
  }

  delGoodsById(String goodsId) async {
    int index = -1;
    int tempIndex = 0;
    bool hasNoChecked = false;
    cartInfos.forEach((item) {
      if (item.goodsId == goodsId) {
        index = tempIndex;
        allCount -= item.count;
        allPrice -= item.count * item.prePrice;
      } else {
        if (!item.isChecked) {
          hasNoChecked = true;
        }
      }
      tempIndex++;
    });

    if (index >= 0) {
      cartInfos.removeAt(index);
      isAllSelected = !hasNoChecked;
    }
    String cartData = json.encode(cartInfos).toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('cartGoods', cartData);
    notifyListeners();
  }

  changeItemChecked(CartInfo) async {
    bool hasNochecked = false;
    cartInfos.forEach((item) {
      if (item.goodsId == CartInfo.goodsId) {
        if (item.isChecked) {
          allCount -= item.count;
          allPrice -= item.count * item.prePrice;
          item.isChecked = false;
        } else {
          allCount += item.count;
          allPrice += item.count * item.prePrice;
          item.isChecked = true;
        }
      }
      if (!item.isChecked) {
        hasNochecked = true;
      }
    });
    isAllSelected = !hasNochecked;
    String cartData = json.encode(cartInfos).toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('cartGoods', cartData);
    notifyListeners();
  }

  changeAllSelected(bool selected) async {
    cartInfos.forEach((item) {
      item.isChecked = selected;
    });
    isAllSelected = selected;
    String cartData = json.encode(cartInfos).toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('cartGoods', cartData);
    notifyListeners();
  }

  addOrReduceCount(CartInfo cartInfo, String type) async {
    cartInfos.forEach((item) {
      if (item.goodsId == cartInfo.goodsId) {
        if ('add' == type) {
          if (item.isChecked) {
            allCount += 1;
            allPrice += 1 * item.prePrice;
          }
          item.count++;
        } else if (item.count > 1) {
          if (item.isChecked) {
            allCount -= 1;
            allPrice -= 1 * item.prePrice;
          }
          item.count--;
        } else {
          Fluttertoast.showToast(
              msg: '不能再少了哦',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.pink,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    });
    String cartData = json.encode(cartInfos).toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('cartGoods', cartData);
    notifyListeners();
  }
}
