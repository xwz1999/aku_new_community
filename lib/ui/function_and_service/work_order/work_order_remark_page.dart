import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/utils/hive_store.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';

class WorkOrderRemarkPage extends StatefulWidget {
  final String? text;

  const WorkOrderRemarkPage({Key? key, this.text}) : super(key: key);

  @override
  _WorkOrderRemarkPageState createState() => _WorkOrderRemarkPageState();
}

class _WorkOrderRemarkPageState extends State<WorkOrderRemarkPage> {
  TextEditingController _contentController = TextEditingController();
  List<String> _shortcutLabel = [];
  bool _edit = false;

  @override
  void initState() {
    _shortcutLabel =
        HiveStore.workOrderShortBox!.values.cast<String>().toList();
    if (widget.text != null) {
      _contentController.text = widget.text!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '添加需求',
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    '具体需求'
                        .text
                        .size(28.sp)
                        .color(Colors.black.withOpacity(0.45))
                        .make(),
                  ],
                ),
                32.w.heightBox,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16.w)),
                  child: TextField(
                    controller: _contentController,
                    autofocus: false,
                    onChanged: (text) => setState(() {}),
                    minLines: 5,
                    maxLength: 200,
                    maxLines: 20,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                32.w.heightBox,
                Row(
                  children: [
                    '快捷标签'
                        .text
                        .size(24.sp)
                        .color(Colors.black.withOpacity(0.45))
                        .make(),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        _edit = !_edit;
                        setState(() {});
                      },
                      child: Material(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            '${_edit ? '保存' : '编辑'}'
                                .text
                                .size(24.sp)
                                .color(Colors.black.withOpacity(0.45))
                                .make(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                32.w.heightBox,
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.w,
                  children: _shortcutLabel
                      .mapIndexed((currentValue, index) =>
                          label(currentValue, _edit, index))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavi: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
        child: BeeLongButton(
          onPressed: () async {
            var inBox = _shortcutLabel.contains(_contentController.text);
            if (!inBox && _contentController.text.isNotEmpty) {
              await HiveStore.workOrderShortBox!.add(_contentController.text);
            }
            Get.back(result: _contentController.text);
          },
          text: '完成',
        ),
      ),
    );
  }

  Widget label(String text, bool edit, int index) {
    var textHandled = '';
    if (text.length > 10) {
      textHandled = text.replaceRange(10, null, '…');
    } else {
      textHandled = text;
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            _contentController.text = text;
            setState(() {});
          },
          child: Material(
            color: Colors.transparent,
            child: FittedBox(
              child: Container(
                height: 60.w,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.25)),
                    borderRadius: BorderRadius.circular(8.w)),
                child: textHandled.text
                    .size(22.sp)
                    .color(Colors.black.withOpacity(0.45))
                    .make(),
              ),
            ),
          ),
        ),
        if (edit)
          Positioned(
              top: -10.w,
              right: -10.w,
              child: GestureDetector(
                onTap: () {
                  _shortcutLabel.removeAt(index);
                  HiveStore.workOrderShortBox!.deleteAt(index);
                  setState(() {});
                },
                child: Material(
                  child: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    size: 40.w,
                    color: Colors.black.withOpacity(0.45),
                  ),
                ),
              ))
      ],
    );
  }
}
