import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_stack/image_stack.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/model/aku_shop_model.dart';

class HomeCard extends StatefulWidget {
  final String title;
  final String subtitleOne;
  final String subtitleTwo;
  final bool isActivity;
  final String imagePath;
  HomeCard(
      {this.title,
      this.subtitleOne,
      this.subtitleTwo,
      this.imagePath,
      this.isActivity,
      Key key})
      : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  List<String> images = [
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1151143562,4115642159&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2551412680,857245643&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3604827221,1047385274&fm=26&gp=0.jpg",
  ];

  Widget _countDown() {
    return Container(
      width: Screenutil.length(638),
      color: Color(0xff333333).withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Screenutil.length(24),
              top: Screenutil.length(11),
              bottom: Screenutil.length(12),
            ),
            child: Text(
              '剩余时间:09天13时46分',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xffffffff),
                  fontSize: Screenutil.size(24)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              right: Screenutil.length(24),
              top: Screenutil.length(7),
              bottom: Screenutil.length(7),
            ),
            child: Text(
              '¥99.9',
              style: TextStyle(
                  color: Color(0xffff8200), fontSize: Screenutil.size(36)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(String buttonName) {
    return InkWell(
      onTap: () {
        switch (widget.isActivity) {
          case true:
            Navigator.pushNamed(
                context, PageName.activities_details_page.toString(),
                arguments: Bundle()
                  ..putMap('details', {
                    'title': widget.title,
                    'imagePath': widget.imagePath,
                    'isOver': false,
                    'isVoteOver': false,
                    'isVote': false,
                    'memberList': images
                  }));
            break;
          case false:
            var shopInfo;
            shopInfo = {
              'itemid': '1',
              'itemtitle':widget.title,
              'taobao_image': "${widget.imagePath},${widget.imagePath}",
              'itemprice': '69.9',
              'itemshorttitle': widget.title,
              'itempic_copy': widget.imagePath,
              'itemdesc': widget.title,
              'itempic': widget.imagePath
            };
            Navigator.pushNamed(context, PageName.goods_details_page.toString(),
                arguments: Bundle()
                  ..putString(
                      'shoplist', json.encode(shopInfo).toString()));
            break;
          default:
        }
      },
      child: Container(
        height: Screenutil.length(44),
        width: Screenutil.length(120),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xffffc40c),
          borderRadius:
              BorderRadius.all(Radius.circular(Screenutil.length(22))),
        ),
        padding: EdgeInsets.symmetric(vertical: Screenutil.length(8)),
        child: Text(
          buttonName,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xff4a4b51),
              fontSize: Screenutil.size(20)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
        horizontal: Screenutil.length(32),
      ),
      padding: EdgeInsets.only(
        left: Screenutil.length(24),
        right: Screenutil.length(24),
        bottom: Screenutil.length(40),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(Screenutil.length(8))),
          border:
              Border.all(color: Color(0xffe8e8e8), width: Screenutil.length(2)),
        ),
        padding: EdgeInsets.only(bottom: Screenutil.length(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Screenutil.length(8)),
                      topRight: Radius.circular(Screenutil.length(8)),
                    ),
                    child: CachedImageWrapper(
                      url: widget.imagePath,
                      width: Screenutil.length(638),
                      height: Screenutil.length(210),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: Screenutil.length(16),
                left: Screenutil.length(24),
              ),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff4a4b51),
                    fontSize: Screenutil.size(28)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: Screenutil.length(16),
                left: Screenutil.length(24),
                right: Screenutil.length(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: Screenutil.size(24)),
                          children: <InlineSpan>[
                            TextSpan(
                                text: widget.isActivity ? '地点:' : '原产地区:',
                                style: TextStyle(color: Color(0xff999999))),
                            TextSpan(
                                text: widget.subtitleOne,
                                style: TextStyle(color: Color(0xff4a4b51))),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Screenutil.length(8)),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: Screenutil.size(24)),
                            children: <InlineSpan>[
                              TextSpan(
                                  text: widget.isActivity ? '活动时间:' : '预计到货:',
                                  style: TextStyle(color: Color(0xff999999))),
                              TextSpan(
                                  text: widget.subtitleTwo,
                                  style: TextStyle(color: Color(0xff4a4b51))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  widget.isActivity ? SizedBox() : _button('去团购')
                ],
              ),
            ),
            widget.isActivity
                ? Container(
                    margin: EdgeInsets.only(
                      top: Screenutil.length(16),
                      right: Screenutil.length(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: Screenutil.length(80)),
                          child: ImageStack(
                            imageList: images,
                            imageRadius: Screenutil.size(44),
                            imageCount: 3,
                            imageBorderWidth: 1,
                            totalCount: 3,
                          ),
                        ),
                        _button('去看看'),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
