import 'package:akuCommunity/widget/bee_back_button.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeeScaffold extends StatefulWidget {
  final String title;
  final Widget body;

  /// appbar background color
  ///
  /// default Colors.white
  final Color bgColor;
  final List<Widget> actions;
  final Widget leading;
  final Widget bottomNavi;
  BeeScaffold(
      {Key key,
      @required this.title,
      this.body,
      this.actions,
      this.leading,
      this.bgColor,
      this.bottomNavi})
      : super(key: key);

  @override
  _BeeScaffoldState createState() => _BeeScaffoldState();
}

class _BeeScaffoldState extends State<BeeScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: widget.bgColor ?? Colors.white,
        elevation: 0,
        title:
            widget.title.text.size(32.sp).color(Color(0xFF333333)).bold.make(),
        centerTitle: true,
        leading: widget.leading ?? BeeBackButton(),
        actions: widget.actions,
      ),
      body: widget.body,
      bottomNavigationBar: widget.bottomNavi,
    );
  }
}
