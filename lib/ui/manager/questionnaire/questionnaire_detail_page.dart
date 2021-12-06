import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/app_theme.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/model/manager/questionnaire_detail_model.dart';
import 'package:aku_new_community/model/manager/quetionnaire_submit_model.dart';
import 'package:aku_new_community/pages/manager_func.dart';
import 'package:aku_new_community/ui/manager/questionnaire/questionnaire_siglecheck.dart';
import 'package:aku_new_community/ui/manager/questionnaire/questionnaire_truefalse.dart';
import 'package:aku_new_community/ui/manager/questionnaire/questionnarie_raido_check.dart';
import 'package:aku_new_community/ui/manager/questionnaire/submit_complish_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class QuestionnaireDetailPage extends StatefulWidget {
  final int? id;
  final int? status;

  QuestionnaireDetailPage({Key? key, this.id, this.status}) : super(key: key);

  @override
  _QuestionnaireDetailPageState createState() =>
      _QuestionnaireDetailPageState();
}

class _QuestionnaireDetailPageState extends State<QuestionnaireDetailPage> {
  late QuestionnaireDetialModel _model;
  bool _onload = true;

  List<AppQuestionnaireAnswerSubmits> _submitModels = [];

  Widget _emptyWidget() {
    return Container();
  }

  Widget _expandedCheck(String title, List<QuestionnaireChoiceVoList>? answers,
      List<AppQuestionnaireAnswerSubmits> submitModels, int index) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title.text.black.size(32.sp).bold.make(),
          64.w.heightBox,
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                CupertinoActionSheet(
                  // title: ,
                  cancelButton: CupertinoActionSheetAction(
                    child: '取消'.text.black.size(28.sp).make(),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  actions: answers!
                      .map((e) => CupertinoActionSheetAction(
                          onPressed: () {
                            submitModels[index].choiceAnswer!.first = e.id;
                            submitModels[index].shortAnswer = e.answer;
                            Get.back();
                            setState(() {});
                          },
                          child: e.answer!.text.black
                              .size(28.sp)
                              .isIntrinsic
                              .make()))
                      .toList(),
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //     border: Border(
                  //         bottom: BorderSide(
                  //             width: 1.w, color: Color(0xFFE8E8E8)))),
                  height: 96.w,
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 28.w),
                  child: (submitModels[index].shortAnswer ?? '请选择')
                      .text
                      .color(ktextSubColor)
                      .size(28.sp)
                      .make(),
                ).expand(),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: Color(0xFFD8D8D8),
                  size: 40.w,
                ),
              ],
            ),
          ),
          BeeDivider.horizontal()
        ],
      ),
    );
  }

  Widget _shortAnswer(String title,
      List<AppQuestionnaireAnswerSubmits> submitModels, int index) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title.text.color(ktextPrimary).size(28.sp).make(),
          24.w.heightBox,
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.w,
                color: Color(0xFFD4CFBE),
              ),
              borderRadius: BorderRadius.circular(8.w),
            ),
            child: TextField(
              minLines: 5,
              maxLines: 10,
              scrollPadding: EdgeInsets.zero,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 28.w),
                  isDense: true),
              onChanged: (value) {
                submitModels[index].shortAnswer = value;
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _topicWidget(QuestionnaireTopicVoList questionModel,
      List<AppQuestionnaireAnswerSubmits> submitModels, int index) {
    switch (questionModel.type) {
      case 1:
        return QuestionnaireSingleCheck(
            title: questionModel.topic,
            selected: submitModels[index].choiceAnswer!.first,
            onPressed: (id) {
              submitModels[index].choiceAnswer!.first = id;
              setState(() {});
            },
            answers: questionModel.questionnaireChoiceVoList);

      case 2:
        submitModels[index].choiceAnswer!.remove(-1);
        return QuestionnaireRadioCheck(
          title: questionModel.topic,
          selected: submitModels[index].choiceAnswer,
          answers: questionModel.questionnaireChoiceVoList,
          onPressed: (id) {
            if (submitModels[index].choiceAnswer!.contains(id)) {
              submitModels[index].choiceAnswer!.remove(id);
            } else {
              submitModels[index].choiceAnswer!.add(id);
            }
            setState(() {});
          },
        );

      case 3:
        return _expandedCheck(questionModel.topic!,
            questionModel.questionnaireChoiceVoList, submitModels, index);
      case 4:
        return QuestionnaireTruefalse(
          title: questionModel.topic,
          selected: submitModels[index].choiceAnswer!.first,
          onPressed: (id) {
            submitModels[index].choiceAnswer!.first = id;
            setState(() {});
          },
        );
      case 5:
        return _shortAnswer(questionModel.topic!, submitModels, index);

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '问卷调查',
      systemStyle: SystemStyle.yellowBottomBar,
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          _model = await ManagerFunc.questionnairefindById(widget.id);
          _onload = false;
          _submitModels = _model.questionnaireTopicVoList!
              .map((e) => AppQuestionnaireAnswerSubmits(
                    topicId: e.id,
                    choiceAnswer: [-1],
                  ))
              .toList();
          print(_submitModels);
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
                    clipBehavior: Clip.antiAlias,
                    child: FadeInImage.assetNetwork(
                      placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                      image: API.image(
                        ImgModel.first(_model.voResourcesImgList),
                      ),
                    ),
                  ),
                  40.w.heightBox,
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: _model.title!.text
                          .color(ktextPrimary)
                          .size(32.sp)
                          .bold
                          .make()),
                  36.w.heightBox,
                  _model.description!.text
                      .color(ktextPrimary)
                      .size(28.sp)
                      .make(),
                  130.w.heightBox,
                  ...List.generate(
                      _model.questionnaireTopicVoList!.length,
                      (index) => _topicWidget(
                          _model.questionnaireTopicVoList![index],
                          _submitModels,
                          index)).sepWidget(separate: 80.w.heightBox),
                ],
              ),
      ),
      bottomNavi: BottomButton(
        child: '确认提交'
            .text
            .color(widget.status != 2 ? ktextSubColor : ktextPrimary)
            .size(32.sp)
            .bold
            .make(),
        onPressed: widget.status != 2
            ? () {}
            : () async {
                BaseModel baseModel = await ManagerFunc.questionnaireSubmit(
                    widget.id, _submitModels);
                Get.to(() => SubmitComplishPage(
                      status: baseModel.status,
                      message: baseModel.message,
                    ));
              },
      ),
    );
  }
}
