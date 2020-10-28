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
      margin: EdgeInsets.only(top: 30.w),
      padding: EdgeInsets.only(
        top: 20.w,
        left: 32.w,
        right: 32.w,
        bottom: 32.w,
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
          SizedBox(height: 12.w),
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
