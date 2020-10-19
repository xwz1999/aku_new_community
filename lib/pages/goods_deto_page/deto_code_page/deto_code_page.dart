import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/dotted_line.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class DetoCodePage extends StatelessWidget {
  const DetoCodePage({Key key}) : super(key: key);

  Widget _header() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '宁波华茂悦峰',
            style: TextStyle(
                fontSize: Screenutil.size(40), color: Color(0xffffffff)),
          ),
          SizedBox(height: Screenutil.length(10)),
          Text(
            '1幢-1单元-702室',
            style: TextStyle(
                fontSize: Screenutil.size(26), color: Color(0xffffffff)),
          ),
        ],
      ),
    );
  }

  Widget _card() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(Screenutil.length(16))),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: Screenutil.length(75),
        vertical: Screenutil.length(32),
      ),
      padding: EdgeInsets.only(
        bottom: Screenutil.length(16),
        left: Screenutil.length(32),
        right: Screenutil.length(21),
        top: Screenutil.length(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    AntDesign.contacts,
                    size: Screenutil.size(40),
                    color: Color(0xff999999),
                  ),
                  SizedBox(width: Screenutil.length(10)),
                  Text(
                    '马成泽先生',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Screenutil.size(36),
                        color: Color(0xff333333)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Screenutil.length(13)),
          Text(
            '有限时间：2020年6月30日',
            style: TextStyle(
              fontSize: Screenutil.size(26),
              color: Color(0xff999999),
            ),
          ),
          SizedBox(height: Screenutil.length(23)),
          DottedLine(color: Color(0xfff5f5f5)),
          Container(
            padding: EdgeInsets.only(
              top: Screenutil.length(30),
              bottom: Screenutil.length(38),
            ),
            height: Screenutil.length(389),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  '020-598-230',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Screenutil.size(36),
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: Screenutil.length(11)),
                QrImage(
                  padding: EdgeInsets.zero,
                  data: '智慧社区开门码',
                  size: Screenutil.length(260),
                ),
              ],
            ),
          ),
          DottedLine(color: Color(0xfff5f5f5)),
          SizedBox(height: Screenutil.length(16)),
          Container(
            alignment: Alignment.center,
            child: Text(
              '出户时，请出示此证给门岗',
              style: TextStyle(
                fontSize: Screenutil.size(24),
                color: Color(0xff999999),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '出户二维码',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Color(0xff333333),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: Screenutil.length(192) - kToolbarHeight),
                _header(),
                SizedBox(height: Screenutil.length(32)),
                _card(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
