import 'package:aku_community/models/house_introduce/house_introduce_model.dart';
import 'package:aku_community/utils/hive_store.dart';
import 'package:aku_community/utils/websocket/tips_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/constants/app_theme.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/model/user/committee_item_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

import 'house_detail_page.dart';

class HouseIntroducePage extends StatefulWidget {
  HouseIntroducePage({Key? key}) : super(key: key);

  @override
  _HouseIntroducePageState createState() => _HouseIntroducePageState();
}



class _HouseIntroducePageState extends State<HouseIntroducePage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 0), () async {
    //   var agreement = await HiveStore.appBox?.get('IndustryCommitteePage') ?? false;
    //   if (!agreement) {
    //     await TipsDialog.tipsDialog();
    //     HiveStore.appBox!.put('IndustryCommitteePage',true);
    //   }
    // });

  }


  Widget _buildCard(HouseIntroduceModel model) {
    return GestureDetector(
      onTap: (){
        Get.to(HouseDetailPage(houseIntroduceModel: model,));
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        color: Colors.white,
        height: 250.w,
        child: Row(
          //  .padding(EdgeInsets.all(20.w)).white.withRounded(value: 8.w).make()

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.w),
              child: FadeInImage.assetNetwork(
                placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                image: API.image(ImgModel.first(model.imgUrls)),
                height: 200.w,
                width: 240.w,
                fit: BoxFit.fill,
              ),
            ),
            24.wb,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 440.w,
                  child: Text(
                    '${model.name}',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: ktextPrimary
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
             '发布于：${model.getReleaseDate}'
                      .text
                      .size(20.sp)
                      .color(ktextThirdColor)
                      .make(),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '住房介绍',
      systemStyle: SystemStyle.genStyle(bottom: Color(0xFF2A2A2A)),
      body: BeeListView<HouseIntroduceModel>(
        path: API.manager.houseType,
        convert: (model) {
          return model.tableList!
              .map((e) => HouseIntroduceModel.fromJson(e))
              .toList();
        },
        controller: _refreshController,
        builder: (items) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 20.w),
            itemBuilder: (context, index) {
              return _buildCard(items[index]);
            },
            separatorBuilder: (context, index) => 20.hb,
            itemCount: items.length,
          );
        },
      ),
    );
  }
}
