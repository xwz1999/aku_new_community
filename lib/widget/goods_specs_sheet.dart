import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/utils/toast.dart';
import 'package:akuCommunity/widget/cart_count.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/provider/cart.dart';
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
        width: Screenutil.length(52),
        height: Screenutil.length(52),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: count > 1 ? Color(0xffffffff) : Colors.black12,
            border:
                Border(right: BorderSide(width: 0.5, color: Colors.black12))),
        child: Icon(
          Icons.remove,
          color: Color(0xff979797),
          size: Screenutil.size(38),
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
        width: Screenutil.length(52),
        height: Screenutil.length(52),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Icon(
          Icons.add,
          color: Color(0xff979797),
          size: Screenutil.size(38),
        ),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea() {
    return Container(
      width: Screenutil.length(52),
      height: Screenutil.length(52),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        '${count}',
        style: TextStyle(
          fontSize: Screenutil.size(24),
          color: Color(0xff333333),
        ),
      ),
    );
  }

  Widget _stackHeader(String image, price) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(Screenutil.length(32)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: Screenutil.length(20)),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Screenutil.length(4))),
                  child: CachedImageWrapper(
                    url: image,
                    height: Screenutil.length(180),
                    width: Screenutil.length(180),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '价格：￥${price}',
                    style: TextStyle(
                      color: Color(0xffe60e0e),
                      fontSize: Screenutil.size(28),
                    ),
                  ),
                  SizedBox(height: Screenutil.length(5)),
                  // Row(
                  //   children: [
                  //     Text(
                  //       '已选中:',
                  //       style: TextStyle(
                  //         color: Color(0xff333333),
                  //         fontSize: Screenutil.size(28),
                  //       ),
                  //     ),
                  //     SizedBox(width: Screenutil.length(10)),
                  //     Text(
                  //       '中蓝XS（170/80A）',
                  //       style: TextStyle(
                  //         color: Color(0xff333333),
                  //         fontSize: Screenutil.size(28),
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
              size: Screenutil.size(38),
              color: Color(0xff999999),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }

  Widget _paddingSelect(String title, List<Map<String, dynamic>> selectList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Screenutil.length(52)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: Screenutil.size(28),
            ),
          ),
          SizedBox(height: Screenutil.length(20)),
          Wrap(
            spacing: Screenutil.length(30),
            runSpacing: Screenutil.length(20),
            children: selectList
                .map((item) => InkWell(
                      onTap: () {
                        selectList.forEach((item) {
                          item['isSelect'] = false;
                        });
                        setState(() {
                          item['isSelect'] = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: item['isSelect']
                                ? Color(0xfffff8e4)
                                : Color(0xffffffff),
                            border: Border.all(
                                color: item['isSelect']
                                    ? Color(0xffffc40c)
                                    : Color(0xff979797),
                                width: 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        padding: EdgeInsets.symmetric(
                          horizontal: Screenutil.length(32),
                          vertical: Screenutil.length(15),
                        ),
                        child: Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: Screenutil.size(28),
                            color: Color(0xff333333),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _paddingNum() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Screenutil.length(52)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '数量',
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: Screenutil.length(28),
            ),
          ),
          SizedBox(height: Screenutil.length(20)),
          // CartCount(),
          Container(
            width: Screenutil.length(160),
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
        Navigator.of(context).pop();
        switch (type) {
          case '加入购物车':
            Toast.globalToast('已添加入购物车');
            model.save(widget.itemid, widget.itemtitle, count, widget.itemprice,
                widget.itempic);
            break;
          case '立即购买':
            Navigator.pushNamed(context, PageName.confirm_order_page.toString(),
                arguments: Bundle()
                  ..putMap('cartMap', {
                    'itemid': widget.itemid,
                    'itemtitle': widget.itemtitle,
                    'itemprice': widget.itemprice,
                    'itempic': widget.itempic,
                    'count': count
                  }));
            break;
          case '请选择规格':
            Toast.globalToast('已添加入购物车');
            break;
          default:
        }

        // Navigator.pushNamed(context, PageName.common_page.toString(),
        //     arguments: Bundle()
        //       ..putMap('commentMap', {'title': '确认订单', 'isActions': false}));
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
        margin: EdgeInsets.symmetric(horizontal: Screenutil.length(52)),
        padding: EdgeInsets.symmetric(vertical: Screenutil.length(20)),
        child: Text(
          '确认',
          style: TextStyle(
            fontSize: Screenutil.length(32),
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Screenutil.length(1334),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _stackHeader(widget.itempic, widget.itemprice),
            SizedBox(height: Screenutil.length(91)),
            // _paddingSelect('颜色', colorsList),
            // SizedBox(height: Screenutil.length(70)),
            // _paddingSelect('尺寸', sizesList),
            // SizedBox(height: Screenutil.length(50)),
            _paddingNum(),
            SizedBox(height: Screenutil.length(79)),
            Consumer<CartProvidde>(builder: (context, model, child) {
              return _inkwellSubmit(widget.type, model);
            }),
            SizedBox(height: Screenutil.length(79)),
          ],
        ),
      ),
    );
  }
}
