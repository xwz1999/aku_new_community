import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/surrounding_enterprises/surrounding_enterprises_model.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SurroundingEnterprisesDetailPage extends StatefulWidget {
  final SurroundingEnterprisesModel surroundingEnterprisesModel;

  SurroundingEnterprisesDetailPage(
      {Key? key, required this.surroundingEnterprisesModel})
      : super(key: key);

  @override
  _SurroundingEnterprisesDetailPageState createState() =>
      _SurroundingEnterprisesDetailPageState();
}

class _SurroundingEnterprisesDetailPageState
    extends State<SurroundingEnterprisesDetailPage> {
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
                image: SAASAPI.image(ImgModel.first(
                    widget.surroundingEnterprisesModel.imgList))),
            width: double.infinity,
            height: 424.w,
          ),
          // 24.w.heightBox,
          // Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 32.w),
          //     child:
          //     // widget.houseIntroduceModel.content!.text
          //     //     .size(28.sp)
          //     //     .color(ktextPrimary)
          //     //     .make(),
          //     Text(
          //       widget.surroundingEnterprisesModel.name ?? '',
          //       style: TextStyle(
          //           fontSize: 30.sp,
          //           color: (ktextPrimary),
          //           fontWeight: FontWeight.bold),
          //     )),
          // Padding(
          //     padding: EdgeInsets.only(left: 32.w,right: 32.w,top: 16.w),
          //     child: Text(
          //       '发布于：${widget.surroundingEnterprisesModel.getReleaseDate}'  ,
          //       style: TextStyle(
          //           fontSize: 20.sp,
          //           color: (ktextThirdColor),
          //           fontWeight: FontWeight.bold),
          //     )),
          Padding(
              padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.w),
              child: Text(
                widget.surroundingEnterprisesModel.content ?? '',
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
