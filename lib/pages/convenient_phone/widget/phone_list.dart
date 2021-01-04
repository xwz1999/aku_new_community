import 'package:akuCommunity/utils/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:akuCommunity/base/assets_image.dart';

class PhoneList extends StatefulWidget {
  PhoneList({Key key}) : super(key: key);

  @override
  _PhoneListState createState() => _PhoneListState();
}

class _PhoneListState extends State<PhoneList> {
  List<Map<String, dynamic>> _phoneList = [
    {'name': '绿化徐', 'phone': '18898097890'},
    {'name': '废品回收', 'phone': '13890909090'},
    {'name': '业委会电话', 'phone': '0574-88467897'},
    {'name': '7-9幢管家', 'phone': '18989093454'},
    {'name': '监控电话', 'phone': '0574-8812572'},
    {'name': '百世快递', 'phone': '15890987687'},
  ];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1500));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  Future<void> _phoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showDialog(String url) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            url,
            style: TextStyle(
              fontSize: 34.sp,
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: 34.sp,
                  color: Color(0xff333333),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '呼叫',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 34.sp,
                  color: Color(0xffff8200),
                ),
              ),
              onPressed: () {
                _phoneCall('tel:$url');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _phoneCard(String name, String phone) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      padding: EdgeInsets.only(
        top: 23.w,
        bottom: 20.w,
      ),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        border:
            Border(bottom: BorderSide(color: Color(0xffd9d9d9), width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 32.sp,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(height: 12.w),
              Text(
                phone,
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(0xff999999),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              _showDialog(phone);
            },
            child: Image.asset(
              AssetsImage.PHONE,
              height: 60.w,
              width: 60.w,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: WaterDropHeader(),
      footer: ClassicFooter(),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullUp: true,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _phoneCard(
                  _phoneList[index]['name'],
                  _phoneList[index]['phone'],
                );
              },
              childCount: _phoneList.length,
            ),
          ),
        ],
      ),
    );
  }
}
