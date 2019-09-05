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
}
