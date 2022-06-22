import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:flutter/material.dart';

class BeeCustomDialog extends StatelessWidget {
  final List<Widget> actions;
  final Widget content;
  final double? width;
  final double? height;

  const BeeCustomDialog(
      {Key? key,
      required this.actions,
      required this.content,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width ?? 600.w,
        height: height ?? 700.w,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.w),
        ),
        child: Material(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  0,
                  0.35,
                ],
                    colors: [
                  Color(0x33FBE541),
                  Color(0x33FBE541).withOpacity(0.01),

                  //Colors.white,
                ])),
            child: Column(
              children: [
                content,
                Spacer(),
                BeeDivider.horizontal(),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 100.w),
                  child: Row(
                    children: actions
                        .map((e) => Expanded(child: e))
                        .toList()
                        .sepWidget(
                          separate: Container(
                            width: 2.w,
                            height: double.infinity,
                            color: Color(0xFFF0F0F0),
                          ),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
