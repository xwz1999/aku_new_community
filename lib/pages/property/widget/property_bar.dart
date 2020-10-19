import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/sliver_app_bar_delegate.dart';

class PropertyBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final String more;
  final Function fun;
  PropertyBar({Key key, this.title, this.subtitle, this.more,this.fun})
      : super(key: key);

  TextStyle _textStyleTitle() {
    return TextStyle(
      fontSize: Screenutil.size(36),
      color: Color(0xff333333),
    );
  }

  TextStyle _textStyleSubtitle() {
    return TextStyle(
      fontSize: Screenutil.size(24),
      color: Color(0xff999999),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      // pinned: true, //是否固定在顶部
      // floating: true,
      delegate: SliverAppBarDelegate(
        minHeight: 93,
        maxHeight: 93,
        child: Container(
          margin: EdgeInsets.only(
            top: Screenutil.length(40),
            bottom: Screenutil.length(32),
            left: Screenutil.length(32),
            right: Screenutil.length(32),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _textStyleTitle()),
              SizedBox(height: Screenutil.length(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(subtitle, style: _textStyleSubtitle()),
                  more != null
                      ? InkWell(
                          onTap: () {
                            fun();
                          },
                          child: Row(
                            children: [
                              Text(more, style: _textStyleSubtitle()),
                              SizedBox(width: Screenutil.length(12)),
                              Icon(
                                AntDesign.right,
                                color: Color(0xff999999),
                                size: Screenutil.size(20),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
