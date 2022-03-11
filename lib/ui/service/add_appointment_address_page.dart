import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAppointmentAddressPage extends StatefulWidget {
  const AddAppointmentAddressPage({Key? key}) : super(key: key);

  @override
  _AddAppointmentAddressPageState createState() =>
      _AddAppointmentAddressPageState();
}

class _AddAppointmentAddressPageState extends State<AddAppointmentAddressPage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '添加预约地址',
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(32.w),
              child: Column(
                children: [
                  //TODO:封装高德search api插件 以获取poi数据 暂时手动输入
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Material(
                  //     color: Colors.transparent,
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           width: 170.w,
                  //           child: '所在地'
                  //               .text
                  //               .size(28.sp)
                  //               .color(Colors.black.withOpacity(0.65))
                  //               .make(),
                  //         ),
                  //         '${S.of(context)?.tempPlotName}(默认)'
                  //             .text
                  //             .size(28.sp)
                  //             .color(Colors.black.withOpacity(0.65))
                  //             .make(),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Row(
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: '标志建筑'
                            .text
                            .size(28.sp)
                            .color(Colors.black.withOpacity(0.65))
                            .make(),
                      ),
                      Expanded(
                          child: TextField(
                        autofocus: false,
                        controller: _tagController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '请输入标志建筑',
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.45),
                              fontSize: 28.sp,
                            )),
                      )),
                    ],
                  ),

                  32.hb,
                  BeeDivider.horizontal(),
                  32.hb,
                  Row(
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: '具体地址'
                            .text
                            .size(28.sp)
                            .color(Colors.black.withOpacity(0.65))
                            .make(),
                      ),
                      Expanded(
                          child: TextField(
                        autofocus: false,
                        controller: _controller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '请输入具体地址',
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.45),
                              fontSize: 28.sp,
                            )),
                      )),
                    ],
                  )
                ],
              ),
            ),
            56.hb,
            BeeLongButton(
                onPressed: () {
                  Get.back(result: {
                    'address': _tagController.text,
                    'addressDetail': _controller.text,
                  });
                },
                text: '提交'),
          ],
        ),
      ),
    );
  }
}