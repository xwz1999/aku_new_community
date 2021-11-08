import 'package:aku_community/utils/bee_date_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/const/resource.dart';
import 'package:aku_community/model/community/board_model.dart';
import 'package:aku_community/ui/community/notice/notice_page.dart';
import 'package:aku_community/utils/headers.dart';

class HomeNotification extends StatefulWidget {
  final List<BoardItemModel> items;

  HomeNotification({Key? key, required this.items}) : super(key: key);

  @override
  _HomeNotificationState createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  late BoardItemModel boardItemModel;

  bool isDate = true;

  @override
  void initState() {
    super.initState();
    if (widget.items != null) {
      if (widget.items.length > 0) {
        boardItemModel = widget.items[0];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        24.wb,

        Image.asset(
          R.ASSETS_IMAGES_NOTICE_PNG,
          height: 45.w,
          width: 61.w,
        ),
        24.wb,
        widget.items.isEmpty
            ? Spacer()
            : Container(
                width: 295,
                child: CarouselSlider(
                  items: widget.items.map((e) => getText(e)).toList(),
                  options: CarouselOptions(
                    scrollDirection: Axis.vertical,
                    viewportFraction: 1.0,
                    aspectRatio: 300 / 40,
                    autoPlay: true,

                    onPageChanged: (index, _) {
                      print(index.toString());
                      // setState(() {
                      //   _currentIndicator = index;
                      // });
                    },
                  ),
                ),
              ),
        // Container(
        //         alignment: Alignment.centerLeft,
        //         height: 85.w,
        //         child:
        //         Row(
        //           children: [
        //             Container(
        //               width: 200,
        //               height: 22,
        //               alignment: Alignment.centerLeft,
        //               child: AnimatedTextKit(
        //                 pause: Duration(milliseconds: 2000),
        //                 animatedTexts: widget.items
        //                     .map((e) {
        //                 return   RotateAnimatedText(
        //                     e.title!,
        //                     textStyle: TextStyle(
        //                       color: Color(0xA6000000),
        //                       fontSize: 22.sp,
        //                       fontWeight: FontWeight.bold,
        //
        //
        //                     ),
        //                     duration: Duration(milliseconds: 3000),
        //                   );
        //                 }
        //
        //               )
        //                     .toList(),
        //                 repeatForever: true,
        //                 onNext: (index,bool){
        //                   print('next');
        //                   boardItemModel = widget.items[index];
        //                   isDate = true;
        //                   setState(() {
        //                   });
        //                 },
        //                 onNextBeforePause: (index,bool){
        //                   print('before');
        //                   isDate = false;
        //                   setState(() {
        //                   });
        //                 },
        //               ),
        //             ),
        //
        //
        //           ],
        //         )
        //
        //       ).expand(),
        // isDate
        //     ? MaterialButton(
        //         shape: StadiumBorder(),
        //         padding: EdgeInsets.symmetric(horizontal: 12.w),
        //         onPressed: () {
        //           Get.to(() => NoticePage());
        //         },
        //         child: Row(
        //           children: [
        //             Container(
        //                 constraints: BoxConstraints(minWidth: 60),
        //                 child: Text(
        //                   isDate
        //                       ? boardItemModel.releaseDate != null
        //                           ? BeeDateUtil(boardItemModel.releaseDate)
        //                               .timeAgo
        //                           : ''
        //                       : '',
        //                   style: TextStyle(
        //                     color: Color(0x73000000),
        //                     fontSize: 20.sp,
        //                   ),
        //                 )
        //                 // AnimatedTextKit(
        //                 //   pause: Duration(milliseconds: 2000),
        //                 //   animatedTexts: widget.items
        //                 //       .map((e) => RotateAnimatedText(
        //                 //     e.releaseDate!=null?BeeDateUtil(e.releaseDate)
        //                 //         .timeAgo:'',
        //                 //
        //                 //     textStyle: TextStyle(
        //                 //       color: Color(0x73000000),
        //                 //       fontSize: 20.sp,
        //                 //
        //                 //     ),
        //                 //     duration: Duration(milliseconds: 3000),
        //                 //   ))
        //                 //       .toList(),
        //                 //   repeatForever: true,
        //                 // ),
        //                 ),
        //             8.wb,
        //             Icon(
        //               CupertinoIcons.chevron_forward,
        //               size: 24.w,
        //               color: Color(0xFF999999),
        //             ),
        //           ],
        //         ),
        //       )
        //     : SizedBox(),
        12.wb,
      ],
    );
  }

  Widget getText(BoardItemModel e) {
    return GestureDetector(
      onTap: (){
        Get.to(() => NoticePage());
      },
      child: Container(
        width: 295,
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: 230
              ),
                child: Text(
              e.title ?? '',
              style: TextStyle(
                color: Color(0xA6000000),
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
            )),
            Spacer(),
            Container(
                child: Text(
              e.releaseDate != null ? BeeDateUtil(e.releaseDate).timeAgo : '',
              style: TextStyle(
                color: Color(0x73000000),
                fontSize: 20.sp,
              ),
            )),
            8.wb,
            Icon(
              CupertinoIcons.chevron_forward,
              size: 24.w,
              color: Color(0xFF999999),
            ),
          ],
        ),
      ),
    );
  }
}
