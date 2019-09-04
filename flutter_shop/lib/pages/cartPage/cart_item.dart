import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cart_info.dart';
import 'cart_counter.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartItem extends StatelessWidget {
  final CartInfo item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 0.5),
          ),
          color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _getCheckBox(),
          _getGoodsImg(),
          _getNameWidget(),
          _getRightWidget(context)
        ],
      ),
    );
  }

  Widget _getCheckBox() {
    return Container(
      child: Checkbox(
        value: item.isChecked,
        onChanged: (bool isChecked) {},
        activeColor: Colors.pink,
        checkColor: Colors.grey,
      ),
    );
  }

  Widget _getGoodsImg() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(150.0),
      height: ScreenUtil.getInstance().setHeight(150.0),
      padding: EdgeInsets.all(5.0),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black12, width: 0.5)),
      child: Image.network(item.img),
    );
  }

  Widget _getNameWidget() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(320.0),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.goodsName),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(10.0),
          ),
          CartCounter(item.count)
        ],
      ),
    );
  }

  Widget _getRightWidget(context) {
    return Container(
      alignment: Alignment.topRight,
      width: ScreenUtil.getInstance().setWidth(150.0),
      child: Column(
        children: <Widget>[
          Text(
            '￥${item.prePrice}',
            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(28.0)),
          ),
          Text(
            '￥${item.price}',
            style: TextStyle(
                color: Colors.black12, decoration: TextDecoration.lineThrough),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(10.0),
          ),
          IconButton(
              icon: Icon(
                Icons.delete_outline,
                size: 30.0,
                color: Colors.black12,
              ),
              onPressed: () {
                Provide.value<CartProvide>(context).delGoodsById(item.goodsId);
              })
        ],
      ),
    );
  }
}
