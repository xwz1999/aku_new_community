import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/models/community_introduce/community_introduce_model.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:aku_community/const/resource.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class CommunityIntroducePage extends StatefulWidget {
  CommunityIntroducePage({Key? key}) : super(key: key);

  @override
  _CommunityIntroducePageState createState() => _CommunityIntroducePageState();
}

class _CommunityIntroducePageState extends State<CommunityIntroducePage> {
  CommunityIontroduceModel _model = CommunityIontroduceModel.init();
  bool _onload = false;
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      bodyColor: Colors.white,
      title: '社区介绍',
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          BaseModel baseModel =
              await NetUtil().get(API.manager.communityIntroduceInfo);
          if (baseModel.status! && baseModel.data != null) {
            _model = CommunityIontroduceModel.fromJson(baseModel.data);
          }
          _onload = false;
          setState(() {});
        },
        child: _onload
            ? Container()
            : ListView(
                children: [
                  SizedBox(
                    child: FadeInImage.assetNetwork(
                        placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                        fit: BoxFit.cover,
                        image: API.image(ImgModel.first(_model.imgList))),
                    width: double.infinity,
                    height: 424.w,
                  ),
                  24.w.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: _model.content.text
                        .size(28.sp)
                        .color(ktextPrimary)
                        .make(),
                  ),
                ],
              ),
      ),
    );
  }
}
