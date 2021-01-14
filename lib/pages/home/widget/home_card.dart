import 'dart:convert';
import 'package:akuCommunity/pages/activities_page/activities_details_page/activities_details_page.dart';
import 'package:akuCommunity/pages/goods_details/goods_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_stack/image_stack.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';
import 'package:akuCommunity/routers/page_routers.dart';

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

  Widget _button(String buttonName) {
    return InkWell(
      onTap: () {
        switch (widget.isActivity) {
          case true:
            ActivitiesDetailsPage(
              bundle: Bundle()
                ..putMap('details', {
                  'title': widget.title,
                  'imagePath': widget.imagePath,
                  'isOver': false,
                  'isVoteOver': false,
                  'isVote': false,
                  'memberList': images
                }),
            ).to;
            break;
          case false:
            var shopInfo;
            shopInfo = {
              'itemid': '1',
              'itemtitle': widget.title,
              'taobao_image': "${widget.imagePath},${widget.imagePath}",
              'itemprice': '69.9',
              'itemshorttitle': widget.title,
              'itempic_copy': widget.imagePath,
              'itemdesc': widget.title,
              'itempic': widget.imagePath
            };
            GoodsDetailsPage(
              bundle: Bundle()
                ..putString('shoplist', json.encode(shopInfo).toString()),
            ).to;
            break;
          default:
        }
      },
      child: Container(
        height: 44.w,
        width: 120.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xffffc40c),
          borderRadius: BorderRadius.all(Radius.circular(22.w)),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: Text(
          buttonName,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xff4a4b51),
              fontSize: 20.sp),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
        horizontal: 32.w,
      ),
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        bottom: 40.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          border: Border.all(color: Color(0xffe8e8e8), width: 2.w),
        ),
        padding: EdgeInsets.only(bottom: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.w),
                      topRight: Radius.circular(8.w),
                    ),
                    child: CachedImageWrapper(
                      url: widget.imagePath,
                      width: 638.w,
                      height: 210.w,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: 16.w,
                left: 24.w,
              ),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff4a4b51),
                    fontSize: 28.sp),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 16.w,
                left: 24.w,
                right: 24.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 24.sp),
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
                        margin: EdgeInsets.only(top: 8.w),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 24.sp),
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
                      top: 16.w,
                      right: 24.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 80.w),
                          child: ImageStack(
                            imageList: images,
                            imageRadius: 44.sp,
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
