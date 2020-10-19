import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/routers/page_routers.dart';

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
        top: Screenutil.length(27),
        bottom: Screenutil.length(52),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '请您对本次服务进行评价',
            style: TextStyle(
                fontSize: Screenutil.size(28), color: Color(0xff999999)),
          ),
          SizedBox(height: Screenutil.length(50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '综合评价',
                style: TextStyle(
                    fontSize: Screenutil.size(28), color: Color(0xff999999)),
              ),
              SizedBox(width: Screenutil.length(47)),
              SmoothStarRating(
                rating: rating,
                isReadOnly: false,
                size: Screenutil.size(46),
                filledIconData: AntDesign.star,
                // halfFilledIconData: Icons.star_half,
                defaultIconData: AntDesign.staro,
                color: Color(0xffffc40c),
                borderColor: Color(0xffffc40c),
                starCount: 5,
                allowHalfRating: false,
                spacing: Screenutil.length(20),
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
          top: Screenutil.length(32),
          left: Screenutil.length(22),
          right: Screenutil.length(35)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Color(0xffd4cfbe), width: 1.0),
      ),
      child: TextFormField(
        cursorColor: Color(0xffffc40c),
        style: TextStyle(
          fontSize: Screenutil.size(28),
          fontWeight: FontWeight.w600,
        ),
        controller: _proposeContent,
        onChanged: (String value) {},
        maxLines: 8,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: Screenutil.length(0),
            bottom: Screenutil.length(0),
          ),
          hintText: hintText,
          border: InputBorder.none, //去掉输入框的下滑线
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: Screenutil.size(28),
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
        height: Screenutil.length(96),
        margin: EdgeInsets.symmetric(horizontal: Screenutil.length(32)),
        padding: EdgeInsets.symmetric(vertical: Screenutil.length(25.5)),
        decoration: BoxDecoration(
          color: Color(0xffffc40c),
          borderRadius: BorderRadius.all(Radius.circular(48)),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Screenutil.size(32),
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '${widget.bundle.getMap('details')['title']}',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
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
                horizontal: Screenutil.length(32),
                vertical: Screenutil.length(36),
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
                                  fontSize: Screenutil.size(28),
                                  color: Color(0xff333333)),
                            ),
                            SizedBox(height: Screenutil.length(24)),
                            _containerTextField(hintText),
                            SizedBox(height: Screenutil.length(42)),
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
    //             SizedBox(height: Screenutil.length(42)),
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
    //                 horizontal: Screenutil.length(32),
    //                 vertical: Screenutil.length(36),
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   widget.isPropose ? SizedBox() : _containerEvaluateCard(),
    //                   Text(
    //                     '请输入内容',
    //                     style: TextStyle(
    //                         fontSize: Screenutil.size(28),
    //                         color: Color(0xff333333)),
    //                   ),
    //                   SizedBox(height: Screenutil.length(24)),
    //                   _containerTextField(hintText),
    //                   SizedBox(height: Screenutil.length(42)),
    //                   _inkWellButton(widget.isPropose ? '确认提交' : '发布'),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
  }
}
