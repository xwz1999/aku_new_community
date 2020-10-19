import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:akuCommunity/utils/fade_route.dart';
import 'package:akuCommunity/widget/gallery_photo_view_wrapper.dart';

class ProductSwiper extends StatelessWidget {
  List<String> imageUrl;
  ProductSwiper({Key key, this.imageUrl}) : super(key: key);

  final Random _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);
  List imageModel() {
    List imgList = List();
    for (int x = 0; x < imageUrl.length; x++) {
      GalleryExampleItem item = GalleryExampleItem();
      item.id = '${next(x + 100, x + 1000)}';
      item.resource = imageUrl[x];
      imgList.add(item);
    }

    return imgList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(500),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return AspectRatio(
            aspectRatio: 1,
            child: GalleryExampleItemThumbnail(
              galleryExampleItem: imageModel()[index],
              onTap: () {
                Navigator.of(context).push(new FadeRoute(
                  page: GalleryPhotoViewWrapper(
                    galleryItems: imageModel(),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    initialIndex: index,
                  ),
                ));
              },
            ),
          );
        },
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        autoplay: true,
        duration: 600,
        onTap: (index) {
          debugPrint("点击了第:$index个");
        },
        controller: SwiperController(),
        pagination: SwiperPagination(
          // 分页指示器
          alignment: Alignment.bottomCenter, // 位置 Alignment.bottomCenter 底部中间
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5), // 距离调整
          builder: DotSwiperPaginationBuilder(
            activeColor: Color(0xffFEC200),
            color: Colors.white,
            size: ScreenUtil().setWidth(15),
            activeSize: ScreenUtil().setWidth(25),
            space: ScreenUtil().setWidth(10),
          ),
        ),
        autoplayDelay: 5000,
        autoplayDisableOnInteraction: true,
      ),
    );
  }
}
