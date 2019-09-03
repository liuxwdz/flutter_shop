import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String textData = '购物车为空';

  @override
  void initState() {
    super.initState();
    _getSp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(textData),
            RaisedButton(
              onPressed: _setSp,
              child: Text('自增加'),
            )
          ],
        ),
      ),
    );
  }

  _setSp() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setString('shop', '这是谁买的？');
    _getSp();
  }

  _getSp() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    var s = instance.getString('shop');
    print('打印购物车信息${s}');
    if (s != null) {
      setState(() {
        textData = s;
      });
    }
  }
}
