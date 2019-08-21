import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Provide<Counter>(
              builder: (context, child, counter) {
                return Text('${counter.value}');
              },
            ),
            RaisedButton(
              onPressed: () {
                Provide.value<Counter>(context).increment();
              },
              child: Text('自增加'),
            )
          ],
        ),
      ),
    );
  }
}
