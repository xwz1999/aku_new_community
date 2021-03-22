import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/model/aku_shop_class_model.dart';
import 'package:akuCommunity/service/base_model.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';
import 'widget/market_class_bar.dart';

class MarketClassPage extends StatefulWidget {
  MarketClassPage({Key key}) : super(key: key);

  @override
  _MarketClassPageState createState() => _MarketClassPageState();
}

class _MarketClassPageState extends State<MarketClassPage> {
  // Future.microtask(() => null)1
// void testSX(){
//   new Future(() => print('s_1'));
//   scheduleMicrotask(() => print('s_2'));
//   print('s_3');
// }

  int _currentIndex = 0;
  List<AkuShopClassModel> _shopClassList = [];
  List<String> _leftNav = [
    '居家生活',
    '服饰鞋包',
    '休闲副食',
    '数码家电',
    '彩妆香水',
    '母婴亲子',
    '运动旅游',
    '滋补保健',
  ];

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    akuShopClass();
  }

  Future<void> akuShopClass() async {
    Future<String> loadString =
        DefaultAssetBundle.of(context).loadString("assets/json/shopclass.json");
    loadString.then((String response) {
      Map<String, dynamic> result = json.decode(response.toString());
      BaseModel model = BaseModel.fromJson(result);
      model.result.forEach((item) {
        AkuShopClassModel list = AkuShopClassModel.fromJson(item);
        setState(() {
          _shopClassList.add(list);
        });
      });
    });
  }

  Widget _leftInkWellNav(int index) {
    return InkWell(
      child: Stack(
        children: [
          Container(
            height: 120.w,
            alignment: Alignment.center,
            color: _currentIndex == index ? Colors.white : Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 24.w),
            child: Text(
              _shopClassList[index].mainName,
              style: TextStyle(
                fontSize: BaseStyle.fontSize28,
                color: _currentIndex == index
                    ? BaseStyle.colorffc40c
                    : ktextPrimary,
              ),
            ),
          ),
          _currentIndex == index
              ? Positioned(
                  top: 42.w,
                  left: 1,
                  child: SizedBox(
                    width: 8.w,
                    height: 40.w,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: BaseStyle.colorffc40c),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
      onTap: () {
        setState(() {
          // _controller.animateTo(0, duration: Duration(seconds: 2), curve: Curves.easeInQuad);
          _controller.jumpTo(0);
          _currentIndex = index;
        });
      },
    );
  }

  Widget _classGridCard(List<Info> infoList) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: infoList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {},
              child: Container(
                child: Column(
                  children: [
                    CachedImageWrapper(
                      url: infoList[index].imgurl,
                      width: 152.w,
                      height: 152.w,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 14.w),
                      child: Text(
                        infoList[index].sonName,
                        style: TextStyle(
                          fontSize: BaseStyle.fontSize24,
                          color: ktextPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 152.w / 210.w,
        ),
      ),
    );
  }

  Widget _classList(String nextName, List<Info> infoList) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 24.w),
            padding: EdgeInsets.symmetric(vertical: 14.w),
            width: 476.w,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xffe8e8e8), width: 0.5),
              ),
            ),
            child: Text(
              nextName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: BaseStyle.fontSize26,
                color: ktextPrimary,
              ),
            ),
          ),
          _classGridCard(infoList),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _statusHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: PreferredSize(
        child: MarketClassBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: _shopClassList.length != 0
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(color: Color(0xffe8e8e8), width: 0.5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 203.w,
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        _statusHeight,
                    decoration: BoxDecoration(
                      border: Border(
                          right:
                              BorderSide(color: Color(0xffe8e8e8), width: 0.5)),
                    ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _leftNav.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _leftInkWellNav(index);
                        }),
                  ),
                  Container(
                    width: 547.w,
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        _statusHeight,
                    child: ListView(
                        shrinkWrap: true,
                        controller: _controller,
                        children: List.generate(
                            _shopClassList[_currentIndex].data.length,
                            (index) => _classList(
                                  _shopClassList[_currentIndex]
                                      .data[index]
                                      .nextName,
                                  _shopClassList[_currentIndex]
                                      .data[index]
                                      .info,
                                ))),
                  ),
                ],
              ),
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
