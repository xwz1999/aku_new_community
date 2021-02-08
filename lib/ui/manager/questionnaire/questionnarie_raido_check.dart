import 'package:akuCommunity/model/manager/questionnaire_detail_model.dart';
import 'package:akuCommunity/widget/buttons/bee_check_radio.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/utils/headers.dart';

class QuestionnaireRadioCheck extends StatefulWidget {
  final String title;
  final List<QuestionnaireChoiceVoList> answers;
  final List<int> selected;
  final Function(int id) onPressed;
  QuestionnaireRadioCheck(
      {Key key,
      @required this.title,
      @required this.answers,
      @required this.selected,
      @required this.onPressed})
      : super(key: key);

  @override
  _QuestionnaireRadioCheckState createState() =>
      _QuestionnaireRadioCheckState();
}

class _QuestionnaireRadioCheckState extends State<QuestionnaireRadioCheck> {
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
                            child: BeeCheckRadio(
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
                            child: BeeCheckRadio(
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
