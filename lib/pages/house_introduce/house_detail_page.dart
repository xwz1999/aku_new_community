import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/house_introduce/house_introduce_model.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class HouseDetailPage extends StatefulWidget {
  final HouseIntroduceModel houseIntroduceModel;

  HouseDetailPage({Key? key, required this.houseIntroduceModel})
      : super(key: key);

  @override
  _HouseDetailPageState createState() => _HouseDetailPageState();
}

class _HouseDetailPageState extends State<HouseDetailPage> {
  bool _onload = false;

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      bodyColor: Colors.white,
      title: '住房详情',
      body: ListView(
        children: [
          SizedBox(
            child: FadeInImage.assetNetwork(
                placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                fit: BoxFit.cover,
                image: API
                    .image(ImgModel.first(widget.houseIntroduceModel.imgUrls))),
            width: double.infinity,
            height: 424.w,
          ),
          24.w.heightBox,
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child:
                  // widget.houseIntroduceModel.content!.text
                  //     .size(28.sp)
                  //     .color(ktextPrimary)
                  //     .make(),
                  Text(
                widget.houseIntroduceModel.name ?? '',
                style: TextStyle(
                    fontSize: 30.sp,
                    color: (ktextPrimary),
                    fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 16.w),
              child: Text(
                '发布于：${widget.houseIntroduceModel.getReleaseDate}',
                style: TextStyle(
                    fontSize: 20.sp,
                    color: (ktextThirdColor),
                    fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 40.w),
              child: Text(
                widget.houseIntroduceModel.content ?? '',
                style: TextStyle(
                    fontSize: 26.sp,
                    color: (ktextSubColor),
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
