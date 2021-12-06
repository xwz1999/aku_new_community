import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BeeInputRow extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final String? hintText;
  final bool isRequire;

  //输入框还是按钮（点击弹窗选择
  final bool isButton;

  //是按钮时的回调
  final VoidCallback? onPressed;

  BeeInputRow({
    Key? key,
    required this.title,
    required this.controller,
    this.formatters,
    required this.hintText,
    this.isRequire = false,
  })  : this.isButton = false,
        this.onPressed = null,
        super(key: key);

  BeeInputRow.button(
      {Key? key,
      required this.title,
      required this.hintText,
      this.isRequire = false,
      required this.onPressed})
      : this.isButton = true,
        this.formatters = null,
        this.controller = null,
        super(key: key);

  @override
  _BeeInputRowState createState() => _BeeInputRowState();
}

class _BeeInputRowState extends State<BeeInputRow> {
  @override
  Widget build(BuildContext context) {
    var bottom = widget.isButton
        ? GestureDetector(
            onTap: widget.onPressed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  // padding: EdgeInsets.only(top: 4.w),
                  child: widget.hintText!.text
                      .size(36.sp)
                      .color(ktextSubColor)
                      .bold
                      .make(),
                ),
                BeeDivider.horizontal()
              ],
            ),
          )
        : TextField(
            inputFormatters: widget.formatters,
            controller: widget.controller,
            textAlign: TextAlign.start,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: widget.hintText ?? '',
              isDense: true,
              contentPadding: EdgeInsets.zero,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 2.w),
              ),
            ),
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              color: ktextPrimary,
            ),
          );
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.title.text.size(28.sp).color(ktextPrimary).make(),
              10.w.widthBox,
              (widget.isRequire ? '*' : '')
                  .text
                  .size(28.sp)
                  .color(Colors.red)
                  .make()
            ],
          ),
          24.w.heightBox,
          bottom,
        ],
      ),
    );
  }
}
