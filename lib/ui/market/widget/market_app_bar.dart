import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/utils/headers.dart';

class MarketAppBar extends StatefulWidget with PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget bottom;

  MarketAppBar({Key? key,this.actions, this.flexibleSpace, required this.bottom})
      : super(key: key);

  @override
  _MarketAppBarState createState() => _MarketAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(530.w);
}

class _MarketAppBarState extends State<MarketAppBar> {
  Color _bgColor = Colors.white;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return PreferredSize(

      preferredSize: Size.fromHeight(60.w),
      child: AppBar(
        titleSpacing: 10.0,
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (appProvider.location != null)
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Image.asset(
                    R.ASSETS_ICONS_SHOP_LOCATION_PNG,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
                Text(
                  appProvider.location?['city']==null?'':appProvider.location?['city'] as String? ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 28.sp,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
            ]),
        backgroundColor: Colors.transparent,
        actions: widget.actions,
        flexibleSpace: widget.flexibleSpace,
        bottom: widget.bottom,
      ),
    );
  }
}
