import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../provide/detail.dart';
import '../../model/goods_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common_utils/src/date_util.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailGoodProvide>(
      builder: (context, child, value) {
        var isLeft = value.isLeft;
        if (isLeft) {
          String detail = value.goodsDetail.data.goodInfo.goodsDetail;
          return Container(
            child: Html(data: detail),
          );
        } else {
          return _getCommentWidget(context);
        }
      },
    );
  }

  Widget _getCommentWidget(BuildContext context) {
    List<GoodCommentsListBean> goodComments =
        Provide.value<DetailGoodProvide>(context).goodsDetail.data.goodComments;
    String picturepictureaddress = Provide.value<DetailGoodProvide>(context)
        .goodsDetail
        .data
        .advertesPicture
        .PICTUREPICTUREADDRESS;
    if (goodComments != null && goodComments.length > 0) {
      List<Widget> getCommentList = _getCommentList(goodComments);
      getCommentList.add(Container(
        child: Image.network(picturepictureaddress),
      ));
      return Container(
        width: ScreenUtil.getInstance().setWidth(750.0),
        child: Column(
          children: getCommentList,
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        width: ScreenUtil.getInstance().setWidth(750.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20.0),
            ),
            Text('暂无评论'),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20.0),
            ),
            Image.network(picturepictureaddress),

          ],
        ),
      );
    }
  }

  List<Widget> _getCommentList(List<GoodCommentsListBean> goodComments) {
    return goodComments.map((item) {
      return Container(
        width: ScreenUtil.getInstance().setWidth(750.0),
        padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 0.5, color: Colors.black26))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.userName,
              style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil.getInstance().setSp(30),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              item.comments,
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil.getInstance().setSp(34),
              ),
            ),
            Text(
              DateUtil.formatDateMs(item.discussTime, format: DataFormats.full),
              style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil.getInstance().setSp(28),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
