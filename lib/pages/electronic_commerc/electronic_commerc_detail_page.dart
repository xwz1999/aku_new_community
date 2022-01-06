import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/electronic_commerc/electronic_commerc_detail_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ElectronicCommercDetailPage extends StatefulWidget {
  final int id;

  ElectronicCommercDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _ElectronicCommercDetailPageState createState() =>
      _ElectronicCommercDetailPageState();
}

class _ElectronicCommercDetailPageState
    extends State<ElectronicCommercDetailPage> {
  late EasyRefreshController _easyRefreshController;
  bool _onload = true;
  late ElectronicCommercDetailModel _detailModel;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: _onload ? '' : _detailModel.electronicCommerceCategoryName,
      bodyColor: Colors.white,
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          BaseModel baseModel =
              await NetUtil().get(API.manager.electronicCommercDetail, params: {
            "electronicCommerceId": widget.id,
          });
          if (baseModel.success && baseModel.data != null) {
            _detailModel =
                ElectronicCommercDetailModel.fromJson(baseModel.data);
          } else {
            BotToast.showText(text: '无法获取信息');
          }
          _onload = false;
          setState(() {});
        },
        child: _onload
            ? _emptyWidget()
            : ListView(
                padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
                children: [
                  //  SizedBox(
                  //   width: double.infinity,
                  //   child: FadeInImage.assetNetwork(
                  //       placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  //       image: API.image(ImgModel.first(_detailModel.imgList))),
                  // ),
                  // 24.w.heightBox,
                  _detailModel.title.text
                      .size(32.sp)
                      .color(ktextPrimary)
                      .bold
                      .align(TextAlign.center)
                      .make(),
                  24.w.heightBox,
                  SizedBox(
                    width: double.infinity,
                    child: _detailModel.content.text
                        .size(28.sp)
                        .color(ktextPrimary)
                        .make(),
                  ),
                  40.w.heightBox,
                  Row(
                    children: [
                      Spacer(),
                      '发布于 ${DateUtil.formatDateStr(_detailModel.createDate, format: 'MM-dd HH:mm')}'
                          .text
                          .size(24.sp)
                          .color(ktextSubColor)
                          .make(),
                    ],
                  )
                ],
              ),
      ),
    );
  }

  Widget _emptyWidget() {
    return Container();
  }
}
