// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_swiper/flutter_swiper.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class HomeSwiper extends StatefulWidget {
  HomeSwiper({Key key}) : super(key: key);

  @override
  _HomeSwiperState createState() => _HomeSwiperState();
}

class _HomeSwiperState extends State<HomeSwiper> {
  List<String> imageList = [
    'https://img.zcool.cn/community/0105a75f7298a211013e45848411c8.jpg',
    'https://img.zcool.cn/community/018c135f73e06711013e4584f1f2fd.jpg',
    'https://img.zcool.cn/community/01e08257de03a10000018c1b55623d.jpg@1280w_1l_2o_100sh.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          height: 181.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffffd000), Color(0xffffbd00)],
            ),
          ),
        ),
        Positioned(
          top: 17.w,
          left: 0,
          right: 0,
          bottom: -76.w,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: CachedImageWrapper(
                  url: imageList[index],
                  height: 240.w,
                  width: 686.w,
                ),
              );
            },
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.8,
            scale: 0.9,
            autoplay: true,
            duration: 600,
            onTap: (index) {
              debugPrint("点击了第:$index个");
            },
            controller: SwiperController(),
            pagination: SwiperPagination(
              // 分页指示器
              alignment:
                  Alignment.bottomCenter, // 位置 Alignment.bottomCenter 底部中间
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5), // 距离调整
              builder: DotSwiperPaginationBuilder(
                activeColor: Color(0xffFEC200),
                color: Colors.white,
                size: 15.w,
                activeSize: 20.w,
                space: 10.w,
              ),
            ),
            autoplayDelay: 5000,
            autoplayDisableOnInteraction: true,
          ),
        ),
      ],
    );
  }
}
