// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/model/aku_shop_model.dart';
import 'package:akuCommunity/pages/goods_details/goods_details_page.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class SliverGoodsCard extends StatelessWidget {
  final bool isShow;
  final List<AkuShopModel> shoplist;
  const SliverGoodsCard({Key key, this.isShow = false, this.shoplist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              GoodsDetailsPage(
                bundle: Bundle()
                  ..putString(
                      'shoplist', json.encode(shoplist[index]).toString()),
              ).to;
            },
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        child: CachedImageWrapper(
                          url: shoplist[index].itempic,
                          width: 333.w,
                          height: 344.w,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12.w,
                      right: 25.w,
                      top: 20.w,
                    ),
                    child: Container(
                      width: 296.w,
                      child: Text(
                        shoplist[index].itemtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Color(0xff4a4b51),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20.w,
                      left: 12.w,
                      right: 8.w,
                      bottom: 17.w,
                    ),
                    child: Row(
                      mainAxisAlignment: isShow
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8.w),
                          child: Text(
                            '￥${shoplist[index].itemprice}',
                            style: TextStyle(
                              color: Color(0xffe60e0e),
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        isShow
                            ? Text(
                                '${shoplist[index].itemsale}人已付款',
                                style: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: 20.w,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  GoodsDetailsPage(
                                    bundle: Bundle()
                                      ..putString(
                                          'shoplist',
                                          json
                                              .encode(shoplist[index])
                                              .toString()),
                                  ).to;
                                },
                                child: Container(
                                  width: 134.w,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                    top: 6.w,
                                    bottom: 5.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffffc40c),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.w)),
                                  ),
                                  child: Text(
                                    '立即购买',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      color: Color(0xff333333),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: shoplist.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 30.w,
          crossAxisSpacing: 20.w,
          childAspectRatio: 343.w / 539.w),
    );
  }
}
