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
        SizedBox(width: ScreenUtil().setWidth(10)),
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
        top: ScreenUtil().setWidth(28),
        bottom: ScreenUtil().setWidth(18),
        right: ScreenUtil().setWidth(106),
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
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(286)),
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
        left: ScreenUtil().setWidth(72),
        right: ScreenUtil().setWidth(72),
        top: ScreenUtil().setWidth(58),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(33),
        vertical: ScreenUtil().setWidth(11),
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
      top: ScreenUtil().setWidth(169),
      child: InkWell(
        onTap: () {
          shareToWeChat(WeChatShareWebPageModel(
              'https://mobile.baidu.com/item?docid=27505288',
              
              title:itemtitle,
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
            horizontal: ScreenUtil().setWidth(14),
            vertical: ScreenUtil().setWidth(9),
          ),
          child: Row(
            children: [
              Icon(
                SimpleLineIcons.share,
                size: ScreenUtil().setSp(20),
              ),
              SizedBox(width: ScreenUtil().setWidth(12)),
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
      right: ScreenUtil().setWidth(453),
      bottom: 100.w,
      child: Row(
        children: [
          Icon(
            AntDesign.hearto,
            color: Color(0xff999999),
            size: ScreenUtil().setSp(24),
          ),
          SizedBox(width: ScreenUtil().setWidth(12)),
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
              left: ScreenUtil().setWidth(32),
              top: ScreenUtil().setWidth(25),
              bottom: ScreenUtil().setWidth(20),
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
