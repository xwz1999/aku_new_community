import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'image_horizontal_list.dart';
import 'goods_info_card_button.dart';

class GoodsInfoCard extends StatelessWidget {
  final List<String> listImage;
  final String status;
  final List<Map<String, dynamic>> detoInfoList;
  GoodsInfoCard({Key key,this.listImage,this.status,this.detoInfoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Screenutil.length(32),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
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
            padding: EdgeInsets.only(
                top: Screenutil.length(25),
                left: Screenutil.length(24),
                right: Screenutil.length(24)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: Screenutil.length(24)),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color(0xffeeeeee), width: 0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '出户信息',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Screenutil.size(32),
                            color: Color(0xff333333)),
                      ),
                      Text(
                        status,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Screenutil.size(28),
                            color: Color(0xff333333))
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: Screenutil.length(33),
                    top: Screenutil.length(16),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color(0xffeeeeee), width: 0.5)),
                  ),
                  child: Column(
                    children: detoInfoList
                        .map(
                          (item) => Container(
                            padding: EdgeInsets.only(top: Screenutil.length(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['title'],
                                  style: TextStyle(
                                      fontSize: Screenutil.size(28),
                                      color: Color(0xff999999)),
                                ),
                                Text(
                                  item['content'],
                                  style: TextStyle(
                                      fontSize: Screenutil.size(28),
                                      color: Color(0xff333333)),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: Screenutil.length(19),
                    bottom: Screenutil.length(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: Screenutil.length(25)),
                        child: Text(
                          '图片信息',
                          style: TextStyle(
                              fontSize: Screenutil.size(28),
                              color: Color(0xff333333)),
                        ),
                      ),
                      ImageHorizontalList(imageUrl: listImage),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GoodsInfoCardButton()
        ],
      ),
    );
  }
}