import 'package:flutter/material.dart';
import 'home_page.dart';
import 'catogery_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/current_page.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
    BottomNavigationBarItem(icon: Icon(Icons.category), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), title: Text("购物车")),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("会员中心")),
  ];

  final List<Widget> pages = [
    HomePage(),
    CatogeryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(height: 1334, width: 750)..init(context);
    print('Device width:${ScreenUtil.screenWidth}'); //Device width
    print('Device height:${ScreenUtil.screenHeight}'); //Device height
    print(
        'Device pixel density:${ScreenUtil.pixelRatio}'); //Device pixel density
    return Provide<CurrentPage>(
      builder: (context, child, values) {
        return Scaffold(
          body: IndexedStack(
            index: values.currentIndex,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomItems,
            type: BottomNavigationBarType.fixed,
            currentIndex: values.currentIndex,
            onTap: (index) {
              Provide.value<CurrentPage>(context).changePages(index);
            },
          ),
        );
      },
    );
  }
}
