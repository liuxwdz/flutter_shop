import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../provide/detail.dart';
import '../../model/goods_detail.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String detail = Provide.value<DetailGoodProvide>(context)
        .goodsDetail
        .data
        .goodInfo
        .goodsDetail;
    return Container(
      child: Html(data: detail),
    );
  }
}
