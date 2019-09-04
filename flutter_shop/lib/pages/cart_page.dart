import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';
import 'cartPage/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
          future: _getCartInfos(context),
          builder: (context, snapshot) {
            List cartInfos = Provide.value<CartProvide>(context).cartInfos;
            print('购物车商品数量：${cartInfos.length}');
            if (snapshot.hasData && cartInfos.length > 0) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return CartItem(cartInfos[index]);
                },
                itemCount: cartInfos.length,
              );
            } else {
              return Center(
                child: Text('没有数据'),
              );
            }
          }),
    );
  }

  Future<String> _getCartInfos(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return '_getCartInfos';
  }
}
