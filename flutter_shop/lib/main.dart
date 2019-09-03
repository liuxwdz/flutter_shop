import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'provide/counter.dart';
import 'package:provide/provide.dart';
import 'provide/child_catogery.dart';
import 'provide/child_catogery_goodslist.dart';
import 'package:fluro/fluro.dart';
import 'router/application.dart';
import 'router/routers.dart';
import 'provide/detail.dart';
import 'provide/cart.dart';

void main() {
  final provide = Providers()
    ..provide(Provider.function((context) => Counter(0)))
    ..provide(Provider.function((context) => ChildCatogery()))
    ..provide(Provider.function((context) => CatogeryGoodsListProvide()))
    ..provide(Provider.function((context) => CartProvide()))
    ..provide(Provider.function((context) => DetailGoodProvide()));

  runApp(ProviderNode(child: MyApp(), providers: provide));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routers.configRouters(router);
    Application.router = router;
    return Container(
      child: MaterialApp(
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        title: "百姓生活家",
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
