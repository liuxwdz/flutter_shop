import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/detail_good.dart';

Handler detailHandler =
    Handler(handlerFunc: (context, Map<String, List<String>> params) {
  String goodId = params['goodId'].first;
  return DetailGood(
    goodId: goodId,
  );
});
