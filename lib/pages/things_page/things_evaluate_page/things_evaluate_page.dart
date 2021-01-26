// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

// Project imports:
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class ThingsEvaluatePage extends StatefulWidget {
  final Bundle bundle;
  ThingsEvaluatePage({Key key, this.bundle}) : super(key: key);

  @override
  _ThingsEvaluatePageState createState() => _ThingsEvaluatePageState();
}

class _ThingsEvaluatePageState extends State<ThingsEvaluatePage> {
  var rating = 0.0;

  TextEditingController _proposeContent = new TextEditingController();

  String hintText = '您对我们的工作有什么建议吗？欢迎您提供给我们宝贵的建议，谢谢';

  Container _containerEvaluateCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: EdgeInsets.only(
        top: 27.w,
        bottom: 52.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '请您对本次服务进行评价',
            style: TextStyle(
                fontSize: 28.sp, color: Color(0xff999999)),
          ),
          SizedBox(height: 50.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '综合评价',
                style: TextStyle(
                    fontSize: 28.sp, color: Color(0xff999999)),
              ),
              SizedBox(width: 47.w),
              SmoothStarRating(
                rating: rating,
                isReadOnly: false,
                size: 46.sp,
                filledIconData: AntDesign.star,
                // halfFilledIconData: Icons.star_half,
                defaultIconData: AntDesign.staro,
                color: Color(0xffffc40c),
                borderColor: Color(0xffffc40c),
                starCount: 5,
                allowHalfRating: false,
                spacing: 20.w,
                onRated: (value) {
                  print("rating value -> $value");
                  // print("rating value dd -> ${value.truncate()}");
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Container _containerTextField(String hintText) {
    return Container(
      padding: EdgeInsets.only(
          top: 32.w,
          left: 22.w,
          right: 35.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Color(0xffd4cfbe), width: 1.0),
      ),
      child: TextFormField(
        cursorColor: Color(0xffffc40c),
        style: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w600,
        ),
        controller: _proposeContent,
        onChanged: (String value) {},
        maxLines: 8,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: 0.w,
            bottom: 0.w,
          ),
          hintText: hintText,
          border: InputBorder.none, //去掉输入框的下滑线
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: 28.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  InkWell _inkWellButton(String title) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 96.w,
        margin: EdgeInsets.symmetric(horizontal: 32.w),
        padding: EdgeInsets.symmetric(vertical: 25.5.w),
        decoration: BoxDecoration(
          color: Color(0xffffc40c),
          borderRadius: BorderRadius.all(Radius.circular(48)),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32.sp,
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '${widget.bundle.getMap('details')['title']}',
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 36.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.bundle.getMap('details')['isShow']
                      ? _containerEvaluateCard()
                      : SizedBox(),
                  widget.bundle.getMap('details')['isShow']
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '请输入内容',
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  color: Color(0xff333333)),
                            ),
                            SizedBox(height: 24.w),
                            _containerTextField(hintText),
                            SizedBox(height: 42.w),
                          ],
                        ),
                  _inkWellButton('确认提交'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // return widget.isAlone
    //     ? Container(
    //         child: Column(
    //           children: [
    //             _containerEvaluateCard(),
    //             SizedBox(height: 42.w),
    //             _inkWellButton('确认'),
    //           ],
    //         ),
    //       )
    //     : SingleChildScrollView(
    //         child: Container(
    //           height: MediaQuery.of(context).size.height -
    //               kToolbarHeight -
    //               widget.statusHeight,
    //           color: Colors.white,
    //           child: GestureDetector(
    //             behavior: HitTestBehavior.opaque,
    //             onTap: () {
    //               FocusScope.of(context).requestFocus(FocusNode());
    //             },
    //             child: Container(
    //               padding: EdgeInsets.symmetric(
    //                 horizontal: 32.w,
    //                 vertical: 36.w,
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   widget.isPropose ? SizedBox() : _containerEvaluateCard(),
    //                   Text(
    //                     '请输入内容',
    //                     style: TextStyle(
    //                         fontSize: 28.sp,
    //                         color: Color(0xff333333)),
    //                   ),
    //                   SizedBox(height: 24.w),
    //                   _containerTextField(hintText),
    //                   SizedBox(height: 42.w),
    //                   _inkWellButton(widget.isPropose ? '确认提交' : '发布'),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
  }
}
