import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _getNews();
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

  void _getNews() async{
    Response response;
    try{
      response = await Dio().get("http://api.wangshuwen.com/getNews");
      return print(response);
    }catch(e){
      return print(e);
    }

  }
}
