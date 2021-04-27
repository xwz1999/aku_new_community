import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/utils/headers.dart';

@Deprecated("DO NOT USE THIS WIDGET")
class CommonInput extends StatefulWidget {
  final TextEditingController? inputController;
  final String? hintText;
  final FormFieldValidator? validator;
  CommonInput({Key? key, this.inputController, this.hintText, this.validator})
      : super(key: key);

  @override
  _CommonInputState createState() => _CommonInputState();
}

class _CommonInputState extends State<CommonInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: widget.validator,
        cursorColor: Color(0xffffc40c),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: ktextPrimary,
          fontSize: BaseStyle.fontSize36,
        ),
        controller: widget.inputController,
        onChanged: (String value) {},
        maxLines: 1,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: 0.w,
            bottom: 0.w,
          ),
          hintText: widget.hintText,
          border: InputBorder.none, //去掉输入框的下滑线
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: BaseStyle.color999999,
            fontSize: BaseStyle.fontSize36,
          ),
        ),
      ),
    );
  }
}
