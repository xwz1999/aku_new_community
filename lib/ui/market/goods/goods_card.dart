import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/models/market/goods_item.dart';
import 'package:aku_community/ui/market/goods/goods_detail_page.dart';
import 'package:aku_community/utils/headers.dart';

class GoodsCard extends StatelessWidget {
  final GoodsItem item;
  const GoodsCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      padding: EdgeInsets.zero,
      onPressed: () => Get.to(
        () => GoodsDetailPage(id: item.id),
        preventDuplicates: false,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                FadeInImage.assetNetwork(
                    placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                    image: API.image(ImgModel.first(item.imgList))),
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
                      item.recommend,
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
              item.title,
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
                    text: '¥${item.sellingPrice} ',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 28.sp,
                    ),
                  ),
                  TextSpan(
                    text: '${item.markingPrice}',
                    style: TextStyle(
                      color: ktextSubColor,
                      fontSize: 20.sp,
                      decoration: TextDecoration.lineThrough,
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
