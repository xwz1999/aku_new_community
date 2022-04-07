import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/profile/new_house/my_house_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

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
    UserProvider userProvider = Provider.of<UserProvider>(context);
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
                Get.to(() => MyHousePage());
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
                        UserTool.userProvider.userInfoModel!.communityName.text
                            .black
                            .size(32.sp)
                            .bold
                            .make(),
                        10.w.heightBox,
                        (userProvider.defaultHouse != null
                                ? (userProvider.defaultHouse!.buildingName +
                                    '栋-' +
                                    userProvider.defaultHouse!.unitName +
                                    '单元-' +
                                    userProvider.defaultHouse!.estateName +
                                    '室')
                                : '')
                            .text
                            .black
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
