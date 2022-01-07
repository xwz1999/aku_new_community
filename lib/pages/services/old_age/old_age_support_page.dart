import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class OldAgeSupportPage extends StatefulWidget {
  const OldAgeSupportPage({Key? key}) : super(key: key);

  @override
  _OldAgeSupportPageState createState() => _OldAgeSupportPageState();
}

class _OldAgeSupportPageState extends State<OldAgeSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '智慧养老'.text.size(32.sp).black.make(),
        backgroundColor: Colors.transparent,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(),
      ),
    );
  }
}
