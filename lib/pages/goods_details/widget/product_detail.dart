import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class ProductDetail extends StatelessWidget {
  final String picDesc;
  ProductDetail({Key key, this.picDesc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      margin: EdgeInsets.only(top: Screenutil.length(30)),
      padding: EdgeInsets.only(
        top: Screenutil.length(20),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
        bottom: Screenutil.length(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '商品详情',
            style: TextStyle(
              fontSize: BaseStyle.fontSize30,
              color: Color(0xff333333),
            ),
          ),
          SizedBox(height: Screenutil.length(12)),
          Container(
            child: AspectRatio(
              aspectRatio: 1,
              child: CachedImageWrapper(
                url: picDesc.contains('http')
                    ? picDesc
                    : 'http://img-haodanku-com.cdn.fudaiapp.com/' + picDesc,
                width: 1,
                height: 1,
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Container(
          //   child: Image.asset(
          //     picDesc,
          //     fit: BoxFit.fill,
          //   ),
          // ),
        ],
      ),
    );
  }
}
