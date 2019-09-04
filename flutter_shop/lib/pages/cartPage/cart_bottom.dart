import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil.getInstance().setWidth(750.0),
      padding: EdgeInsets.all(5.0),
      child: Provide<CartProvide>(builder: (context, child, value) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getSelAllCheckbtn(),
            _getMidAreaWidget(value.allPrice),
            _getRightBtn(value.allCount)
          ],
        );
      }),
    );
  }

  Widget _getSelAllCheckbtn() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: true,
            onChanged: (bool value) {},
            activeColor: Colors.red,
          ),
          Text(
            '全选',
            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(34.0)),
          )
        ],
      ),
    );
  }

  Widget _getMidAreaWidget(double allPricee) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      width: ScreenUtil.getInstance().setWidth(400.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '合计:',
                style:
                    TextStyle(fontSize: ScreenUtil.getInstance().setSp(36.0)),
              ),
              Text(
                '￥${allPricee}',
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: ScreenUtil.getInstance().setSp(32.0)),
              )
            ],
          ),
          Text(
            '满10元免费配送，预购免费配送',
            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(20.0)),
          )
        ],
      ),
    );
  }

  Widget _getRightBtn(int allCount) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil.getInstance().setWidth(150.0),
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0), color: Colors.red),
        child: Text(
          '结算(${allCount})',
          style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil.getInstance().setSp(32.0)),
        ),
      ),
    );
  }
}
