import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AddHouseButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool hollow;

  const AddHouseButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.hollow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 686.w,
      height: 93.w,
      color: hollow ? Colors.white : Color(0xFFFAC058),
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
          side: hollow
              ? BorderSide(color: Colors.black.withOpacity(0.25))
              : BorderSide.none),
      onPressed: onTap,
      child: text.text.size(32.sp).black.bold.make(),
    );
  }
}
