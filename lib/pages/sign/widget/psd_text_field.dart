import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PsdTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;

  const PsdTextField({
    Key? key,
    required this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  _PsdTextFieldState createState() => _PsdTextFieldState();
}

class _PsdTextFieldState extends State<PsdTextField> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 686.w,
      height: 94.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60.w),
        color: Colors.black.withOpacity(0.06),
      ),
      child: TextField(
        maxLength: 20,
        onChanged: (text) {
          setState(() {});
        },
        controller: widget.controller,
        obscureText: !visible,
        obscuringCharacter: '*',
        decoration: InputDecoration(
            isDense: false,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
            border: InputBorder.none,
            hintText: widget.hintText ?? '请输入密码',
            counterText: '',
            suffixIconConstraints:
                BoxConstraints(minHeight: 50.w, maxHeight: 50.w),
            suffixIcon: GestureDetector(
              onTap: () {
                visible = !visible;
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Icon(
                  visible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.25), fontSize: 28.sp)),
      ),
    );
  }
}
