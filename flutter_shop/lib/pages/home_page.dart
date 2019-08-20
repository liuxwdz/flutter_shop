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

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoods = [];

  @override
  void initState() {
    super.initState();
    postRequest('homePageBelowConten', formData: page).then((onValue) {
      var datas = json.decode(onValue.toString());
      List<Map> newHotGoods = (datas['data'] as List).cast();
      setState(() {
        hotGoods.addAll(newHotGoods);
        page++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = {'lon': '114.06667', 'lat': '22.61667'};
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
              List<Map> recommendDatas = (data['recommend'] as List).cast();
              String floorTitlePic1 = data['floor1Pic']['PICTURE_ADDRESS'];
              String floorTitlePic2 = data['floor2Pic']['PICTURE_ADDRESS'];
              String floorTitlePic3 = data['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floorGoods1 = (data['floor1'] as List).cast();
              List<Map> floorGoods2 = (data['floor2'] as List).cast();
              List<Map> floorGoods3 = (data['floor3'] as List).cast();
              return SingleChildScrollView(
                  child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 239, 239, 239),
                ),
                child: Column(
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
                    ),
                    Recommend(
                      recommendList: recommendDatas,
                    ),
                    FloorGoodsTitle(
                      floorPicture: floorTitlePic1,
                    ),
                    FloorGoods(
                      floorGoodsList: floorGoods1,
                    ),
                    FloorGoodsTitle(
                      floorPicture: floorTitlePic2,
                    ),
                    FloorGoods(
                      floorGoodsList: floorGoods2,
                    ),
                    FloorGoodsTitle(
                      floorPicture: floorTitlePic3,
                    ),
                    FloorGoods(
                      floorGoodsList: floorGoods3,
                    ),
                    getHotWidget()
                  ],
                ),
              ));
            } else {
              return Center(
                child: Text('数据还在加载中...'),
              );
            }
          },
          future: postRequest('homePageContent', formData: data),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget getHotWidget() {
    return Column(
      children: <Widget>[_getHotTitle(), _getHotWrap()],
    );
  }

  Widget _getHotTitle() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.copyright,
            color: Colors.pink,
            size: 30.0,
          ),
          Text(
            '火爆专区',
          )
        ],
      ),
    );
  }

  Widget _getHotWrap() {
    if (hotGoods.length > 0) {
      List<Widget> hotGoodsView = hotGoods.map((item) {
        return _getHotItem(item);
      }).toList();

      return Wrap(
        spacing: 2,
        children: hotGoodsView,
      );
    } else {
      return Text('');
    }
  }

  Widget _getHotItem(Map item) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil.getInstance().setWidth(372),
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Image.network(item['image']),
            Text(
              item['name'],
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: ScreenUtil.getInstance().setSp(26)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: <Widget>[
                Text('￥${item['mallPrice']}'),
                SizedBox(
                  width: ScreenUtil.getInstance().setWidth(60.0),
                ),
                Text(
                  '￥${item['price']}',
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                )
              ],
            )
          ],
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
      color: Colors.white,
      height: ScreenUtil().setHeight(340),
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

//商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({this.recommendList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(450),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_getRecommendTitle(), _getListView()],
      ),
    );
  }

  Widget _getRecommendTitle() {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget _getItem(item) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil.getInstance().setWidth(250),
        height: ScreenUtil.getInstance().setHeight(380),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(item['image']),
            Text('￥${item['mallPrice']}'),
            Text(
              '￥${item['price']}',
              style: TextStyle(
                  color: Colors.grey, decoration: TextDecoration.lineThrough),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getListView() {
    return Container(
      height: ScreenUtil.getInstance().setHeight(380),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _getItem(recommendList[index]);
        },
        itemCount: recommendList.length,
      ),
    );
  }
}

//楼层商品标题
class FloorGoodsTitle extends StatelessWidget {
  final String floorPicture;

  const FloorGoodsTitle({Key key, this.floorPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(floorPicture),
    );
  }
}

class FloorGoods extends StatelessWidget {
  final List floorGoodsList;

  const FloorGoods({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_getFirstFloor(), _getSecondFloor()],
      ),
    );
  }

  Widget _getItem(Map item) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(375.0),
      child: Image.network(item['image']),
    );
  }

  Widget _getFirstFloor() {
    return Row(
      children: <Widget>[
        _getItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _getItem(floorGoodsList[1]),
            _getItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _getSecondFloor() {
    return Row(
      children: <Widget>[
        _getItem(floorGoodsList[3]),
        _getItem(floorGoodsList[4]),
      ],
    );
  }
}

//火爆专场
class HotGoods extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HotGoodsState();
}

class HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('火爆专区');
  }
}
