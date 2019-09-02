import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeatilTabbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeatilTabbarState();
}

class _DeatilTabbarState extends State<DeatilTabbar>
    with SingleTickerProviderStateMixin {
  List<Tab> tabs = [
    Tab(
      text: '详情',
    ),
    Tab(
      text: '评论',
    )
  ];

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      color: Colors.white,
      width: ScreenUtil.getInstance().setWidth(750.0),
      height: ScreenUtil.getInstance().setHeight(250.0),
      child: Scaffold(
        appBar: TabBar(
          tabs: tabs,
          controller: tabController,
          indicatorColor: Colors.pink,
          labelColor: Colors.pink,
          unselectedLabelColor: Colors.black,
        ),
        body: TabBarView(
          children: [Text('1'), Text('2')],
          controller: tabController,
        ),
      ),
    );
  }
}
