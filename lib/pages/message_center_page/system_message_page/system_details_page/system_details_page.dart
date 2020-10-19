import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
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
                top: Screenutil.length(42),
                left: Screenutil.length(34),
                right: Screenutil.length(44),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '系统通知',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Screenutil.size(32),
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: Screenutil.length(5)),
                  Text(
                    bundle.getMap('detailsMap')['type'],
                    style: TextStyle(
                      fontSize: Screenutil.size(28),
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: Screenutil.length(110)),
                  Text(
                    bundle.getMap('detailsMap')['content'],
                    style: TextStyle(
                      fontSize: Screenutil.size(28),
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
