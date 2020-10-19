import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:akuCommunity/utils/screenutil.dart';
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
                top: Screenutil.length(70),
                left: Screenutil.length(32),
                right: Screenutil.length(32),
                bottom: Screenutil.length(76),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Screenutil.length(20),
                vertical: Screenutil.length(32),
              ),
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius:
                    BorderRadius.all(Radius.circular(Screenutil.length(8))),
              ),
              height: Screenutil.length(746),
              width: Screenutil.length(686),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: Screenutil.length(44),
                      bottom: Screenutil.length(32),
                    ),
                    height: Screenutil.length(460),
                    width: Screenutil.length(460),
                    child: QrImage(
                      padding: EdgeInsets.zero,
                      data: '智慧社区开门码',
                      size: Screenutil.length(460),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Screenutil.length(29),
                      vertical: Screenutil.length(33),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfffffbf6),
                      borderRadius: BorderRadius.all(
                          Radius.circular(Screenutil.length(8))),
                    ),
                    width: Screenutil.length(646),
                    height: Screenutil.length(146),
                    child: Text(
                      '扫一扫，你的专属二维码，人人文明出行，路路畅通安宁，智慧社区祝您一路顺风',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: Screenutil.size(28),
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
                    size: Screenutil.size(32),
                  ),
                  SizedBox(width: Screenutil.length(19)),
                  Text(
                    '已刷新',
                    style: TextStyle(
                      fontSize: Screenutil.size(32),
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
