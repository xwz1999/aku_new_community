import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class TelTextField extends StatefulWidget {
  final TextEditingController controller;
  const TelTextField({Key? key, required this.controller}) : super(key: key);

  @override
  _TelTextFieldState createState() => _TelTextFieldState();
}

class _TelTextFieldState extends State<TelTextField> {
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
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        controller: widget.controller,
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          prefixIcon: Center(child: '+86｜'.text.black.make()),
          prefixIconConstraints: BoxConstraints.loose(Size(60, 60)),
          contentPadding: EdgeInsets.symmetric(vertical: 30.w),
          hintText: '点击输入手机号',
          hintStyle:
              TextStyle(color: Colors.black.withOpacity(0.25), fontSize: 28.sp),
        ),
      ),
    );
  }
}
