import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:akuCommunity/utils/fade_route.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/gallery_photo_view_wrapper.dart';

class ImageHorizontalList extends StatelessWidget {
  final List<String> imageUrl;
  ImageHorizontalList({Key key, this.imageUrl}) : super(key: key);

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
      height: 184.w,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: EdgeInsets.only(right: 16.w),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
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
              ),
            ),
          );
        },
        itemCount: imageUrl.length,
      ),
    );
  }
}
