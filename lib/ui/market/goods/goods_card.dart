import 'package:aku_community/ui/market/goods/goods_detail_page.dart';
import 'package:flutter/material.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:get/get.dart';

class GoodsCard extends StatelessWidget {
  const GoodsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      padding: EdgeInsets.zero,
      onPressed: () => Get.to(() => GoodsDetailPage()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Image.asset(
                  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 38.w,
                    color: Colors.black54,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      '分别是紫色烦恼则妇女色泽封闭周四鹅u部分紫色部分',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 20.w,
            ),
            child: Text(
              '袁隆平水稻大米精选 56kg唇齿流香 无常有机稻花 无常有机稻花',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '¥123.45 ',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 28.sp,
                    ),
                  ),
                  TextSpan(
                    text: '123已付款',
                    style: TextStyle(
                      color: ktextSubColor,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          16.hb,
        ],
      ),
    );
  }
}
