import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/new_api.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/model/manager/questinnaire_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/manager/questionnaire/questionnaire_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/hive_store.dart';
import 'package:aku_new_community/utils/websocket/tips_dialog.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/stack_avatar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class QuestionnairePage extends StatefulWidget {
  QuestionnairePage({Key? key}) : super(key: key);

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  EasyRefreshController _easyRefreshController = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () async {
      var agreement = await HiveStore.appBox?.get('QuestionnairePage') ?? false;
      if (!agreement) {
        //await TipsDialog.tipsDialog();
        HiveStore.appBox!.put('QuestionnairePage', true);
      }
    });
  }

  String _getButtonText(int? status) {
    switch (status) {
      case 1:
        return '未开始';
      case 2:
        return '进行中';
      case 3:
        return '已结束';
      default:
        return '';
    }
  }

  Widget _buildCard(QuestionnaireModel model) {
    return GestureDetector(
      onTap: () {
        if(model.status==2){
          Get.to(() => QuestionnaireDetailPage(
            id: model.id,
            answered: model.answered,
          ));
        }else{
          BotToast.showText(text: '该问卷已结束或未开始');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          color: kForeGroundColor,
        ),
        width: double.infinity,
        // height: 236.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8.w)),
                  width: 160.w,
                  height: 120.w,
                  child: ClipRRect(
                    child: FadeInImage.assetNetwork(
                      placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                      image: SAASAPI.image(ImgModel.first(model.imgUrls)),
                    ),
                  ),
                ),
                20.w.widthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model.title!.text.black.size(28.sp).make(),
                    6.w.heightBox,
                    model.description!.text
                        .color(ktextSubColor)
                        .size(28.sp)
                        .maxLines(1)
                        .overflow(TextOverflow.ellipsis)
                        .make(),
                    6.w.heightBox,
                    RichText(
                        text: TextSpan(
                            text: '参与时间:',
                            style: TextStyle(
                              color: ktextSubColor,
                              fontSize: 24.sp,
                            ),
                            children: [
                          TextSpan(
                            style: TextStyle(
                              color: ktextPrimary,
                              fontSize: 24.sp,
                            ),
                            text: DateUtil.formatDateStr(model.beginDate!,
                                    format: "MM月dd日 HH:mm") +
                                '至' +
                                DateUtil.formatDateStr(model.endDate!,
                                    format: "MM月dd日 HH:mm"),
                          ),
                        ])),
                  ],
                ).expand()
              ],
            ),
            40.w.heightBox,
            Row(
              children: [
                StackAvatar(
                    avatars: model.headImgURls!.map((e) => e.url).toList()),
                26.w.widthBox,
                '${model.answerNum}人已参加'.text.black.size(20.sp).make(),
                Spacer(),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.w)),
                  color: model.status == 3 ? kDarkSubColor : kPrimaryColor,
                  minWidth: 120.w,
                  height: 44.w,
                  // padding:
                  //     EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.w),
                  elevation: 0,
                  onPressed: () {
                    if (model.status == 2) {
                      Get.to(() => QuestionnaireDetailPage(
                            id: model.id,
                            answered: model.answered,
                          ));
                    }
                  },
                  child: (_getButtonText(model.status))
                      .text
                      .black
                      .size(20.sp)
                      .bold
                      .make(),
                ),
              ],
            )
          ],
        ),
      ).material(color: Colors.transparent),
    );
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '问卷调查',
      body: BeeListView<QuestionnaireModel>(
          path: NEWAPI.questionnaire.list,
          controller: _easyRefreshController,
          convert: (model) {
            return model.rows
                .map((e) => QuestionnaireModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
                itemBuilder: (context, index) {
                  return _buildCard(items[index]);
                },
                separatorBuilder: (_, __) {
                  return 24.w.heightBox;
                },
                itemCount: items.length);
          }),
    );
  }
}
