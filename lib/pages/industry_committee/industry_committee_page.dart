import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/routers/page_routers.dart';
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
              fontSize: Screenutil.size(34),
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '取消',
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
                '呼叫',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Screenutil.size(34),
                  color: Color(0xffff8200),
                ),
              ),
              onPressed: () {
                _phoneCall('tel:${'0574-88478909'}');
                Navigator.pop(context);
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
            Navigator.pushNamed(
                context, PageName.committee_mailbox_page.toString());
            break;
          default:
        }
      },
      child: Container(
        color: color,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: Screenutil.length(26.5),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: Screenutil.size(32),
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
        height:
            Screenutil.length(98) + MediaQuery.of(context).viewPadding.bottom,
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
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '业委会',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Stack(
        children: [
          StaffList(),
          _positionedBottomBar(),
        ],
      ),
    );
  }
}
