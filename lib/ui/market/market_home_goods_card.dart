import 'package:aku_new_community/ui/market/widget/goods_%20tag_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/models/market/order/goods_home_model.dart';
import 'package:aku_new_community/ui/market/search/good_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';

class MarketHomeGoodsCard extends StatelessWidget {
  final GoodsHomeModel item;
  final bool? border;

  const MarketHomeGoodsCard({Key? key, required this.item, this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      shape: !(border ?? false)
          ? null
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.w),
              side: BorderSide(color: Color(0xFFC4C4C4))),
      padding: EdgeInsets.zero,
      onPressed: () {
        Get.to(
          () => GoodDetailPage(goodId: item.id!),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
            ),
            child: Stack(
              children: [
                FadeInImage.assetNetwork(
                  placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  image: item.mainPhoto ?? '',
                  fit: BoxFit.fill,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(R.ASSETS_IMAGES_PLACEHOLDER_WEBP);
                  },
                ),
                // Positioned(
                //   left: 0,
                //   right: 0,
                //   bottom: 0,
                //   child: Container(
                //     height: 38.w,
                //     color: Colors.black54,
                //     alignment: Alignment.centerLeft,
                //     padding: EdgeInsets.symmetric(horizontal: 12.w),
                //     child: Text(
                //       item.skuName??'',
                //       overflow: TextOverflow.ellipsis,
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 18.sp,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 10.w,
            ),
            child: Text(
              item.skuName ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 28.sp, color: ktextPrimary),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 10.w,
              ),
              child: Container(
                child: GoodsTagWidget(type: item.kind??0),
              )),
          10.hb,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '¥',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 28.sp,
                    ),
                  ),
                  TextSpan(
                    text: '${item.sellPrice ?? ''} ',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '原价：',
                    style: TextStyle(
                      color: ktextSubColor,
                      fontSize: 20.sp,
                    ),
                  ),
                  TextSpan(
                    text: item.discountPrice == null
                        ? ''
                        : '¥${item.discountPrice ?? ''}',
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '折扣：',
                    style: TextStyle(
                      color: ktextSubColor,
                      fontSize: 20.sp,
                    ),
                  ),
                  TextSpan(
                    text: (item.discountPrice ?? 0) > (item.sellPrice ?? 0)
                        ? _getDiscount(
                            item.sellPrice ?? -1, item.discountPrice ?? -1)
                        : '暂无折扣',
                    style: TextStyle(
                      color: ktextSubColor,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getDiscount(double sellPrice, double discountPrice) {
    String count = '';
    count = ((sellPrice / discountPrice) * 10).toStringAsFixed(1);

    return count + '折';
  }

}
