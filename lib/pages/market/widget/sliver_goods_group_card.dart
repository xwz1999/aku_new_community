// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_icons/flutter_icons.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class SliverGoodsGroupCard extends StatefulWidget {
  SliverGoodsGroupCard({Key key}) : super(key: key);

  @override
  _SliverGoodsGroupCardState createState() => _SliverGoodsGroupCardState();
}

class _SliverGoodsGroupCardState extends State<SliverGoodsGroupCard> {
  List<Map<String, dynamic>> _groupList = [
    {
      'title': '果众 厄瓜多尔散把香蕉12根约2.4kg',
      'image':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600934902545&di=c610a098ad4b433af8f89ee2768c6d28&imgtype=0&src=http%3A%2F%2Fd6.yihaodianimg.com%2FN06%2FM0A%2F85%2FCD%2FCgQIzVQiy3GAbvbDAAJatt79Mms90000_600x600.jpg',
      'price': '36.6',
      'subtitle': '第2期 中国新疆仙人蕉',
      'remainingTime': '19天13时46分',
      'address': '中国-新疆',
      'arrivalTime': '2020年11月7日',
      'isOverTime': false,
    },
    {
      'title': '四川安岳新鲜黄柠檬尤力克包邮1斤中果现摘多汁产地直',
      'image':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600935221011&di=e7aecab551abef82de3fc3450916fe22&imgtype=0&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D109616473%2C3735766861%26fm%3D214%26gp%3D0.jpg',
      'price': '76.6',
      'subtitle': '第3期 中国安岳黄柠檬',
      'remainingTime': '21天13时46分',
      'address': '中国-四川',
      'arrivalTime': '2020年11月17日',
      'isOverTime': false,
    },
    {
      'title': '斤新鲜水果包邮76号甜瓜25新疆正宗吐鲁番哈密瓜西洲蜜',
      'image':
          'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=735601588,2284764256&fm=26&gp=0.jpg',
      'price': '68.6',
      'subtitle': '第1期 中国新疆哈密瓜',
      'remainingTime': '--天--时--分',
      'address': '中国-新疆',
      'arrivalTime': '2019年12月17日',
      'isOverTime': true,
    }
  ];

  Widget _image(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: CachedImageWrapper(
        url: image,
        height: 120.w,
        width: 160.w,
      ),
    );
  }

  Widget _button(String price, isOverTime) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 52.w,
        width: 170.w,
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: 10.w,
          bottom: 9.w,
        ),
        decoration: BoxDecoration(
          color: isOverTime ? Color(0xffd9d9d9) : Color(0xffffc40c),
          borderRadius: BorderRadius.all(Radius.circular(4.w)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¥$price',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
                color: isOverTime ? Color(0xff333333) : Color(0xffe60e0e),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              isOverTime ? '已过期' : '去团购',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  color: Color(0xff333333)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content(String title, subtitle, remainingTime, address, arrivalTime,
      price, isOverTime) {
    return Container(
      margin: EdgeInsets.only(left: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.w),
            width: 474.w,
            child: Text(
              title,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 30.sp,
                color: Color(0xff333333),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12.w),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 20.sp,
                color: Color(0xff333333),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.w),
            padding: EdgeInsets.only(
              top: 6.w,
              left: 11.w,
              bottom: 7.w,
              right: 20.w,
            ),
            decoration: BoxDecoration(
              color: isOverTime ? Color(0xffd9d9d9) : Color(0xffffeee3),
              borderRadius:
                  BorderRadius.all(Radius.circular(4.w)),
            ),
            child: Row(
              children: [
                Icon(
                  MaterialIcons.access_time,
                  size: 18.sp,
                  color: isOverTime ? Color(0xff333333) : Color(0xffff7f00),
                ),
                Text(
                  '剩余时间:$remainingTime',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isOverTime ? Color(0xff333333) : Color(0xffff7f00),
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30.w),
            width: 474.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '原产地:$address',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 20.sp),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      '预计到货:$arrivalTime',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 20.sp),
                    )
                  ],
                ),
                _button(price, isOverTime)
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext content, int index) {
        return Container(
          margin: EdgeInsets.only(
            top: 20.w,
            left: 32.w,
            right: 32.w,
          ),
          padding: EdgeInsets.only(
            top: 12.w,
            left: 12.w,
            right: 20.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(8.w)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _image(_groupList[index]['image']),
              _content(
                _groupList[index]['title'],
                _groupList[index]['subtitle'],
                _groupList[index]['remainingTime'],
                _groupList[index]['address'],
                _groupList[index]['arrivalTime'],
                _groupList[index]['price'],
                _groupList[index]['isOverTime'],
              ),
            ],
          ),
        );
      }, childCount: _groupList.length),
    );
  }
}
