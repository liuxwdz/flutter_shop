import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/catogery_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_catogery.dart';

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
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCatogery();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
      padding: EdgeInsets.only(left: 10.0),
      height: ScreenUtil.getInstance().setHeight(100),
      decoration: BoxDecoration(
          color: (index == currentIndex)
              ? Color.fromARGB(255, 239, 239, 239)
              : Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
          List childCatogery = catogeryList[index].bxMallSubDto;
          Provide.value<ChildCatogery>(context)
              .changeChildCatogeryList(childCatogery);
        },
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            catogeryList[index].mallCategoryName,
            style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(26),
            ),
          ),
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
          List childCatogery = catogeryList[0].bxMallSubDto;
          currentIndex = 0;
          Provide.value<ChildCatogery>(context)
              .changeChildCatogeryList(childCatogery);
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
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCatogery>(
      builder: (context, child, childCatogery) {
        return Container(
          width: ScreenUtil.getInstance().setWidth(570),
          height: ScreenUtil.getInstance().setHeight(80),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: Colors.black12, width: 0.5))),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _getItemWidget(childCatogery.childCatogeryList[index]);
            },
            itemCount: childCatogery.childCatogeryList.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }

  Widget _getItemWidget(BxMallSubDto item) {
    return Container(
      padding: EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 5.0),
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {},
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26.0)),
        ),
      ),
    );
  }
}
