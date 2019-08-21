import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/catogery_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatogeryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CatogeryPageState();
}

class _CatogeryPageState extends State<CatogeryPage> {
  String catogeryData = '暂无数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 239, 239),
        ),
        child: Row(
          children: <Widget>[
            LeftCatogeryNav(),
            Column(
              children: <Widget>[RightCatogeryNav()],
            )
          ],
        ),
      ),
    );
  }
}

//左侧商品分类
class LeftCatogeryNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeftCatogeryNavState();
}

class _LeftCatogeryNavState extends State<LeftCatogeryNav> {
  List catogeryList = [];

  @override
  void initState() {
    super.initState();
    _getCatogery();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(width: 0.5, color: Colors.black12))),
      width: ScreenUtil.getInstance().setWidth(180),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _getItemWidget(index);
        },
        itemCount: catogeryList.length,
      ),
    );
  }

  Widget _getItemWidget(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      height: ScreenUtil.getInstance().setHeight(100),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: InkWell(
        onTap: () {
          print('点击了分类条目');
        },
        child: Text(
          catogeryList[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26)),
        ),
      ),
    );
  }

  void _getCatogery() async {
    await postRequest('getCategory').then((value) {
      var jsonData = json.decode(value.toString());
      if (jsonData != null) {
        setState(() {
          CatogeryData catogeryData = CatogeryData.fromJson(jsonData);
          catogeryList = catogeryData.data;
        });
      }
    });
  }
}

//右侧具体商品
class RightCatogeryNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RightCatogeryNavState();
}

class _RightCatogeryNavState extends State<RightCatogeryNav> {
  List detailCatogerys = ['洋河', '五粮液', '二锅头', '泸州老窖', '水井坊', '劲酒', '茅台', '汾酒'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(570),
      height: ScreenUtil.getInstance().setHeight(80),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Colors.black12, width: 0.5))),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _getItemWidget(index);
        },
        itemCount: detailCatogerys.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _getItemWidget(int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 5.0),
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {},
        child: Text(
          detailCatogerys[index],
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26.0)),
        ),
      ),
    );
  }
}
