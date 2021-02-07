import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/questionnaire_detail_model.dart';
import 'package:akuCommunity/pages/manager_func.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/buttons/bee_single_check.dart';
import 'package:akuCommunity/widget/buttons/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class QuestionnaireDetailPage extends StatefulWidget {
  final int id;
  QuestionnaireDetailPage({Key key, this.id}) : super(key: key);

  @override
  _QuestionnaireDetailPageState createState() =>
      _QuestionnaireDetailPageState();
}

class _QuestionnaireDetailPageState extends State<QuestionnaireDetailPage> {
  QuestionnaireDetialModel _model;
  bool _onload = true;

  Widget _emptyWidget() {
    return Container();
  }

  Widget _singleCheck(String title, List<QuestionnaireChoiceVoList> answers) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title.text.black.size(32.sp).bold.make(),
          64.w.heightBox,
          Flex(
            direction: Axis.horizontal,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...answers.oddList().map((e){
                    return Row(
                      children: [
                        BeeSingleCheck(
                          value: e.id,
                          groupValue: ,
                        ),
                      ],
                    );
                  }).toList(),
                ].sepWidget(separate: 48.w.heightBox),
              ).expand(flex: 1),
              Column(
                children: [],
              ).expand(flex: 1),
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
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          _model = await ManagerFunc.questionnairefindById(widget.id);
          _onload = false;
          setState(() {});
        },
        child: _onload
            ? _emptyWidget()
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    width: double.infinity,
                    height: 228.w,
                    clipBehavior: Clip.antiAlias,
                    child: FadeInImage.assetNetwork(
                        placeholder: R.ASSETS_IMAGES_LOGO_PNG,
                        image: API.image(_model.voResourcesImgList.first.url)),
                  ),
                  40.w.heightBox,
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: _model.title.text
                          .color(ktextPrimary)
                          .size(32.sp)
                          .bold
                          .make()),
                  36.w.heightBox,
                  _model.description.text
                      .color(ktextPrimary)
                      .size(28.sp)
                      .make(),
                  130.w.heightBox,
                  _singleCheck(
                      'title',
                      _model.questionnaireTopicVoList.first
                          .questionnaireChoiceVoList)
                ],
              ),
      ),
      bottomNavi: BottomButton(
        child: '确认提交'.text.black.size(32.sp).bold.make(),
        onPressed: () {},
      ),
    );
  }
}
