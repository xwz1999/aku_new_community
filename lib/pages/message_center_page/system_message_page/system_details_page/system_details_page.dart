import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class SystemDetailsPage extends StatelessWidget {
  final Bundle bundle;
  SystemDetailsPage({Key key, this.bundle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '查看详情',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 42.w,
                left: 34.w,
                right: 44.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '系统通知',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32.sp,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Text(
                    bundle.getMap('detailsMap')['type'],
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 110.w),
                  Text(
                    bundle.getMap('detailsMap')['content'],
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: Color(0xff333333),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
