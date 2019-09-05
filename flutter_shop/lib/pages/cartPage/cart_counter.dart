import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cart_info.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartCounter extends StatelessWidget {
  CartInfo info;

  CartCounter(this.info);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(160.0),
      decoration:
          BoxDecoration(border: Border.all(width: 0.5, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _getReduceBtn(context),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text('${info.count}'),
          )),
          _getAddBtn(context)
        ],
      ),
    );
  }

  Widget _getReduceBtn(context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(45.0),
      height: ScreenUtil.getInstance().setHeight(45.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 0.5, color: Colors.black12))),
      child: InkWell(
        onTap: () {
          Provide.value<CartProvide>(context).addOrReduceCount(info, 'reduce');
        },
        child: Container(
          child: Text('-'),
        ),
      ),
    );
  }

  Widget _getAddBtn(context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(45.0),
      height: ScreenUtil.getInstance().setHeight(45.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 0.5, color: Colors.black12))),
      child: InkWell(
        onTap: () {
          Provide.value<CartProvide>(context).addOrReduceCount(info, 'add');
        },
        child: Container(
          child: Text('+'),
        ),
      ),
    );
  }
}
