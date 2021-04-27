import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/user/convenient_phone_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class ConvenientPhonePage extends StatefulWidget {
  ConvenientPhonePage({Key key}) : super(key: key);

  @override
  _ConvenientPhonePageState createState() => _ConvenientPhonePageState();
}

class _ConvenientPhonePageState extends State<ConvenientPhonePage> {
  EasyRefreshController _easyRefreshController;
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _easyRefreshController?.dispose();
    _textEditingController?.dispose();
    super.dispose();
  }

  Widget _buildTile(ConvenientPhoneModel model) {
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
                bool result = await Get.dialog(CupertinoAlertDialog(
                  title: model.tel.text.isIntrinsic.make(),
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
                onSubmitted: (value) {
                  _easyRefreshController.callRefresh();
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    size: 42.w,
                  ),
                  contentPadding: EdgeInsets.only(top: 14.w),
                  // isDense: true,
                  hintText: '搜索机构',
                  hintStyle:
                      TextStyle(color: Color(0xFF999999), fontSize: 28.sp),
                ),
              ),
            ),
          ),
          Expanded(
            child: BeeListView(
              extraParams: {'name': _textEditingController.text},
              controller: _easyRefreshController,
              path: API.manager.convenientPhone,
              convert: (model) {
                return model.tableList
                    .map((e) => ConvenientPhoneModel.fromJson(e))
                    .toList();
              },
              builder: (items) {
                return ListView.separated(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
                  itemBuilder: (context, index) {
                    return _buildTile(items[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 1.w,
                      height: 40.w,
                      color: Color(0xFFD8D8D8),
                    );
                  },
                  itemCount: items.length,
                );
              },
            ),
          ),
        ],
      ).material(color: Colors.white),
    );
  }
}
