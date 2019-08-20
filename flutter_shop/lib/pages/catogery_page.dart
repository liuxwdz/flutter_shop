import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';

class CatogeryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CatogeryPageState();
}

class _CatogeryPageState extends State<CatogeryPage> {
  String catogeryData = '暂无数据';

  @override
  void initState() {
    super.initState();
    getCatogery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Text(catogeryData),
      ),
    );
  }

  void getCatogery() async {
    await postRequest('getCategory').then((value) {
      var jsonData = json.decode(value.toString());
      if (jsonData != null) {
        setState(() {
          catogeryData = jsonData['data'].toString();
        });
      }
    });
  }
}
