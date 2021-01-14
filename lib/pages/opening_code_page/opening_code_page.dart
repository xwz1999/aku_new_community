import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class OpeningCodePage extends StatefulWidget {
  OpeningCodePage({Key key}) : super(key: key);

  @override
  _OpeningCodePageState createState() => _OpeningCodePageState();
}

class _OpeningCodePageState extends State<OpeningCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '开门码',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Color(0xfff9f9f9),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 70.w,
                left: 32.w,
                right: 32.w,
                bottom: 76.w,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 32.w,
              ),
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius:
                    BorderRadius.all(Radius.circular(8.w)),
              ),
              height: 746.w,
              width: 686.w,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 44.w,
                      bottom: 32.w,
                    ),
                    height: 460.w,
                    width: 460.w,
                    child: QrImage(
                      padding: EdgeInsets.zero,
                      data: '智慧社区开门码',
                      size: 460.w,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 29.w,
                      vertical: 33.w,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfffffbf6),
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.w)),
                    ),
                    width: 646.w,
                    height: 146.w,
                    child: Text(
                      '扫一扫，你的专属二维码，人人文明出行，路路畅通安宁，智慧社区祝您一路顺风',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: Color(0xff666666),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    AntDesign.checkcircleo,
                    color: Color(0xffffc40c),
                    size: 32.sp,
                  ),
                  SizedBox(width: 19.w),
                  Text(
                    '已刷新',
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: Color(0xff999999),
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
