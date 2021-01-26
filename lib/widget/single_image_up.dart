// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_icons/flutter_icons.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';

class SingleImageUp extends StatefulWidget {
  final String title, imagePath;
  SingleImageUp({Key key, this.title, this.imagePath}) : super(key: key);

  @override
  _SingleImageUpState createState() => _SingleImageUpState();
}

class _SingleImageUpState extends State<SingleImageUp> {
  //图片多选
  List images = [];
  String error = 'No error Dectected';
  List resultList;

  //选择照片并上传
  Future<void> uploadImages() async {
    try {
      resultList = await MultiImagePicker.pickImages(
        //选择图片的最大数量
        maxImages: 1,
        //是否支持拍照
        enableCamera: true,
        materialOptions: MaterialOptions(
          //显示所有图片,值为false时显示相册
          // actionBarColor: '#fff',
          // statusBarColor: '#fff',
          // actionBarTitleColor: '#333',
          startInAllView: true,
          allViewTitle: "相册",
          useDetailsView: false,
          textOnNothingSelected: "没有选择照片",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }

    if (!mounted) return;
    setState(() {
      // images = (resultList == null) ? [] : resultList;
      if (resultList != null) {
        images.addAll(resultList);
      }
    });
    //一张张上传照片
    for (int i = 0; i < images.length; i++) {
      //获取byteData

      //MultipartFile multipartFile = MultipartFile.fromBytes(
      //imageData,
      //文件名
      //filename: "some-file-name.jpg",
      //文件类型
      //contentType:MediaType("image","jpg")
      //);
      //FormData formData = FormData.fromMap({
      // 后端接口的参数名称
      //"files": multipartFile
      //});
      // 后端接口 url
      //String url = ''；
      // 后端接口的其他参数
      //Map<String, dynamic> params = Map();
      // 使用 dio 上传图片
      //var response = await dio.post(url, data: formData, queryParameters: params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: images.length == 0
            ? () {
                uploadImages();
              }
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 328.w,
                  height: 180.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xffe8e8e8),
                        width: images.length == 0 ? 0 : 4.w),
                    borderRadius:
                        BorderRadius.all(Radius.circular(6.w)),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(6.w)),
                    child: images.length == 0
                        ? Image.asset(
                            widget.imagePath,
                            width: 328.w,
                            height: 180.w,
                          )
                        : AssetThumb(asset: images[0], width: 328, height: 180),
                  ),
                ),
                images.length == 0
                    ? SizedBox()
                    : Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              images.removeAt(0);
                            });
                          },
                          child: Icon(
                            AntDesign.closecircle,
                            color: BaseStyle.colorffc40c,
                            size: 36.sp,
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(height: 16.w),
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: BaseStyle.fontSize24, color: BaseStyle.color999999),
            ),
          ],
        ),
      ),

      // GridView.builder(
      //   shrinkWrap: true,
      //   physics: NeverScrollableScrollPhysics(),
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     mainAxisSpacing: 30.w,
      //     crossAxisSpacing: 32.w,
      //     childAspectRatio: 328.w / 230.w,
      //   ),
      //   itemBuilder: (BuildContext context, int index) {
      //     return index == images.length
      //         ? InkWell(
      //             onTap: () {
      //               uploadImages();
      //             },
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 ClipRRect(
      //                   borderRadius: BorderRadius.all(
      //                       Radius.circular(6.w)),
      //                   child: Image.asset(
      //                     widget.imagePath,
      //                     width: 328.w,
      //                     height: 180.w,
      //                   ),
      //                 ),
      //                 SizedBox(height: 16.w),
      //                 Text(
      //                   widget.title,
      //                   style: TextStyle(
      //                       fontSize: BaseStyle.fontSize24,
      //                       color: BaseStyle.color999999),
      //                 ),
      //               ],
      //             ),
      //           )
      //         : Stack(
      //             children: [
      //               Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   ClipRRect(
      //                     borderRadius: BorderRadius.all(
      //                         Radius.circular(6.w)),
      //                     child: AssetThumb(
      //                       asset: images[index],
      //                       width: 328,
      //                       height: 180,
      //                     ),

      //                     // Image.asset(
      //                     //   widget.imagePath,
      //                     //   width: 328.w,
      //                     //   height: 180.w,
      //                     // ),
      //                   ),
      //                   SizedBox(height: 16.w),
      //                   Text(
      //                     widget.title,
      //                     style: TextStyle(
      //                         fontSize: BaseStyle.fontSize24,
      //                         color: BaseStyle.color999999),
      //                   ),
      //                 ],
      //               ),
      //               Positioned(
      //                 top: 0,
      //                 right: 0,
      //                 child: InkWell(
      //                   onTap: () {
      //                     setState(() {
      //                       images.removeAt(index);
      //                     });
      //                   },
      //                   child: Icon(
      //                     AntDesign.closecircle,
      //                     color: BaseStyle.colorffc40c,
      //                     size: 36.sp,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           );
      //   },
      //   itemCount: 1,
      // ),
    );
  }
}
