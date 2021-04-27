import 'package:flutter/material.dart';

import 'package:aku_community/model/manager/questionnaire_detail_model.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/buttons/bee_single_check.dart';

class QuestionnaireSingleCheck extends StatefulWidget {
  final String title;
  final List<QuestionnaireChoiceVoList> answers;
  final int selected;
  final Function(int id) onPressed;
  QuestionnaireSingleCheck(
      {Key key,
      @required this.title,
      @required this.answers,
      @required this.selected,
      @required this.onPressed})
      : super(key: key);

  @override
  _QuestionnaireSingleCheckState createState() =>
      _QuestionnaireSingleCheckState();
}

class _QuestionnaireSingleCheckState extends State<QuestionnaireSingleCheck> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.text.black.size(32.sp).bold.make(),
          64.w.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 96.w),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...widget.answers.oddList().map((e) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.onPressed(e.id);
                            },
                            child: BeeSingleCheck(
                              value: e.id,
                              groupValue: widget.selected,
                            ),
                          ),
                          16.w.widthBox,
                          e.answer.text.black.size(28.sp).make(),
                        ],
                      );
                    }).toList(),
                  ].sepWidget(separate: 48.w.heightBox),
                ).expand(flex: 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...widget.answers.evenList().map((e) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.onPressed(e.id);
                            },
                            child: BeeSingleCheck(
                              value: e.id,
                              groupValue: widget.selected,
                            ),
                          ),
                          16.w.widthBox,
                          e.answer.text.black.size(28.sp).make(),
                        ],
                      );
                    }).toList(),
                  ].sepWidget(separate: 48.w.heightBox),
                ).expand(flex: 1),
              ],
            ),
          )
        ],
      ),
    );
  }
}
