// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyrefresh/easy_refresh.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/questinnaire_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/ui/manager/questionnaire/questionnaire_detail_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/others/stack_avatar.dart';

class QuestionnairePage extends StatefulWidget {
  QuestionnairePage({Key key}) : super(key: key);

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  EasyRefreshController _easyRefreshController;
  @override
  void initState() {
    super.initState();
  }

  String _getButtonText(int status) {
    switch (status) {
      case 1:
      case 2:
        return '去投票';
      case 3:
        return '已结束';
      case 4:
        return '已投票';
      default:
        return '';
    }
  }

  Widget _buildCard(QuestionnaireModel model) {
    return Container(
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
                      placeholder: R.ASSETS_IMAGES_LOGO_PNG,
                      image: API.image(model.imgUrls.first.url)),
                ),
              ),
              20.w.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  model.title.text.black.size(28.sp).make(),
                  6.w.heightBox,
                  model.description.text
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
                          text: model.beginDate + '至' + model.endDate,
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
                  avatars: model.headImgURls.map((e) => e.url).toList()),
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
                  QuestionnaireDetailPage(id: model.id,).to();
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '问卷调查',
      body: BeeListView(
          path: API.manager.questionnaireList,
          controller: _easyRefreshController,
          convert: (model) {
            return model.tableList
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
