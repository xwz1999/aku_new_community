import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/models/search/search_goods_model.dart';
import 'package:aku_new_community/ui/market/search/good_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'collection/collection_func.dart';

class SearchGoodsCard extends StatefulWidget {
  final SearchGoodsModel item;
  final EasyRefreshController? refreshController;

  const SearchGoodsCard({
    Key? key,
    required this.item,
    this.refreshController,
  }) : super(key: key);

  @override
  _SearchGoodsCardState createState() => _SearchGoodsCardState();
}

class _SearchGoodsCardState extends State<SearchGoodsCard> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.w),
      ),
      padding: EdgeInsets.zero,
      onPressed: () {
        Get.to(
          () => GoodDetailPage(goodId: widget.item.id!),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24.w)),
            ),
            child: Stack(
              children: [
                FadeInImage.assetNetwork(
                  placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  image: widget.item.mainPhoto ?? '',
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
              widget.item.skuName ?? '',
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
                child: _getIcon(widget.item.kind ?? 0),
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
                    text: '${widget.item.sellPrice ?? ''} ',
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
          Row(
            children: [
              Column(
                children: [
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
                            text: widget.item.discountPrice == null
                                ? ''
                                : '¥${widget.item.discountPrice ?? ''}',
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
                            text: (widget.item.discountPrice ?? 0) >
                                    (widget.item.sellPrice ?? 0)
                                ? _getDiscount(widget.item.sellPrice ?? -1,
                                    widget.item.discountPrice ?? -1)
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
              Spacer(),
              GestureDetector(
                onTap: () async {
                  await CollectionFunc.collection(widget.item.id!);

                  if (widget.refreshController != null) {
                    widget.refreshController!.callRefresh();
                  }
                },
                child: (widget.item.isCollection ?? 0) != 0
                    ? Image.asset(
                        R.ASSETS_ICONS_SHOP_FAVORFILL_PNG,
                        width: 42.w,
                        height: 42.w,
                      )
                    : Image.asset(
                        R.ASSETS_ICONS_ICON_FAVOR_CHOOSE_PNG,
                        width: 42.w,
                        height: 42.w,
                      ),
              ),
              20.wb,
            ],
          ),
          20.hb,
        ],
      ),
    );
  }

  _getDiscount(double sellPrice, double discountPrice) {
    String count = '';
    count = ((sellPrice / discountPrice) * 10).toStringAsFixed(1);

    return count + '折';
  }

  Widget _getIcon(int type) {
    if (type == 1) {
      return Container(
        width: 86.w,
        height: 26.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4.w),
          ),
          gradient: LinearGradient(
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            colors: <Color>[Color(0xFFEC5329), Color(0xFFF58123)],
          ),
        ),
        child: Text(
          '京东自营',
          style: TextStyle(fontSize: 18.sp, color: kForeGroundColor),
        ),
      );
    } else if (type == 2) {
      return Container(
        alignment: Alignment.center,
        width: 86.w,
        height: 30.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4.w),
          ),
          gradient: LinearGradient(
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            colors: <Color>[Color(0xFFF59B1C), Color(0xFFF5AF16)],
          ),
        ),
        child: Text(
          '京东POP',
          style: TextStyle(fontSize: 18.sp, color: kForeGroundColor),
        ),
      );
    } else
      return SizedBox();
  }
}
