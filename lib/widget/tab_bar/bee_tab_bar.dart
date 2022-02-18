import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeeTabBar extends StatefulWidget with PreferredSizeWidget {
  final TabController? controller;
  final List<String> tabs;
  final Function(int index)? onTap;
  final bool scrollable;

  BeeTabBar({
    Key? key,
    required this.controller,
    required this.tabs,
    this.onTap,
    this.scrollable = false,
  }) : super(key: key);

  @override
  _BeeTabBarState createState() => _BeeTabBarState();

  @override
  Size get preferredSize => Size.fromHeight(96.w);
}

class _BeeTabBarState extends State<BeeTabBar> {
  update() {
    if (widget.onTap != null) widget.onTap!(widget.controller!.index);
  }

  @override
  void initState() {
    super.initState();
    widget.controller!.addListener(update);
  }

  @override
  void dispose() {
    widget.controller!.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.controller,
      indicatorColor: Color(0xffffc40c),
      tabs: widget.tabs.map((e) => Tab(text: e)).toList(),
      onTap: widget.onTap,
      isScrollable: widget.scrollable,
    );
  }
}
