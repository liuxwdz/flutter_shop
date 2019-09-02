import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/detail.dart';
import 'detailPages/detail_top_widget.dart';
import 'detailPages/detail_explain.dart';
import 'detailPages/detail_tabbar.dart';
import 'detailPages/details_web.dart';

class DetailGood extends StatelessWidget {
  final String goodId;

  const DetailGood({Key key, this.goodId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
          future: getDetail(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView(
                  children: <Widget>[
                    DetailTopWidget(),
                    DetailExplain(),
                    DeatilTabbar(),
                    DetailsWeb()
                  ],
                ),
              );
            } else {
              return Text('加载中...');
            }
          }),
    );
  }

  Future getDetail(BuildContext context) async {
    await Provide.value<DetailGoodProvide>(context).getDetailById(goodId);
    return '加载完成';
  }
}
