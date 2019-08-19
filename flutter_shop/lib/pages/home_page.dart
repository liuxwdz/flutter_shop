import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("百姓生活"),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var swiperData = json.decode(snapshot.data.toString());
              List<Map> swiperDataList =
                  (swiperData['data']['slides'] as List).cast();
              List<Map> topNavgatorData =
                  (swiperData['data']['category'] as List).cast();
              return Column(
                children: <Widget>[
                  TopSwiper(
                    swiperDataList: swiperDataList,
                  ),
                  TopNavgator(navgatorDataList: topNavgatorData)
                ],
              );
            } else {
              return Center(
                child: Text('数据还在加载中...'),
              );
            }
          },
          future: getHomePageContent(),
        ),
      ),
    );
  }
}

class TopSwiper extends StatelessWidget {
  List<Map> swiperDataList;

  TopSwiper({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(333),
      width: ScreenUtil.getInstance().setWidth(750),
      child: Swiper(
        itemCount: swiperDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            swiperDataList[index]['image'],
            fit: BoxFit.fill,
          );
        },
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavgator extends StatelessWidget {
  final List<Map> navgatorDataList;

  TopNavgator({this.navgatorDataList});

  @override
  Widget build(BuildContext context) {
    if (this.navgatorDataList.length > 10) {
      this.navgatorDataList.removeRange(10, this.navgatorDataList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navgatorDataList.map((item) {
          return _getGridViewItem(context, item);
        }).toList(),
      ),
    );
  }

  Widget _getGridViewItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了当前条目${item['mallCategoryName']}');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil.getInstance().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }
}
