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
              return Column(
                children: <Widget>[
                  TopSwiper(
                    swiperDataList: swiperDataList,
                  )
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
    ScreenUtil.instance = ScreenUtil(height: 1334, width: 750)..init(context);
    print('Device width:${ScreenUtil.screenWidth}'); //Device width
    print('Device height:${ScreenUtil.screenHeight}'); //Device height
    print(
        'Device pixel density:${ScreenUtil.pixelRatio}'); //Device pixel density
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
