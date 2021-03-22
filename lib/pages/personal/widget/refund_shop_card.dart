import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';

class RefundShopCard extends StatelessWidget {
  final String imagePath, content, specs;
  RefundShopCard({Key key, this.imagePath, this.content, this.specs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: 32.w,
        left: 32.w,
        bottom: 32.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: 179.w,
            width: 173.w,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 24.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 458.w,
                child: Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize28,
                    color: ktextPrimary,
                  ),
                ),
              ),
              SizedBox(height: 8.w),
              Container(
                width: 456.w,
                child: Text(
                  specs,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize28,
                    color: BaseStyle.color999999,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
