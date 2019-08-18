import 'package:flutter/material.dart';
import '../configs/service_method.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

String homeContentText = '还没有获取数据';

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getHomePageContent().then((onValue) {
      setState(() {
        homeContentText = onValue.toString();
      });
    });
  }

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
              children: <Widget>[Text(homeContentText)],
            ),
          ),
        ),
      ),
    );
  }
}
