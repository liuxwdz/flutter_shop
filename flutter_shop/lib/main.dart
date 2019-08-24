import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'provide/counter.dart';
import 'package:provide/provide.dart';
import 'provide/child_catogery.dart';
import 'provide/child_catogery_goodslist.dart';

void main() {
  final provide = Providers()
    ..provide(Provider.function((context) => Counter(0)))..provide(
        Provider.function((context) => ChildCatogery()))..provide(
        Provider.function((context) => CatogeryGoodsListProvide()));
  runApp(ProviderNode(child: MyApp(), providers: provide));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
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
