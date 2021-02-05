// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/model/manager/goods_out_model.dart';
import 'package:akuCommunity/utils/bee_map.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/views/horizontal_image_view.dart';
import 'goods_info_card_button.dart';

class GoodsInfoCard extends StatelessWidget {
  final GoodsOutModel model;
  GoodsInfoCard({
    Key key,
    this.model,
  }) : super(key: key);

  Widget _builTile(String title, String text) {
    return Container(
      // padding: EdgeInsets.only(top: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 28.sp, color: Color(0xff999999)),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
          ),
        ],
      ),
    );
  }

  Color _getColor(int state) {
    switch (state) {
      case 1:
      case 2:
      case 3:
        return kDarkPrimaryColor;
      case 4:
      case 5:
      case 6:
      case 7:
        return ktextSubColor;
      default:
        return kDangerColor;
    }
  }

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
                      Text(BeeMap.fixState[model.status],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28.sp,
                              color: _getColor(model.status))),
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
                  child: Column(children: [
                    _builTile('物品重量', BeeMap.goodsOutweight[model.weight]),
                    _builTile('出户时间', model.expectedTime),
                    _builTile('物品名称', model.name),
                    _builTile(
                        '搬运方式', BeeMap.goodsOutApproach[model.approach]),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 19.w,
                    bottom: 30.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 8.w),
                        child: Text(
                          '图片信息',
                          style: TextStyle(
                              fontSize: 28.sp, color: Color(0xff333333)),
                        ),
                      ),
                      HorizontalImageView(
                          model.imgUrl.map((e) => e.url).toList()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GoodsInfoCardButton(
            id: model.id,
            tel: model.movingCompanyTel,
          )
        ],
      ),
    );
  }
}
