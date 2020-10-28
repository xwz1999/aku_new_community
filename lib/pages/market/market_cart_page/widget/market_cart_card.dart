import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';
import 'package:akuCommunity/widget/cart_count.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/goods_specs_sheet.dart';
import 'package:akuCommunity/model/aku_shop_model.dart';
import 'package:provider/provider.dart';
import 'package:akuCommunity/provider/cart.dart';

class MarketCartCard extends StatelessWidget {
  final AkuShopModel cartItem;
  MarketCartCard({Key key, this.cartItem}) : super(key: key);

  void _showGoodsSpecsSheet() {
    // showModalBottomSheet(
    //   isScrollControlled: true,
    //   context: context,
    //   backgroundColor: Colors.white,
    //   builder: (context) {
    //     return GoodsSpecsSheet(
    //       goodsNum: widget.goodsNum,
    //       index: widget.index,
    //       reduce: widget.reduce,
    //       add: widget.add,
    //     );
    //   },
    // );
  }

  Widget _cardRadio(
      BuildContext context, AkuShopModel cartItem, CartProvidde model) {
    return InkWell(
      onTap: () {
        cartItem.isCheck = !cartItem.isCheck;
        model.changeCheckState(cartItem);
      },
      child: Container(
        alignment: Alignment.center,
        child: Icon(
          Icons.check_circle,
          color: cartItem.isCheck ? Color(0xffdb0000) : Color(0xff999999),
          size: 36.w,
        ),
      ),
    );
  }

  Widget _image(String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        child: CachedImageWrapper(
          url: imagePath,
          width: 180.w,
          height: 180.w,
        ),
      ),
    );
  }

  Widget _content(String content, specs, price) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 394.w,
            child: Text(
              content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24.sp,
                color: Color(0xff333333),
              ),
            ),
          ),
          // InkWell(
          //   onTap: _showGoodsSpecsSheet,
          //   child: Container(
          //     margin: EdgeInsets.only(top: 10.w),
          //     padding: EdgeInsets.symmetric(
          //       vertical: 5.w,
          //       horizontal: 19.w,
          //     ),
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       color: Color(0xfff5f5f5),
          //       border: Border.all(color: Color(0xffd3d3d3), width: 0.5),
          //       borderRadius: BorderRadius.all(Radius.circular(15)),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text(
          //           specs,
          //           style: TextStyle(
          //             fontSize: 18.sp,
          //             color: Color(0xff333333),
          //           ),
          //         ),
          //         Container(
          //           alignment: Alignment.center,
          //           margin: EdgeInsets.only(left: 16.w),
          //           child: Icon(
          //             AntDesign.down,
          //             color: Color(0xff333333),
          //             size: 22.sp,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 40.w),
            child: Text(
              '￥${price}',
              style: TextStyle(
                fontSize: 28.sp,
                color: Color(0xffe60e0e),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvidde>(builder: (context, model, child) {
      return Container(
        margin: EdgeInsets.only(
          top: 20.w,
          left: 32.w,
          right: 32.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Slidable.builder(
          actionPane: SlidableBehindActionPane(),
          actionExtentRatio: 0.25,
          secondaryActionDelegate: SlideActionBuilderDelegate(
            actionCount: 2,
            builder: (context, index, animation, renderingMode) {
              if (index == 0) {
                return SlideAction(
                  child: Text(
                    '移至收藏夹',
                    style: TextStyle(
                        fontSize: 28.sp, color: Colors.white),
                  ),
                  color: renderingMode == SlidableRenderingMode.slide
                      ? Color(0xffffc40c).withOpacity(animation.value)
                      : Color(0xffffc40c),
                  // onTap: () => _showSnackBar(context, 'More'),
                  closeOnTap: false,
                );
              } else {
                return SlideAction(
                  onTap: () {
                    model.deleteGoods(cartItem.itemid);
                  },
                  decoration: BoxDecoration(
                    color: renderingMode == SlidableRenderingMode.slide
                        ? Color(0xffe60e0e).withOpacity(animation.value)
                        : Color(0xffe60e0e),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: Text(
                    '删除',
                    style: TextStyle(
                        fontSize: 28.sp, color: Colors.white),
                  ),
                  // onTap: () => _showSnackBar(context, 'Delete'),
                );
              }
            },
          ),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              top: 30.w,
              left: 15.w,
              bottom: 37.w,
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    _cardRadio(context, cartItem, model),
                    _image(cartItem.itempic),
                    _content(cartItem.itemtitle, '默认', cartItem.itemprice),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 16.w,
                  child: CartCount(
                    cartItem: cartItem,
                    // goodsNum: widget.goodsNum,
                    // index: widget.index,
                    // reduce: widget.reduce,
                    // add: widget.add,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
