import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';

class RefundShopCard extends StatelessWidget {
  final String imagePath, content, specs;
  RefundShopCard({Key key, this.imagePath, this.content, this.specs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: Screenutil.length(32),
        left: Screenutil.length(32),
        bottom: Screenutil.length(32),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: Screenutil.length(179),
            width: Screenutil.length(173),
            fit: BoxFit.fill,
          ),
          SizedBox(width: Screenutil.length(24)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Screenutil.length(458),
                child: Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize28,
                    color: BaseStyle.color333333,
                  ),
                ),
              ),
              SizedBox(height: Screenutil.length(8)),
              Container(
                width: Screenutil.length(456),
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
