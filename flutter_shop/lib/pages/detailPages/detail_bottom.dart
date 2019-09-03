import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeatilBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750.0),
      height: ScreenUtil.getInstance().setHeight(100.0),
      child: Row(
        children: <Widget>[
          InkWell(
              onTap: () {},
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
          InkWell(
              onTap: () {},
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
              onTap: () {},
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
