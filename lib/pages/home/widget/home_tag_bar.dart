import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';

class HomeTagBar extends StatefulWidget {
  final String title;
  final String tag;
  final bool isShowImage,isShowTitle;
  final Function fun;
  HomeTagBar({Key key, this.title, this.tag, this.isShowImage,this.isShowTitle = false,this.fun})
      : super(key: key);

  @override
  _HomeTagBarState createState() => _HomeTagBarState();
}

class _HomeTagBarState extends State<HomeTagBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.isShowTitle ? Colors.transparent : Colors.white,
      margin: EdgeInsets.symmetric(
        horizontal: Screenutil.length(32),
      ),
      padding: EdgeInsets.all(Screenutil.length(24)),
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  widget.isShowImage
                      ? Container(
                          margin: EdgeInsets.only(right: Screenutil.length(24)),
                          child: Image.asset(
                            AssetsImage.NOTIFICATION,
                            height: Screenutil.length(38),
                            width: Screenutil.length(38),
                          ),
                        )
                      : SizedBox(),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: widget.isShowImage
                            ? Screenutil.size(28)
                            : Screenutil.size(32),
                        fontWeight: widget.isShowImage
                            ? FontWeight.normal
                            : FontWeight.w600,
                        color: Color(0xff4a4b51)),
                  ),
                ],
              ),
               widget.isShowTitle ? SizedBox() : InkWell(
                onTap: () {
                  widget.fun();
                },
                child: Row(children: [
                  Text(
                    '更多${widget.tag}',
                    style: TextStyle(
                        color: Color(0xff999999),
                        fontSize: Screenutil.size(20)),
                  ),
                  SizedBox(width: Screenutil.length(8)),
                  Icon(
                    AntDesign.right,
                    color: Color(0xff999999),
                    size: Screenutil.size(20),
                  ),
                ]),
              ),
            ],
          ),
          widget.isShowImage
              ? SizedBox()
              : Positioned(
                  top: Screenutil.length(30),
                  left: 0,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffc40c).withOpacity(0.4),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      width: Screenutil.length(126),
                      height: Screenutil.length(8)),
                )
        ],
      ),
    );
  }
}
