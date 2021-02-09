// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_icons/flutter_icons.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

// Project imports:
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';

class CommonImagePicker extends StatefulWidget {
  CommonImagePicker({Key key}) : super(key: key);

  @override
  _CommonImagePickerState createState() => _CommonImagePickerState();
}

class _CommonImagePickerState extends State<CommonImagePicker> {
  //图片多选
  List images = [];
  String error = 'No error Dectected';
  List resultList;

  //选择照片并上传
  Future<void> uploadImages() async {
    try {
      resultList = await MultiImagePicker.pickImages(
        //选择图片的最大数量
        maxImages: 9,
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
      // ByteData byteData = await images[i].getByteData();
      // List<int> imageData = byteData.buffer.asUint8List();

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
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return index == images.length
              ? InkWell(
                  onTap: () {
                    uploadImages();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    child: Image.asset(
                      AssetsImage.IMAGEADD,
                      width: 218.w,
                      height: 218.w,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      child: AssetThumb(
                        asset: images[index],
                        width: 300,
                        height: 300,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            images.removeAt(index);
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
                );
        },
        itemCount: images.length == 9 ? images.length : images.length + 1,
      ),
    );
  }
}
