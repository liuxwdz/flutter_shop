import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../provide/detail.dart';
import '../../provide/current_page.dart';

class DeatilBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodInfo =
        Provide.value<DetailGoodProvide>(context).goodsDetail.data.goodInfo;
    return Container(
      width: ScreenUtil.getInstance().setWidth(750.0),
      height: ScreenUtil.getInstance().setHeight(100.0),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Provide.value<CurrentPage>(context).changePages(2);
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    width: ScreenUtil.getInstance().setWidth(110.0),
                    height: ScreenUtil.getInstance().setHeight(100.0),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.pink,
                      size: 30,
                    ),
                  )),
              Provide<CartProvide>(builder: (context, child, value) {
                return Positioned(
                  top: 2.0,
                  right: 2.0,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 6.0, top: 3.0, right: 6.0, bottom: 3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.red),
                    child: Text(
                      '${value.allCount}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil.getInstance().setSp(16.0)),
                    ),
                  ),
                );
              }),
            ],
          ),
          InkWell(
              onTap: () {
                Provide.value<CartProvide>(context).save(
                    goodInfo.goodsId,
                    goodInfo.goodsName,
                    goodInfo.oriPrice,
                    goodInfo.presentPrice,
                    1,
                    goodInfo.image1,
                    true);
              },
              child: Container(
                alignment: Alignment.center,
                width: ScreenUtil.getInstance().setWidth(320.0),
                height: ScreenUtil.getInstance().setHeight(100.0),
                color: Colors.green,
                child: Text(
                  '加入购物车',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(34),
                      color: Colors.white),
                ),
              )),
          InkWell(
              onTap: () {
                Provide.value<CartProvide>(context).cleanCart();
              },
              child: Container(
                alignment: Alignment.center,
                width: ScreenUtil.getInstance().setWidth(320.0),
                height: ScreenUtil.getInstance().setHeight(100.0),
                color: Colors.red,
                child: Text(
                  '立即购买',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(34),
                      color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
