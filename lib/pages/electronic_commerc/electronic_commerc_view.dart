import 'package:aku_community/pages/electronic_commerc/electronic_commerc_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElectronicCommercView extends StatefulWidget {
  final int index;
  ElectronicCommercView({Key? key, required this.index}) : super(key: key);

  @override
  _ElectronicCommercViewState createState() => _ElectronicCommercViewState();
}

class _ElectronicCommercViewState extends State<ElectronicCommercView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 24.w,horizontal: 32.w),
      children: [
        ElectronicCommercCard(index: widget.index),
      ],
    );
  }
}
