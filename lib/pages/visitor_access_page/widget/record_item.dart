import 'package:akuCommunity/pages/visitor_access_page/visitor_pass_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';

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
    VisitorPassPage().to;
  }

  Positioned _positionedAgain() {
    return Positioned(
      right: 0,
      top: 16.w,
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.all(Radius.circular(36.w)),
              border: Border.all(color: Color(0xffffc500), width: 3.w)),
          padding: EdgeInsets.symmetric(
            vertical: 11.w,
            horizontal: 32.w,
          ),
          child: Text(
            '再次邀请',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24.sp,
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
      top: 16.w,
      child: Row(
        children: [
          Icon(
            AntDesign.qrcode,
            size: 40.sp,
            color: Color(0xff999999),
          ),
          SizedBox(height: 18.w),
          Icon(
            AntDesign.right,
            size: 40.sp,
            color: Color(0xff999999),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InkWell(
      onTap: recordPass,
      child: Container(
        padding: EdgeInsets.only(
          top: 32.w,
          left: 32.w,
          right: 32.w,
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
                    fontSize: 32.sp,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 8.w),
                Text(
                  '2020年6月30日',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Color(0xff999999),
                  ),
                ),
                SizedBox(height: 33.w),
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
