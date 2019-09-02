import 'package:flutter/material.dart';
import '../../model/goods_detail.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/detail.dart';

class DetailTopWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Provide<DetailGoodProvide>(builder: (context, child, value) {
        var goodInfo = value.goodsDetail.data.goodInfo;
        if (goodInfo == null) {
          return Text('数据正在加载中....');
        } else {
          return Container(
            child: Column(
              children: <Widget>[
                _getTopImg(goodInfo.image1),
                _getTopGoodsName(goodInfo.goodsName),
                _getTopGoodsSn(goodInfo.goodsSerialNumber),
                _getGoodsPrice(goodInfo.oriPrice, goodInfo.presentPrice),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _getTopImg(String url) {
    return Container(
      child: Image.network(
        url,
        width: ScreenUtil.getInstance().setWidth(740),
      ),
    );
  }

  Widget _getTopGoodsName(String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10.0),
      child: Text(
        name,
        style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(36), color: Colors.black),
      ),
    );
  }

  Widget _getTopGoodsSn(String sn) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      alignment: Alignment.centerLeft,
      child: Text(
        '编号:${sn}',
        style: TextStyle(color: Colors.black26),
      ),
    );
  }

  Widget _getGoodsPrice(double oriPrice, double presentPrice) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '￥${presentPrice}',
            style: TextStyle(
                color: Colors.pink,
                fontSize: ScreenUtil.getInstance().setSp(38)),
          ),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(45.0),
          ),
          Text(
            '市场价:',
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil.getInstance().setSp(36)),
          ),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(15.0),
          ),
          Text(
            '￥${oriPrice}',
            style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil.getInstance().setSp(30),
                decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
