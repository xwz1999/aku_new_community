import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';

class HouseInfo extends StatefulWidget {
  final String title, subtitle;
  HouseInfo({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  _HouseInfoState createState() => _HouseInfoState();
}

class _HouseInfoState extends State<HouseInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 32.w,
      ),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetsImage.HOUSEATTESTATION,
            height: 48.w,
            width: 48.w,
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: BaseStyle.fontSize32,
                  color: BaseStyle.color474747,
                ),
              ),
              SizedBox(height: 10.w),
              Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: BaseStyle.fontSize32,
                  color: BaseStyle.color474747,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
