import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/utils/headers.dart';

class AnimateAppBar extends StatefulWidget with PreferredSizeWidget {
  final ScrollController? scrollController;
  final List<Widget>? actions;

  AnimateAppBar({Key? key, this.scrollController, this.actions})
      : super(key: key);

  @override
  _AnimateAppBarState createState() => _AnimateAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(45);
}

class _AnimateAppBarState extends State<AnimateAppBar> {
  Color _bgColor = Colors.white;

  @override
  void initState() {
    super.initState();
    widget.scrollController!.addListener(() {
      setState(() {
        _bgColor = widget.scrollController!.offset > 30
            ? Colors.white
            : widget.scrollController!.offset < 0
                ? Colors.transparent
                : Colors.white
                    .withOpacity((widget.scrollController!.offset / 30));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: AppBar(
        titleSpacing: 10.0,

        title: Row(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (appProvider.location != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2,right: 5),
                  child: Image.asset(
                    R.ASSETS_ICONS_ICON_MAIN_LOCATION_PNG,
                    width: 32.w,
                    height: 32.w,
                  ),
                ),
                Text(
                  appProvider.location!['city'] as String? ?? '',
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
        backgroundColor: _bgColor,
        actions: widget.actions,
      ),
    );
  }
}
