import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class RecordItem extends StatefulWidget {
  final bool isQRCode;
  RecordItem({Key key, this.isQRCode}) : super(key: key);

  @override
  _RecordItemState createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  void recordPass() {
    Navigator.pushNamed(context, PageName.visitor_pass_page.toString());
  }

  Positioned _positionedAgain() {
    return Positioned(
      right: 0,
      top: Screenutil.length(16),
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius:
                  BorderRadius.all(Radius.circular(Screenutil.length(36))),
              border: Border.all(
                  color: Color(0xffffc500), width: Screenutil.length(3))),
          padding: EdgeInsets.symmetric(
            vertical: Screenutil.length(11),
            horizontal: Screenutil.length(32),
          ),
          child: Text(
            '再次邀请',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Screenutil.size(24),
              color: Color(0xff333333),
            ),
          ),
        ),
      ),
    );
  }

  Positioned _positionedQRcode() {
    return Positioned(
      right: 0,
      top: Screenutil.length(16),
      child: Row(
        children: [
          Icon(
            AntDesign.qrcode,
            size: Screenutil.size(40),
            color: Color(0xff999999),
          ),
          SizedBox(height: Screenutil.length(18)),
          Icon(
            AntDesign.right,
            size: Screenutil.size(40),
            color: Color(0xff999999),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: recordPass,
      child: Container(
        padding: EdgeInsets.only(
          top: Screenutil.length(32),
          left: Screenutil.length(32),
          right: Screenutil.length(32),
        ),
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '马成泽(浙A88888)',
                  style: TextStyle(
                    fontSize: Screenutil.size(32),
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: Screenutil.length(8)),
                Text(
                  '2020年6月30日',
                  style: TextStyle(
                    fontSize: Screenutil.size(24),
                    color: Color(0xff999999),
                  ),
                ),
                SizedBox(height: Screenutil.length(33)),
                Divider()
              ],
            ),
            widget.isQRCode ? _positionedQRcode() : _positionedAgain(),
          ],
        ),
      ),
    );
  }
}
