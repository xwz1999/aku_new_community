import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/sliver_app_bar_delegate.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/widget/search_bar_delegate.dart';
import 'widget/phone_list.dart';

class ConvenientPhonePage extends StatefulWidget {
  ConvenientPhonePage({Key key}) : super(key: key);

  @override
  _ConvenientPhonePageState createState() => _ConvenientPhonePageState();
}

class _ConvenientPhonePageState extends State<ConvenientPhonePage> {
  Container _containerSearch() {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
           showSearch(context: context, delegate: searchBarDelegate());
        },
        child: Container(
          margin: EdgeInsets.only(
            left: 32.w,
            right: 32.w,
            top: 12.w,
            bottom: 20.w,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
            vertical: 16.w,
          ),
          decoration: BoxDecoration(
            color: Color(0xfff9f9f9),
            borderRadius: BorderRadius.all(Radius.circular(36)),
          ),
          child: InkWell(
            onTap: () {},
            child: Container(
              child: Row(children: [
                Icon(AntDesign.search1),
                SizedBox(width: 5),
                Text('搜索机构')
              ]),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _silverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double _swiperHeight = 122.w;
    double _spikeHeight = 25;
    double _appBarHeight = _swiperHeight - _spikeHeight - statusBarHeight;
    return <Widget>[
      SliverAppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
            child: Container(),
            preferredSize: Size.fromHeight((_appBarHeight).h)),
        flexibleSpace: Column(
          children: <Widget>[
            _containerSearch(),
          ],
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            minHeight: 45, //收起的高度
            maxHeight: 45,
            child: Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                '小区服务电话',
                style: TextStyle(
                  fontSize: 32.sp,
                ),
              ),
            )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '便民电话',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: NestedScrollView(
          headerSliverBuilder: _silverBuilder,
          body: PhoneList(),
        ),
      ),
    );
  }
}
