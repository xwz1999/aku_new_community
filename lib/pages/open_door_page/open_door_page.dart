import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class OpenDoorPage extends StatefulWidget {
  OpenDoorPage({Key key}) : super(key: key);

  @override
  _OpenDoorPageState createState() => _OpenDoorPageState();
}

class _OpenDoorPageState extends State<OpenDoorPage> {
  void _showDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            '实名认证',
            style: TextStyle(
              fontSize: Screenutil.size(34),
              color: Color(0xff030303),
            ),
          ),
          content: Text(
            '\n为了小区的安全，需要先进行实名认证',
            style: TextStyle(
              fontSize: Screenutil.size(28),
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '考虑考虑',
                style: TextStyle(
                  fontSize: Screenutil.size(34),
                  color: Color(0xff333333),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '前去认证',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Screenutil.size(34),
                  color: Color(0xffff8200),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(
                    context, PageName.certification_page.toString());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '一键开门',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: Screenutil.length(220)),
              child: Column(
                children: [
                  InkWell(
                    onTap: _showDialog,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: Screenutil.length(400),
                          height: Screenutil.length(420),
                          child: Image.asset(
                            'assets/images/open_door.png',
                            width: Screenutil.length(400),
                            height: Screenutil.length(420),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: Screenutil.length(120),
                          left: Screenutil.length(137.5),
                          child: Image.asset(
                            'assets/images/lock.png',
                            width: Screenutil.length(125),
                            height: Screenutil.length(150),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Screenutil.length(40)),
                    child: Text(
                      '未检测到相关设备',
                      style: TextStyle(
                        fontSize: Screenutil.length(44),
                        color: Color(0xff999999),
                        fontWeight: FontWeight.w600,
                      ),
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
