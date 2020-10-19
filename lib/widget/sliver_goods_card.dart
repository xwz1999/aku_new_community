import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/model/aku_shop_model.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class SliverGoodsCard extends StatelessWidget {
  final bool isShow;
  final List<AkuShopModel> shoplist;
  const SliverGoodsCard({Key key, this.isShow = false, this.shoplist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Row _rowTag() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Screenutil.length(16),
                vertical: Screenutil.length(8),
              ),
              color: Color(0xff000000).withOpacity(0.6),
              child: Text(
                '剩余时间:09天13时46分',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(0xffffffff), fontSize: Screenutil.size(20)),
              ),
            ),
          ),
        ],
      );
    }

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                  context, PageName.goods_details_page.toString(),
                  arguments: Bundle()
                    ..putString(
                        'shoplist', json.encode(shoplist[index]).toString()));
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
                          width: Screenutil.length(333),
                          height: Screenutil.length(344),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Screenutil.length(12),
                      right: Screenutil.length(25),
                      top: Screenutil.length(20),
                    ),
                    child: Container(
                      width: Screenutil.length(296),
                      child: Text(
                        shoplist[index].itemtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Screenutil.size(24),
                          color: Color(0xff4a4b51),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: Screenutil.length(20),
                      left: Screenutil.length(12),
                      right: Screenutil.length(8),
                      bottom: Screenutil.length(17),
                    ),
                    child: Row(
                      mainAxisAlignment: isShow
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: Screenutil.length(8)),
                          child: Text(
                            '￥${shoplist[index].itemprice}',
                            style: TextStyle(
                              color: Color(0xffe60e0e),
                              fontSize: Screenutil.size(28),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        isShow
                            ? Text(
                                '${shoplist[index].itemsale}人已付款',
                                style: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: Screenutil.length(20),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      PageName.goods_details_page.toString(),
                                      arguments: Bundle()
                                        ..putString(
                                            'shoplist',
                                            json
                                                .encode(shoplist[index])
                                                .toString()));
                                },
                                child: Container(
                                  width: Screenutil.length(134),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                    top: Screenutil.length(6),
                                    bottom: Screenutil.length(5),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffffc40c),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Screenutil.length(20))),
                                  ),
                                  child: Text(
                                    '立即购买',
                                    style: TextStyle(
                                      fontSize: Screenutil.size(24),
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
          mainAxisSpacing: Screenutil.length(30),
          crossAxisSpacing: Screenutil.length(20),
          childAspectRatio: Screenutil.length(343) / Screenutil.length(539)),
    );
  }
}
