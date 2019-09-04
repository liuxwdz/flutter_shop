import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCounter extends StatelessWidget {
  int count = 0;

  CartCounter(this.count);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(160.0),
      decoration:
          BoxDecoration(border: Border.all(width: 0.5, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _getReduceBtn(),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text('${count}'),
          )),
          _getAddBtn()
        ],
      ),
    );
  }

  Widget _getReduceBtn() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(45.0),
      height: ScreenUtil.getInstance().setHeight(45.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 0.5, color: Colors.black12))),
      child: InkWell(
        onTap: () {},
        child: Container(
          child: Text('-'),
        ),
      ),
    );
  }

  Widget _getAddBtn() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(45.0),
      height: ScreenUtil.getInstance().setHeight(45.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 0.5, color: Colors.black12))),
      child: InkWell(
        onTap: () {},
        child: Container(
          child: Text('+'),
        ),
      ),
    );
  }
}
