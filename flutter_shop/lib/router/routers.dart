import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routers {
  static String root = '/';
  static String detailPage = '/detail';

  static void configRouters(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('no handler found');
      return null;
    });

    router.define(detailPage, handler: detailHandler);
  }
}
