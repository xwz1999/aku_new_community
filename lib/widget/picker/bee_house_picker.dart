import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/ui/profile/house/pick_my_house_page.dart';
import 'package:aku_community/utils/headers.dart';

class BeeHousePicker extends StatelessWidget {
  const BeeHousePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
      onPressed: () {
        Get.to(() => PickMyHousePage());
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
                S.of(context)!.tempPlotName.text.black.size(32.sp).bold.make(),
                10.w.heightBox,
                appProvider.selectedHouse!.roomName.text.black
                    .size(32.sp)
                    .bold
                    .make()
              ],
            ),
          ),
          Icon(CupertinoIcons.chevron_forward, size: 40.w),
        ],
      ),
    );
  }
}
