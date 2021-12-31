import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/widget/bee_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class RuleExplainPage extends StatefulWidget {
  const RuleExplainPage({Key? key}) : super(key: key);

  @override
  _RuleExplainPageState createState() => _RuleExplainPageState();
}

class _RuleExplainPageState extends State<RuleExplainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: '规则说明'.text.size(32.sp).white.make(),
        leading: BeeBackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xFFF9F9F9),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF565F6E).withOpacity(0.85),
                  Color(0xFF131E30).withOpacity(0.85)
                ])),
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 60.w),
        child: Assets.static.ruleExplain.image(),
      ),
    );
  }
}
