import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/detail.dart';

class DeatilTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailGoodProvide>(
      builder: (context, child, value) {
        bool isLeft = value.isLeft;
        return Row(
          children: <Widget>[
            _getTabItem(context, isLeft, '详情', true),
            _getTabItem(context, !isLeft, '评论', false)
          ],
        );
      },
    );
  }

  Widget _getTabItem(
      BuildContext context, bool isSelected, String tabTitle, bool isLeft) {
    return InkWell(
      onTap: () {
        var value = Provide.value<DetailGoodProvide>(context);
        if (isLeft) {
          if (!value.isLeft) {
            value.leftToggle();
          }
        } else {
          if (value.isLeft) {
            value.leftToggle();
          }
        }
      },
      child: Container(
        width: ScreenUtil.getInstance().setWidth(375.0),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: isSelected ? Colors.pink : Colors.white,
                    width: 1.0))),
        child: Text(
          tabTitle,
          style: TextStyle(color: isSelected ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}
