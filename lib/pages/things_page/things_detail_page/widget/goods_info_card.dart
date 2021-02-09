// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'goods_info_card_button.dart';
import 'image_horizontal_list.dart';

class GoodsInfoCard extends StatelessWidget {
  final List<String> listImage;
  final String status, infodetails;
  final List<Map<String, dynamic>> detoInfoList;
  final bool isShow;
  GoodsInfoCard(
      {Key key,
      this.listImage,
      this.status,
      this.detoInfoList,
      this.isShow,
      this.infodetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 32.w,
        left: 32.w,
        right: 32.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            padding: EdgeInsets.only(top: 25.w, left: 24.w, right: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 24.w),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xffeeeeee), width: 0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '出户信息',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 32.sp,
                            color: Color(0xff333333)),
                      ),
                      Text(status,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28.sp,
                              color: Color(0xff333333))),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: 33.w,
                    top: 16.w,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xffeeeeee), width: 0.5)),
                  ),
                  child: infodetails != null
                      ? Container(
                          width: 630.w,
                          child: Text(
                            infodetails,
                            style: TextStyle(
                                fontSize: 28.sp, color: Color(0xff333333)),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: detoInfoList
                              .map(
                                (item) => Container(
                                  padding: EdgeInsets.only(top: 8.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['title'],
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Color(0xff999999)),
                                      ),
                                      Text(
                                        item['content'],
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Color(0xff333333)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
                listImage != null
                    ? Container(
                        margin: EdgeInsets.only(
                          top: 19.w,
                          bottom: 30.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 25.w),
                              child: Text(
                                '图片信息',
                                style: TextStyle(
                                    fontSize: 28.sp, color: Color(0xff333333)),
                              ),
                            ),
                            ImageHorizontalList(imageUrl: listImage),
                          ],
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          isShow ? GoodsInfoCardButton() : SizedBox()
        ],
      ),
    );
  }
}
