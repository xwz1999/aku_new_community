// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/buttons/bee_single_check.dart';

class QuestionnaireTruefalse extends StatefulWidget {
  final String title;
  final int selected;
  final Function(int id) onPressed;
  QuestionnaireTruefalse({Key key, this.title, this.selected, this.onPressed})
      : super(key: key);

  @override
  _QuestionnaireTruefalseState createState() => _QuestionnaireTruefalseState();
}

class _QuestionnaireTruefalseState extends State<QuestionnaireTruefalse> {
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.onPressed(1);
                      },
                      child: BeeSingleCheck(
                        value: 1,
                        groupValue: widget.selected,
                      ),
                    ),
                    16.w.widthBox,
                    '正确'.text.black.size(28.sp).make(),
                  ],
                ).expand(flex: 1),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.onPressed(0);
                      },
                      child: BeeSingleCheck(
                        value: 0,
                        groupValue: widget.selected,
                      ),
                    ),
                    16.w.widthBox,
                    '错误'.text.black.size(28.sp).make(),
                  ],
                ).expand(flex: 1),
              ],
            ),
          )
        ],
      ),
    );
  }
}
