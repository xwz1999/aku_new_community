import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aku_community/pages/express_packages/express_package_card.dart';

class ExpressPackageView extends StatefulWidget {
  final int index;
  ExpressPackageView({Key? key, required this.index}) : super(key: key);

  @override
  _ExpressPackageViewState createState() => _ExpressPackageViewState();
}

class _ExpressPackageViewState extends State<ExpressPackageView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 32.w),
      children: [ExpressPackageCard(index: widget.index)],
    );
  }
}
