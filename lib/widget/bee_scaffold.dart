import 'package:aku_new_community/constants/app_theme.dart';
import 'package:aku_new_community/widget/bee_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BeeScaffold extends StatelessWidget {
  final dynamic title;
  final Widget? body;

  /// appbar background color
  ///
  /// default Colors.white
  final Color bgColor;

  final Color bodyColor;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? bottomNavi;
  final PreferredSizeWidget? appBarBottom;
  final FloatingActionButton? fab;
  final double? titleSpacing;

  final SystemUiOverlayStyle systemStyle;

  BeeScaffold({
    Key? key,
    this.title,
    this.body,
    this.actions,
    this.leading,
    this.bgColor = Colors.white,
    this.bodyColor = const Color(0xFFF9F9F9),
    this.bottomNavi,
    this.appBarBottom,
    this.fab,
    this.titleSpacing,
    this.systemStyle = SystemStyle.initial,
  }) : super(key: key);

  BeeScaffold.white({
    Key? key,
    required this.title,
    this.body,
    this.actions,
    this.leading,
    this.bgColor = Colors.white,
    this.bottomNavi,
    this.appBarBottom,
    this.fab,
    this.titleSpacing,
    this.systemStyle = SystemStyle.initial,
  })  : this.bodyColor = Colors.white,
        super(key: key);

  Widget? get _titleWidget {
    if (title == null) return null;
    if (title is String) return Text(title!);
    if (title is Widget) return title as Widget;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Widget? appBar;
    if (title != null)
      appBar = AppBar(
        backgroundColor: bgColor,
        title: _titleWidget,
        leading: leading ?? BeeBackButton(),
        actions: actions,
        bottom: appBarBottom,
        titleSpacing: titleSpacing,
      );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemStyle,
      child: Scaffold(
        backgroundColor: bodyColor,
        appBar: appBar as PreferredSizeWidget?,
        body: body,
        bottomNavigationBar: bottomNavi,
        floatingActionButton: fab,
      ),
    );
  }
}
