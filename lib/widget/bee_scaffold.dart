import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/constants/app_theme.dart';
import 'package:akuCommunity/widget/bee_back_button.dart';

class BeeScaffold extends StatelessWidget {
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

  final SystemUiOverlayStyle systemStyle;
  BeeScaffold({
    Key key,
    this.title,
    this.body,
    this.actions,
    this.leading,
    this.bgColor = Colors.white,
    this.bodyColor = const Color(0xFFF9F9F9),
    this.bottomNavi,
    this.appBarBottom,
    this.fab,
    this.systemStyle = SystemStyle.initial,
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
    this.systemStyle = SystemStyle.initial,
  })  : this.bodyColor = Colors.white,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget appBar;
    if (title != null)
      appBar = AppBar(
        backgroundColor: bgColor,
        title: title.text.make(),
        leading: leading ?? BeeBackButton(),
        actions: actions,
        bottom: appBarBottom,
      );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemStyle,
      child: Scaffold(
        backgroundColor: bodyColor,
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavi,
        floatingActionButton: fab,
      ),
    );
  }
}
