import 'package:akuCommunity/pages/industry_committee/committee_mailbox/committee_mailbox_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'widget/staff_list.dart';

class IndustryCommitteePage extends StatefulWidget {
  IndustryCommitteePage({Key key}) : super(key: key);

  @override
  _IndustryCommitteePageState createState() => _IndustryCommitteePageState();
}

class _IndustryCommitteePageState extends State<IndustryCommitteePage> {
  List<Map<String, dynamic>> _listBottom = [
    {
      'title': '业委会电话',
      'color': Color(0xff2a2a2a),
      'fontColor': Color(0xffffffff),
    },
    {
      'title': '业委会信箱',
      'color': Color(0xffffc40c),
      'fontColor': Color(0xff333333),
    },
  ];
  Future<void> _phoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            '0574-88478909',
            style: TextStyle(
              fontSize: 34.sp,
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: 34.sp,
                  color: Color(0xff333333),
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '呼叫',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 34.sp,
                  color: Color(0xffff8200),
                ),
              ),
              onPressed: () {
                _phoneCall('tel:${'0574-88478909'}');
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  InkWell _inkWellBotoom(String title, Color color, Color fontColor) {
    return InkWell(
      onTap: () {
        switch (title) {
          case '业委会电话':
            _showDialog();
            break;
          case '业委会信箱':
            CommitteeMailboxPage().to;
            break;
          default:
        }
      },
      child: Container(
        color: color,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: 26.5.w,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 32.sp,
            color: fontColor,
          ),
        ),
      ),
    );
  }

  Positioned _positionedBottomBar() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 98.w + MediaQuery.of(context).viewPadding.bottom,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: _listBottom
              .map((item) => Expanded(
                    child: _inkWellBotoom(
                      item['title'],
                      item['color'],
                      item['fontColor'],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '业委会',
      body: Stack(
        children: [
          StaffList(),
          _positionedBottomBar(),
        ],
      ),
    );
  }
}
