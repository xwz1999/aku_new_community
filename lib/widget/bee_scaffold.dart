import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/widget/bee_back_button.dart';

class BeeScaffold extends StatefulWidget {
  final String title;
  final Widget body;

  /// appbar background color
  ///
  /// default Colors.white
  final Color bgColor;

  final Color bodyColor;
  final List<Widget> actions;
  final Widget leading;
  final Widget bottomNavi;
  final PreferredSizeWidget appBarBottom;
  final FloatingActionButton fab;
  BeeScaffold({
    Key key,
    @required this.title,
    this.body,
    this.actions,
    this.leading,
    this.bgColor = Colors.white,
    this.bodyColor = const Color(0xFFF9F9F9),
    this.bottomNavi,
    this.appBarBottom,
    this.fab,
  }) : super(key: key);

  BeeScaffold.white({
    Key key,
    @required this.title,
    this.body,
    this.actions,
    this.leading,
    this.bgColor = Colors.white,
    this.bottomNavi,
    this.appBarBottom,
    this.fab,
  })  : this.bodyColor = Colors.white,
        super(key: key);

  @override
  _BeeScaffoldState createState() => _BeeScaffoldState();
}

class _BeeScaffoldState extends State<BeeScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bodyColor,
      appBar: AppBar(
        backgroundColor: widget.bgColor,
        title: widget.title.text.make(),
        leading: widget.leading ?? BeeBackButton(),
        actions: widget.actions,
        bottom: widget.appBarBottom,
      ),
      body: widget.body,
      bottomNavigationBar: widget.bottomNavi,
      floatingActionButton: widget.fab,
    );
  }
}
