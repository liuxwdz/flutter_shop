import 'package:flutter/material.dart';

class DetailGood extends StatelessWidget {
  final String goodId;

  const DetailGood({Key key, this.goodId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('当前商品ID:${goodId}'),
    );
  }
}
