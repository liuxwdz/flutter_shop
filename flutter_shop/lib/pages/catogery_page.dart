import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/catogery_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_catogery.dart';
import '../model/catogery_goods_data.dart';
import '../provide/child_catogery_goodslist.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../router/application.dart';
import '../router/routers.dart';

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
              children: <Widget>[RightCatogeryNav(), CatogeryGoodsList()],
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
    _getCatogery();
    _getCatogeryGoods(context);
    super.initState();
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
          Provide.value<ChildCatogery>(context).changeChildCatogeryList(
              childCatogery, catogeryList[index].mallCategoryId);
          _getCatogeryGoods(context,
              categoryId: catogeryList[index].mallCategoryId);
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
          Provide.value<ChildCatogery>(context).changeChildCatogeryList(
              childCatogery, catogeryList[0].mallCategoryId);
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
              return _getItemWidget(
                  index, childCatogery.childCatogeryList[index]);
            },
            itemCount: childCatogery.childCatogeryList.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }

  Widget _getItemWidget(int index, BxMallSubDto item) {
    bool isSelected = false;
    isSelected = (index == Provide.value<ChildCatogery>(context).currentIndex);
    return Container(
      padding: EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 5.0),
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          Provide.value<ChildCatogery>(context)
              .changeCurrentIndex(index, item.mallSubId);
          _getCatogeryGoods(context, categorySubId: item.mallSubId);
        },
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(26.0),
              color: isSelected ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}

//分类商品列表
class CatogeryGoodsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CatogeryGoodsListState();
}

class _CatogeryGoodsListState extends State<CatogeryGoodsList> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CatogeryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide.value<ChildCatogery>(context).curPage == 1) {
            controller.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化：${e}');
        }
        if (data.goodsList.length > 0) {
          return Expanded(
              child: Container(
            width: ScreenUtil.getInstance().setWidth(570.0),
            child: getGoodsView(data.goodsList),
          ));
        } else {
          return Center(
            child: Text('暂时没有数据'),
          );
        }
      },
    );
  }

  Widget getGoodsView(List<DataListBean> goodsList) {
    if (goodsList.length > 0) {
      return EasyRefresh(
        footer: ClassicalFooter(
          bgColor: Colors.white,
          textColor: Colors.pink,
          noMoreText: '',
          loadReadyText: '松手加载更多',
          loadingText: '加载中...',
          loadedText: '加载完成',
          infoText: '',
          infoColor: Colors.pink,
        ),
        child: GridView.builder(
          controller: controller,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          scrollDirection: Axis.vertical,
          itemCount: goodsList.length,
          itemBuilder: (context, index) {
            return getItem(goodsList[index]);
          },
        ),
        onLoad: () async {
          Provide.value<ChildCatogery>(context).addPage();
          var data = {
            'categoryId':
                Provide.value<ChildCatogery>(context).curMallCategoryId,
            'categorySubId':
                Provide.value<ChildCatogery>(context).curSubCategoryId,
            'page': Provide.value<ChildCatogery>(context).curPage
          };
          await postRequest('getMallGoods', formData: data).then((value) {
            var decode = json.decode(value.toString());
            CatogeryGoodsData catogeryGoodsData =
                CatogeryGoodsData.fromJson(decode);
            if (catogeryGoodsData.data != null &&
                catogeryGoodsData.data.length > 0) {
              Provide.value<CatogeryGoodsListProvide>(context)
                  .changeGoodsListMore(catogeryGoodsData.data);
            } else {
              Fluttertoast.showToast(
                  msg: '没有更多数据了',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.pink,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Provide.value<ChildCatogery>(context).changeNoMoreText('没有更多数据了');
            }
          });
        },
      );
    } else {
      return Text('');
    }
  }

  Widget getItem(DataListBean dataListBean) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, Routers.detailPage + '?goodId=${dataListBean.goodsId}');
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        width: ScreenUtil.getInstance().setWidth(285.0),
        child: Column(
          children: <Widget>[
            Image.network(
              dataListBean.image,
              width: ScreenUtil.getInstance().setWidth(180.0),
            ),
            Text(
              dataListBean.goodsName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.pink,
                fontSize: ScreenUtil.getInstance().setSp(26.0),
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  '￥${dataListBean.presentPrice}',
                ),
                Expanded(
                    child: Text(
                  '￥${dataListBean.oriPrice}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

void _getCatogeryGoods(BuildContext context,
    {String categoryId, String categorySubId}) async {
  var data = {
    'categoryId': categoryId == null ? '4' : categoryId,
    'categorySubId': categorySubId == null ? "" : categorySubId,
    'page': 1
  };
  await postRequest('getMallGoods', formData: data).then((value) {
    var decode = json.decode(value.toString());
    CatogeryGoodsData catogeryGoodsData = CatogeryGoodsData.fromJson(decode);
    if (catogeryGoodsData.data != null && catogeryGoodsData.data.length > 0) {
      Provide.value<CatogeryGoodsListProvide>(context)
          .changeGoodsList(catogeryGoodsData.data);
    } else {
      Provide.value<CatogeryGoodsListProvide>(context).changeGoodsList([]);
    }
  });
}
