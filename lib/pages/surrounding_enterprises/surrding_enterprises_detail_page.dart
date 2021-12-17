import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/surrounding_enterprises/surrounding_enterprises_model.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class SurroundingEnterprisesDetailPage extends StatefulWidget {
  final SurroundingEnterprisesModel houseIntroduceModel;

  SurroundingEnterprisesDetailPage(
      {Key? key, required this.houseIntroduceModel})
      : super(key: key);

  @override
  _SurroundingEnterprisesDetailPageState createState() =>
      _SurroundingEnterprisesDetailPageState();
}

class _SurroundingEnterprisesDetailPageState
    extends State<SurroundingEnterprisesDetailPage> {
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
                    .image(ImgModel.first(widget.houseIntroduceModel.imgList))),
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
