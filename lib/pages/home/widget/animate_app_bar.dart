import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:akuCommunity/provider/app_provider.dart';

class AnimateAppBar extends StatefulWidget with PreferredSizeWidget {
  final ScrollController scrollController;
  final List<Widget> actions;
  AnimateAppBar({Key key, this.scrollController, this.actions})
      : super(key: key);

  @override
  _AnimateAppBarState createState() => _AnimateAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _AnimateAppBarState extends State<AnimateAppBar> {
  Color _bgColor = Colors.transparent;
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      setState(() {
        _bgColor = widget.scrollController.offset > 30
            ? Color(0xFFFFBD00)
            : widget.scrollController.offset < 0
                ? Colors.transparent
                : Color(0xFFFFBD00)
                    .withOpacity((widget.scrollController.offset / 30));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return AppBar(
      title: Text( S.of(context).tempPlotName),
      backgroundColor: _bgColor,
      leading: Container(
        margin: EdgeInsets.only(left: 32.w),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appProvider?.location['city'] ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  color: Color(0xff333333),
                ),
              ),
              Text(
                '${appProvider.weatherType} ${appProvider.weatherTemp}℃',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Color(0xff333333),
                ),
              )
            ]),
      ),
      actions: widget.actions,
    );
  }
}
