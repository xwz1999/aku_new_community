import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:akuCommunity/utils/screenutil.dart';
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
          height: Screenutil.length(181),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffffd000), Color(0xffffbd00)],
            ),
          ),
        ),
        Positioned(
          top: Screenutil.length(17),
          left: 0,
          right: 0,
          bottom: -Screenutil.length(76),
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
                  height: Screenutil.length(240),
                  width: Screenutil.length(686),
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
                size: Screenutil.length(15),
                activeSize: Screenutil.length(20),
                space: Screenutil.length(10),
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
