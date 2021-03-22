// Flutter imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:akuCommunity/pages/confirm_order_page/confirm_order_page.dart';
import 'package:akuCommunity/provider/cart.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'cached_image_wrapper.dart';

class GoodsSpecsSheet extends StatefulWidget {
  final String itemid, itemtitle, itemprice, itempic, type;
  GoodsSpecsSheet(
      {Key key,
      this.itemid,
      this.itemtitle,
      this.itemprice,
      this.itempic,
      this.type})
      : super(key: key);

  @override
  _GoodsSpecsSheetState createState() => _GoodsSpecsSheetState();
}

class _GoodsSpecsSheetState extends State<GoodsSpecsSheet> {
  int count = 1;
  List<Map<String, dynamic>> colorsList = [
    {'title': "深蓝", 'isSelect': false},
    {'title': "浅蓝", 'isSelect': false},
    {'title': "褐色", 'isSelect': false},
    {'title': "黑色", 'isSelect': false},
  ];

  List<Map<String, dynamic>> sizesList = [
    {'title': "XS(170/80A)", 'isSelect': false},
    {'title': "S(175/80A)", 'isSelect': false},
    {'title': "XL(180/80A)", 'isSelect': false},
    {'title': "XXL(185/80A)", 'isSelect': false},
    {'title': "XXXL(190/80A)", 'isSelect': false},
  ];
  //减按钮
  Widget _reduceBtn() {
    return InkWell(
      onTap: count > 1
          ? () {
              setState(() {
                count--;
              });
            }
          : null,
      child: Container(
        width: 52.w,
        height: 52.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: count > 1 ? Color(0xffffffff) : Colors.black12,
            border:
                Border(right: BorderSide(width: 0.5, color: Colors.black12))),
        child: Icon(
          Icons.remove,
          color: Color(0xff979797),
          size: 38.sp,
        ),
      ),
    );
  }

  //加按钮
  Widget _addBtn() {
    return InkWell(
      onTap: () {
        setState(() {
          count++;
        });
      },
      child: Container(
        width: 52.w,
        height: 52.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Icon(
          Icons.add,
          color: Color(0xff979797),
          size: 38.sp,
        ),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea() {
    return Container(
      width: 52.w,
      height: 52.w,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        '$count',
        style: TextStyle(
          fontSize: 24.sp,
          color: Color(0xff333333),
        ),
      ),
    );
  }

  Widget _stackHeader(String image, price) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(32.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4.w)),
                  child: CachedImageWrapper(
                    url: image,
                    height: 180.w,
                    width: 180.w,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '价格：￥$price',
                    style: TextStyle(
                      color: Color(0xffe60e0e),
                      fontSize: 28.sp,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  // Row(
                  //   children: [
                  //     Text(
                  //       '已选中:',
                  //       style: TextStyle(
                  //         color: Color(0xff333333),
                  //         fontSize: 28.sp,
                  //       ),
                  //     ),
                  //     SizedBox(width: 10.w),
                  //     Text(
                  //       '中蓝XS（170/80A）',
                  //       style: TextStyle(
                  //         color: Color(0xff333333),
                  //         fontSize: 28.sp,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Icon(
              AntDesign.close,
              size: 38.sp,
              color: Color(0xff999999),
            ),
            onPressed: () => Get.back(),
          ),
        ),
      ],
    );
  }

  // Widget _paddingSelect(String title, List<Map<String, dynamic>> selectList) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 52.w),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           title,
  //           style: TextStyle(
  //             color: Color(0xff333333),
  //             fontSize: 28.sp,
  //           ),
  //         ),
  //         SizedBox(height: 20.w),
  //         Wrap(
  //           spacing: 30.w,
  //           runSpacing: 20.w,
  //           children: selectList
  //               .map((item) => InkWell(
  //                     onTap: () {
  //                       selectList.forEach((item) {
  //                         item['isSelect'] = false;
  //                       });
  //                       setState(() {
  //                         item['isSelect'] = true;
  //                       });
  //                     },
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                           color: item['isSelect']
  //                               ? Color(0xfffff8e4)
  //                               : Color(0xffffffff),
  //                           border: Border.all(
  //                               color: item['isSelect']
  //                                   ? Color(0xffffc40c)
  //                                   : Color(0xff979797),
  //                               width: 0.5),
  //                           borderRadius: BorderRadius.all(Radius.circular(4))),
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: 32.w,
  //                         vertical: 15.w,
  //                       ),
  //                       child: Text(
  //                         item['title'],
  //                         style: TextStyle(
  //                           fontSize: 28.sp,
  //                           color: Color(0xff333333),
  //                         ),
  //                       ),
  //                     ),
  //                   ))
  //               .toList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _paddingNum() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 52.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '数量',
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 28.w,
            ),
          ),
          SizedBox(height: 20.w),
          // CartCount(),
          Container(
            width: 160.w,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 0.5, color: Colors.black12) //设置所有的边框宽度为1 颜色为浅灰
                ),
            child: Row(
              children: <Widget>[
                _reduceBtn(),
                _countArea(),
                _addBtn(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _inkwellSubmit(String type, CartProvidde model) {
    return InkWell(
      onTap: () {
        Get.back();
        switch (type) {
          case '加入购物车':
            BotToast.showText(text: '已添加入购物车');
            model.save(widget.itemid, widget.itemtitle, count, widget.itemprice,
                widget.itempic);
            break;
          case '立即购买':
            ConfirmOrderPage(
              bundle: Bundle()
                ..putMap('cartMap', {
                  'itemid': widget.itemid,
                  'itemtitle': widget.itemtitle,
                  'itemprice': widget.itemprice,
                  'itempic': widget.itempic,
                  'count': count
                }),
            ).to;
            break;
          case '请选择规格':
            BotToast.showText(text: '已添加入购物车');
            break;
          default:
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffffc40c),
          borderRadius: BorderRadius.all(Radius.circular(1)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xffffc40c),
              offset: Offset(1, 1),
            ),
          ],
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 52.w),
        padding: EdgeInsets.symmetric(vertical: 20.w),
        child: Text(
          '确认',
          style: TextStyle(
            fontSize: 32.w,
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 1334.w,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _stackHeader(widget.itempic, widget.itemprice),
            SizedBox(height: 91.w),
            // _paddingSelect('颜色', colorsList),
            // SizedBox(height: 70.w),
            // _paddingSelect('尺寸', sizesList),
            // SizedBox(height: 50.w),
            _paddingNum(),
            SizedBox(height: 79.w),
            Consumer<CartProvidde>(builder: (context, model, child) {
              return _inkwellSubmit(widget.type, model);
            }),
            SizedBox(height: 79.w),
          ],
        ),
      ),
    );
  }
}
