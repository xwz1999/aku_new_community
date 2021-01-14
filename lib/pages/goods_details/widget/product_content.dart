import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart';

class ProductContent extends StatelessWidget {
  final String itemprice, itemtitle, itemshorttitle, itemdesc;
  ProductContent(
      {Key key,
      this.itemprice,
      this.itemtitle,
      this.itemshorttitle,
      this.itemdesc})
      : super(key: key);

  Row _rowPrice(String price) {
    return Row(
      children: [
        Text(
          '￥$price',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(42),
            color: Color(0xff333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          '元',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            color: Color(0xff333333),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Container _containerTitle(String title) {
    return Container(
      margin: EdgeInsets.only(
        top: 28.w,
        bottom: 18.w,
        right: 106.w,
      ),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(30), color: Color(0xff333333)),
      ),
    );
  }

  Container _containerSubtitle(String shortTitle) {
    return Container(
      margin: EdgeInsets.only(right: 286.w),
      child: Text(
        shortTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(24), color: Color(0xff666666)),
      ),
    );
  }

  Container _containerRecommend(String desc) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff0f0f0),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff3f3f3), offset: Offset(1, 1)),
        ],
      ),
      margin: EdgeInsets.only(
        left: 72.w,
        right: 72.w,
        top: 58.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 33.w,
        vertical: 11.w,
      ),
      child: Text(
        desc,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(20),
          color: Color(0xff666666),
        ),
      ),
    );
  }

  Positioned _positionedShare() {
    return Positioned(
      right: 0,
      top: 169.w,
      child: InkWell(
        onTap: () {
          shareToWeChat(WeChatShareWebPageModel(
            'https://mobile.baidu.com/item?docid=27505288',
            title: itemtitle,
            description: '前往小蜜蜂智慧社区查看吧',
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xfff0f0f0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomLeft: Radius.circular(100),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color(0xfff3f3f3), offset: Offset(1, 1)),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 9.w,
          ),
          child: Row(
            children: [
              Icon(
                SimpleLineIcons.share,
                size: ScreenUtil().setSp(20),
              ),
              SizedBox(width: 12.w),
              Text(
                '分享',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  color: Color(0xff666666),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Positioned _positionedRecommend() {
    return Positioned(
      right: 453.w,
      bottom: 100.w,
      child: Row(
        children: [
          Icon(
            AntDesign.hearto,
            color: Color(0xff999999),
            size: ScreenUtil().setSp(24),
          ),
          SizedBox(width: 12.w),
          Text(
            '推荐理由',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(20), color: Color(0xff999999)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 32.w,
              top: 25.w,
              bottom: 20.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _rowPrice(itemprice),
                _containerTitle(itemtitle),
                _containerSubtitle(itemshorttitle),
                _containerRecommend(itemdesc),
              ],
            ),
          ),
          _positionedShare(),
          _positionedRecommend(),
        ],
      ),
    );
  }
}
