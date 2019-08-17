import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../configs/http_heads.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

TextEditingController _editingController = TextEditingController();

var textValue = "还没选择美女哦";

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("天上人间"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _editingController,
                  decoration: InputDecoration(
                      labelText: "美女类型",
                      helperText: "请选择美女类型",
                      contentPadding: EdgeInsets.all(10.0)),
                ),
                RaisedButton(
                  onPressed: _doAction,
                  child: Text("确认选择"),
                ),
                Text(textValue)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _doAction() {
    print("开始拉去新闻");
    if (_editingController.text.toString() == "") {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("没有选择美女类型"),
              ));
    } else {
      _getNews(_editingController.text.toString()).then((onValue) {
        print(onValue);
        setState(() {
          textValue = onValue;
        });
      });
    }
  }

  Future _getNews(String type) async {
    print("你选择的是：$type");
    var data = {"page": 1};
    try {
      Response response;
      Dio dio = Dio();
      dio.options.headers=heads;
      response = await dio
          .post("https://time.geekbang.org/serv/v1/column/newAll");
      return response.data.toString();
    } catch (e) {
      return print(e);
    }
  }
}
