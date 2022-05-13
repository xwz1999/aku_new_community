import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/models/convenience_phone/convenience_phone_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class ConvenientPhonePage extends StatefulWidget {
  ConvenientPhonePage({Key? key}) : super(key: key);

  @override
  _ConvenientPhonePageState createState() => _ConvenientPhonePageState();
}

class _ConvenientPhonePageState extends State<ConvenientPhonePage> {
  late EasyRefreshController _easyRefreshController;
  late TextEditingController _textEditingController;

  List<ConveniencePhoneModel> _models = [];

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  Widget _buildTile(ConveniencePhoneModel model) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                model.name.text.black.size(32.sp).make(),
                12.w.heightBox,
                model.tel.text.color(Color(0xFF999999)).size(28.sp).make(),
              ],
            ).expand(),
            IconButton(
              icon: Image.asset(
                R.ASSETS_ICONS_PHONE_PNG,
                width: 40.w,
                height: 40.w,
              ),
              onPressed: () async {
                bool? result = await Get.dialog(CupertinoAlertDialog(
                  title: '是否拨打电话 ${model.tel}'.text.isIntrinsic.make(),
                  actions: [
                    CupertinoDialogAction(
                      child: '取消'.text.isIntrinsic.make(),
                      onPressed: () => Get.back(),
                    ),
                    CupertinoDialogAction(
                      child: '确定'.text.isIntrinsic.make(),
                      onPressed: () => Get.back(result: true),
                    ),
                  ],
                ));
                if (result == true) launch('tel:${model.tel}');
              },
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '便民电话',
      body: Column(
        children: [
          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 72.w + 16.w),
            color: Colors.white,
            alignment: Alignment.center,
            child: Container(
              width: 686.w,
              height: 72.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36.w),
                color: Color(0xFFF9F9F9),
              ),
              child: TextField(
                controller: _textEditingController,
                onChanged: (value) {
                  _easyRefreshController.callRefresh();
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    size: 42.w,
                  ),
                  contentPadding: EdgeInsets.only(top: 3.w),
                  // isDense: true,
                  hintText: '搜索机构',
                  hintStyle:
                      TextStyle(color: Color(0xFF999999), fontSize: 28.sp),
                ),
              ),
            ),
          ),
          Expanded(
            child: EasyRefresh(
              firstRefresh: true,
              header: MaterialHeader(),
              controller: _easyRefreshController,
              onRefresh: () async {
                var base =
                    await NetUtil().get(SAASAPI.conveniencePhone.list, params: {
                  'name': _textEditingController.text,
                });
                if (base.success) {
                  _models = (base.data as List)
                      .map((e) => ConveniencePhoneModel.fromJson(e))
                      .toList();
                }
                setState(() {});
              },
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
                itemBuilder: (context, index) {
                  return _buildTile(_models[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1.w,
                    height: 40.w,
                    color: Color(0xFFD8D8D8),
                  );
                },
                itemCount: _models.length,
              ),
            ),
          ),
        ],
      ).material(color: Colors.white),
    );
  }
}
