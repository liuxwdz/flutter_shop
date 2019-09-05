import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _getTopHead(),
          _getMyOrder(),
          _getOrderList(),
          _getGroup1(),
          _getGroup2()
        ],
      ),
    );
  }

  Widget _getTopHead() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750.0),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("images/bg.png"),
      )),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30.0),
            width: ScreenUtil.getInstance().setWidth(150.0),
            height: ScreenUtil.getInstance().setHeight(150.0),
            child: ClipOval(
              child: Image.network(
                  'http://www.soideas.cn/uploads/allimg/111207/0J5304295-12.jpg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 30.0),
            child: Text(
              '用户昵称',
              style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(36.0)),
            ),
          )
        ],
      ),
    );
  }

  Widget _getMyOrder() {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      width: ScreenUtil.getInstance().setWidth(750.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: ListTile(
        leading: Icon(
          Icons.list,
          size: 30.0,
        ),
        title: Text(
          '我的订单',
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(34)),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30.0,
        ),
      ),
    );
  }

  Widget _getOrderList() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: ScreenUtil.getInstance().setWidth(750.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _getOrderItem('待付款', Icons.party_mode),
          _getOrderItem('待发货', Icons.query_builder),
          _getOrderItem('待收货', Icons.directions_car),
          _getOrderItem('待评价', Icons.content_paste)
        ],
      ),
    );
  }

  Widget _getOrderItem(String name, IconData iconData) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(185.0),
      child: Column(
        children: <Widget>[
          Icon(
            iconData,
            size: 30,
          ),
          Text(
            name,
            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(24.0)),
          )
        ],
      ),
    );
  }

  Widget _getGroup1() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(15.0),
        ),
        _getOtherItem('领取优惠券', Icons.mode_comment),
        _getOtherItem('已领取优惠券', Icons.mode_comment),
        _getOtherItem('地址管理', Icons.location_on),
      ],
    );
  }

  Widget _getGroup2() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(15.0),
        ),
        _getOtherItem('客服电话', Icons.perm_phone_msg),
        _getOtherItem('关于商城', Icons.error),
      ],
    );
  }

  Widget _getOtherItem(String name, IconData iconData) {
    return Container(
        width: ScreenUtil.getInstance().setWidth(750.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
        child: ListTile(
          leading: Icon(
            iconData,
            size: 25.0,
          ),
          title: Text(
            name,
            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(28.0)),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30.0,
          ),
        ));
  }
}
