import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
              var data = swiperData['data'];
              List<Map> swiperDataList = (data['slides'] as List).cast();
              List<Map> topNavgatorData = (data['category'] as List).cast();
              String adBannerPicture =
                  data['advertesPicture']['PICTURE_ADDRESS'];
              String leaderPhone = data['shopInfo']['leaderPhone'];
              String leaderImage = data['shopInfo']['leaderImage'];
              return Column(
                children: <Widget>[
                  TopSwiper(
                    swiperDataList: swiperDataList,
                  ),
                  TopNavgator(navgatorDataList: topNavgatorData),
                  AdBanner(
                    AdPicture: adBannerPicture,
                  ),
                  LeadPhone(
                    leadPhone: leaderPhone,
                    leadPicture: leaderImage,
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

class AdBanner extends StatelessWidget {
  final String AdPicture;

  AdBanner({this.AdPicture});

  @override
  Widget build(BuildContext context) {
    return Image.network(AdPicture);
  }
}

class LeadPhone extends StatelessWidget {
  final String leadPhone;
  final String leadPicture;

  LeadPhone({this.leadPhone, this.leadPicture});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leadPicture),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leadPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
