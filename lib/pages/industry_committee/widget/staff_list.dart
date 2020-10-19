import 'package:akuCommunity/utils/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class StaffList extends StatefulWidget {
  StaffList({Key key}) : super(key: key);

  @override
  _StaffListState createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  List<Map<String, dynamic>> _staffList = [
    {
      'name': '刘鄂',
      'imagePath':
          'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1917253203,3586495528&fm=26&gp=0.jpg',
      'address': '3幢2单元703室',
      'tenure': '2016年12月19日-2020年10月3日',
      'post': '会计师',
      'tag': '主任'
    },
    {
      'name': '史红',
      'imagePath':
          'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1051460286,4207974038&fm=26&gp=0.jpg',
      'address': '10幢1单元1903室',
      'tenure': '2017年4月21日-2020年10月3日',
      'post': '宠物医生',
      'tag': '副主任'
    },
    {
      'name': '陈吉明',
      'imagePath':
          'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2962135405,1279141756&fm=26&gp=0.jpg',
      'address': '19幢1单元203室',
      'tenure': '2018年12月12日-2020年10月3日',
      'post': '个体私营五金厂老板',
      'tag': '委员'
    },
    {
      'name': '周立宇',
      'imagePath':
          'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2503876943,2429234388&fm=26&gp=0.jpg',
      'address': '19幢1单元203室',
      'tenure': '2018年11月23日-2020年10月3日',
      'post': '技术工程师',
      'tag': '委员'
    },
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

  TextStyle _subStyle() {
    return TextStyle(
      fontSize: Screenutil.size(24),
      color: Color(0xff999999),
    );
  }

  Positioned _positionedTag(String tag) {
    return Positioned(
      top: 0,
      right: Screenutil.length(20),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Screenutil.length(21.5),
            vertical: Screenutil.length(5.5)),
        decoration: BoxDecoration(
            color: Color(0xfffff3cd),
            border: Border.all(color: Color(0xffffc40c), width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(22))),
        child: Text(
          tag,
          style: TextStyle(
            fontSize: Screenutil.size(24),
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  Container _containerStaffCard(String name, String imagePath, String address,
      String tenure, String post, String tag) {
    return Container(
      margin: EdgeInsets.only(
        left: Screenutil.length(32),
        right: Screenutil.length(32),
        top: Screenutil.length(20),
      ),
      padding: EdgeInsets.only(
        left: Screenutil.length(20),
        top: Screenutil.length(20),
        bottom: Screenutil.length(20),
      ),
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedImageWrapper(
                url: imagePath,
                height: Screenutil.length(150),
                width: Screenutil.length(150),
              ),
              SizedBox(width: Screenutil.length(24)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Screenutil.size(28),
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(width: Screenutil.length(10)),
                  Text(
                    '住址：${address}',
                    style: _subStyle(),
                  ),
                  SizedBox(width: Screenutil.length(10)),
                  Text(
                    '任职期限：${tenure}',
                    style: _subStyle(),
                  ),
                  SizedBox(width: Screenutil.length(10)),
                  Text(
                    '从事岗位：${post}',
                    style: _subStyle(),
                  ),
                ],
              ),
            ],
          ),
          _positionedTag(tag),
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
      enablePullUp: false,
      enablePullDown: false,
      child: ListView.builder(
        itemBuilder: (context, index) => _containerStaffCard(
          _staffList[index]['name'],
          _staffList[index]['imagePath'],
          _staffList[index]['address'],
          _staffList[index]['tenure'],
          _staffList[index]['post'],
          _staffList[index]['tag'],
        ),
        itemCount: _staffList.length,
      ),
    );
  }
}
