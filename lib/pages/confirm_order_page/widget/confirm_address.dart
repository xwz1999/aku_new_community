// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_icons/flutter_icons.dart';

// Project imports:
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/utils/headers.dart';

class ConfirmAddress extends StatefulWidget {
  ConfirmAddress({Key key}) : super(key: key);

  @override
  _ConfirmAddressState createState() => _ConfirmAddressState();
}

class _ConfirmAddressState extends State<ConfirmAddress> {
  Container _containerImage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: Image.asset(
        AssetsImage.LOCATION,
        height: 54.w,
        width: 54.w,
      ),
    );
  }

  Container _containerContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '周玲慧',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(width: 20.w),
              Text(
                '18868945727',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Color(0xff999999),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.w),
          Text(
            '浙江省 宁波市 江北区 工程学院阿库旅游f6',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xff999999),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _positionedIcon() {
    return Positioned(
      bottom: 58.w,
      right: 0,
      child: Icon(
        AntDesign.right,
        size: 34.sp,
        color: Color(0xff999999),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(CommonPage(
        //   bundle: Bundle()
        //     ..putMap('commentMap', {'title': '我的地址', 'isActions': true}),
        // ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32.w),
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 32.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _containerImage(),
                  SizedBox(width: 18.w),
                  _containerContent(),
                ],
              ),
            ),
            _positionedIcon()
          ],
        ),
      ),
    );
  }
}
