import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class SubmitEquipmentCodePage extends StatefulWidget {
  const SubmitEquipmentCodePage({Key? key}) : super(key: key);

  @override
  _SubmitEquipmentCodePageState createState() =>
      _SubmitEquipmentCodePageState();
}

class _SubmitEquipmentCodePageState extends State<SubmitEquipmentCodePage> {
  TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
        title: 'x5手环',
        bodyColor: Colors.white,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            children: [
              96.w.heightBox,
              Assets.bracelet.xiaomi6.image(width: 520.w, height: 520.w),
              80.w.heightBox,
              Container(
                width: 686.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(50.w),
                ),
                child: TextField(
                  controller: _editingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入设备码/设备ID',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.w),
                    hintStyle: TextStyle(
                        fontSize: 28.sp, color: Colors.black.withOpacity(0.25)),
                  ),
                ),
              ),
              28.w.heightBox,
              '设备码一般在包装底部或两侧条形码附近，以纯数字或数字+字母的形式排列。'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make()
            ],
          ),
        ),
        bottomNavi: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
          child: MaterialButton(
            onPressed: () {
              if (_editingController.text.isEmpty) {
                BotToast.showText(text: '设备码不能为空');
                return;
              }
              BotToast.showText(text: '请输入正确的设备码');
            },
            elevation: 0,
            color: Color(0xFF6395D7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(54.w),
            ),
            minWidth: 686.w,
            height: 94.w,
            child: '提交'.text.size(28.sp).color(Colors.white).make(),
          ),
        ));
  }
}
