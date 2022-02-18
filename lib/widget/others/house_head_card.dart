import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/ui/profile/house/pick_my_house_page.dart';
import 'package:aku_new_community/utils/headers.dart';

class HouseHeadCard extends StatelessWidget {
  const HouseHeadCard({
    Key? key,
    required this.context,
    this.onChanged,
  }) : super(key: key);

  final BuildContext context;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Material(
      color: kForeGroundColor,
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '当前房屋'.text.black.size(28.sp).make(),
            32.w.heightBox,
            GestureDetector(
              onTap: () {
                Get.to(() => PickMyHousePage());
                if (onChanged != null) onChanged!();
              },
              child: Row(
                children: [
                  Image.asset(
                    R.ASSETS_ICONS_HOUSE_PNG,
                    width: 60.w,
                    height: 60.w,
                  ),
                  40.w.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        S
                            .of(context)!
                            .tempPlotName
                            .text
                            .black
                            .size(32.sp)
                            .bold
                            .make(),
                        10.w.heightBox,
                        appProvider.selectedHouse!.roomName.text.black
                            .size(32.sp)
                            .bold
                            .make()
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_forward,
                    size: 40.w,
                  ),
                ],
              ).material(color: Colors.transparent),
            ),
            24.w.heightBox,
          ],
        ),
      ),
    );
  }
}
