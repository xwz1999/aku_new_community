import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/utils/headers.dart';

class AnimateAppBar extends StatefulWidget with PreferredSizeWidget {
  final ScrollController? scrollController;
  final List<Widget>? actions;
  final ValueNotifier<Color> bgColor;

  AnimateAppBar(
      {Key? key, this.scrollController, this.actions, required this.bgColor})
      : super(key: key);

  @override
  _AnimateAppBarState createState() => _AnimateAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(45);
}

class _AnimateAppBarState extends State<AnimateAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return ValueListenableBuilder(
      valueListenable: widget.bgColor,
      builder: (context, color, child) {
        return AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: widget.bgColor.value,
              statusBarIconBrightness: Brightness.light),
          titleSpacing: 10.0,
          title: child,
          backgroundColor: widget.bgColor.value,
          actions: widget.actions,
        );
      },
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        if (appProvider.location != null)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Image.asset(
              R.ASSETS_ICONS_ICON_MAIN_LOCATION_PNG,
              width: 32.w,
              height: 32.w,
            ),
          ),
        Text(
          appProvider.location?['city'] == null
              ? ''
              : appProvider.location?['city'] as String? ?? '',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
            color: Color(0xff333333),
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '(${appProvider.weatherType} ${appProvider.weatherTemp}℃)',
          style: TextStyle(
            fontSize: 24.sp,
            color: Color(0xff999999),
          ),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
