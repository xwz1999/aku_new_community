import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';
import 'package:akuCommunity/utils/screenutil.dart';

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
        height: Screenutil.length(120),
        width: Screenutil.length(160),
      ),
    );
  }

  Widget _button(String price, isOverTime) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: Screenutil.length(52),
        width: Screenutil.length(170),
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: Screenutil.length(10),
          bottom: Screenutil.length(9),
        ),
        decoration: BoxDecoration(
          color: isOverTime ? Color(0xffd9d9d9) : Color(0xffffc40c),
          borderRadius: BorderRadius.all(Radius.circular(Screenutil.length(4))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¥${price}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Screenutil.size(24),
                color: isOverTime ? Color(0xff333333) : Color(0xffe60e0e),
              ),
            ),
            SizedBox(width: Screenutil.length(10)),
            Text(
              isOverTime ? '已过期' : '去团购',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Screenutil.size(24),
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
      margin: EdgeInsets.only(left: Screenutil.length(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Screenutil.length(8)),
            width: Screenutil.length(474),
            child: Text(
              title,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: Screenutil.size(30),
                color: Color(0xff333333),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Screenutil.length(12)),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: Screenutil.size(20),
                color: Color(0xff333333),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Screenutil.length(16)),
            padding: EdgeInsets.only(
              top: Screenutil.length(6),
              left: Screenutil.length(11),
              bottom: Screenutil.length(7),
              right: Screenutil.length(20),
            ),
            decoration: BoxDecoration(
              color: isOverTime ? Color(0xffd9d9d9) : Color(0xffffeee3),
              borderRadius:
                  BorderRadius.all(Radius.circular(Screenutil.length(4))),
            ),
            child: Row(
              children: [
                Icon(
                  MaterialIcons.access_time,
                  size: Screenutil.size(18),
                  color: isOverTime ? Color(0xff333333) : Color(0xffff7f00),
                ),
                Text(
                  '剩余时间:${remainingTime}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isOverTime ? Color(0xff333333) : Color(0xffff7f00),
                    fontSize: Screenutil.size(18),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Screenutil.length(30)),
            width: Screenutil.length(474),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '原产地:${address}',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: Screenutil.size(20)),
                    ),
                    SizedBox(height: Screenutil.length(10)),
                    Text(
                      '预计到货:${arrivalTime}',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: Screenutil.size(20)),
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
            top: Screenutil.length(20),
            left: Screenutil.length(32),
            right: Screenutil.length(32),
          ),
          padding: EdgeInsets.only(
            top: Screenutil.length(12),
            left: Screenutil.length(12),
            right: Screenutil.length(20),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(Screenutil.length(8))),
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
