import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class ConfirmAddress extends StatefulWidget {
  ConfirmAddress({Key key}) : super(key: key);

  @override
  _ConfirmAddressState createState() => _ConfirmAddressState();
}

class _ConfirmAddressState extends State<ConfirmAddress> {
  Container _containerImage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Screenutil.length(12)),
      child: Image.asset(
        AssetsImage.LOCATION,
        height: Screenutil.length(54),
        width: Screenutil.length(54),
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
                  fontSize: Screenutil.size(28),
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(width: Screenutil.length(20)),
              Text(
                '18868945727',
                style: TextStyle(
                  fontSize: Screenutil.size(24),
                  color: Color(0xff999999),
                ),
              ),
            ],
          ),
          SizedBox(height: Screenutil.length(6)),
          Text(
            '浙江省 宁波市 江北区 工程学院阿库旅游f6',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: Screenutil.size(24),
              color: Color(0xff999999),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _positionedIcon() {
    return Positioned(
      bottom: Screenutil.length(58),
      right: 0,
      child: Icon(
        AntDesign.right,
        size: Screenutil.size(34),
        color: Color(0xff999999),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PageName.common_page.toString(),
            arguments: Bundle()
              ..putMap('commentMap', {'title': '我的地址', 'isActions': true}));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Screenutil.length(32)),
        padding: EdgeInsets.symmetric(horizontal: Screenutil.length(18)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Screenutil.length(18),
                vertical: Screenutil.length(32),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _containerImage(),
                  SizedBox(width: Screenutil.length(18)),
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
