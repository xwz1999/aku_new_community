import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'package:akuCommunity/utils/headers.dart';

class MarketDetailsAppBar extends StatefulWidget {
  final String title;
  MarketDetailsAppBar({Key key, this.title}) : super(key: key);

  @override
  _MarketDetailsAppBarState createState() => _MarketDetailsAppBarState();
}

class _MarketDetailsAppBarState extends State<MarketDetailsAppBar> {
  List<Map<String, dynamic>> _classList = [
    {'title': '居家生活'},
    {'title': '数码家电'},
    {'title': '休闲副食'},
    {'title': '滋补保健'},
    {'title': '彩妆香水'},
    {'title': '服饰箱包'},
    {'title': '母婴玩具'},
    {'title': '饮料酒水'},
  ];

  /// 弹出顶部框
  void _showModelTopSheet() {
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Stack(
          children: <Widget>[
            Container(
              alignment:
                  Alignment.lerp(Alignment.topCenter, Alignment.center, 0.25),
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              child: Material(
                color: Color(0xffffffff),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: 282.w,
                  width: 686.w,
                  color: Colors.black.withOpacity(animation.value),
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                      top: 36.w,
                      left: 25.w,
                      right: 25.w,
                      bottom: 30.w,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _classList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xfffbfbfb),
                            border: Border.all(
                              color: _classList[index]['title'] == widget.title
                                  ? Color(0xffe60e0e)
                                  : Color(0xff979797),
                              width: 1.w,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            _classList[index]['title'],
                            style: TextStyle(
                                color:
                                    _classList[index]['title'] == widget.title
                                        ? Color(0xffe60e0e)
                                        : Color(0xff333333),
                                fontSize: 24.sp),
                          )),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20.w,
                        crossAxisSpacing: 30.w,
                        childAspectRatio: 192.w / 58.w),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 78,
              left: MediaQuery.of(context).size.width / 2.05,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  child: Icon(
                    AntDesign.caretup,
                    color: Color(0xffffffff),
                    size: 36.sp,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          alignment: Alignment.lerp(
              Alignment.topCenter, Alignment.center, 0.145), // 添加这个
          scale: anim,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        leading: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(AntDesign.left, size: 37.sp),
            onPressed: () {
              Get.back();
            }),
        title: InkWell(
          onTap: _showModelTopSheet,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 32.sp, color: Color(0xff333333)),
              ),
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.only(top: 1),
                child: Icon(
                  AntDesign.caretdown,
                  size: 18.sp,
                  color: Color(0xff000000),
                ),
              )
            ],
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              AntDesign.search1,
              size: 38.sp,
              color: Color(0xff666666),
            ),
            onPressed: () {},
          )
        ],
        // bottom: TabBar(
        //   controller: _controller,
        //   labelPadding: EdgeInsets.symmetric(horizontal: 15.w),
        //   indicator: BoxDecoration(),
        //   isScrollable: true,
        //   unselectedLabelStyle: TextStyle(
        //     fontSize: ScreenUtil().setSp(24),
        //   ),
        //   labelStyle: TextStyle(
        //     fontWeight: FontWeight.w600,
        //     fontSize: ScreenUtil().setSp(24),
        //   ),
        //   unselectedLabelColor: Color(0xff333333),
        //   labelColor: Color(0xffe60e0e),
        //   tabs: List.generate(
        //     treeList.length,
        //     (index) => Container(
        //       padding: EdgeInsets.symmetric(vertical:32.w),
        //       child: Column(
        //         children: <Widget>[
        //           Image.asset(
        //             treeList[index]['imagePath'],
        //             height: 110.w,
        //             width: 110.w,
        //             fit: BoxFit.fill,
        //           ),
        //           SizedBox(height: 14.w),
        //           Text(treeList[index]['name'])
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
