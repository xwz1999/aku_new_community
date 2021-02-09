import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/life_pay/widget/my_house_page.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/bee_parse.dart';
import 'package:akuCommunity/widget/bee_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:akuCommunity/utils/headers.dart';

class BeeHeaderHouse extends StatefulWidget {
  BeeHeaderHouse({Key key}) : super(key: key);

  @override
  _BeeHeaderHouseState createState() => _BeeHeaderHouseState();
}

class _BeeHeaderHouseState extends State<BeeHeaderHouse> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '当前房屋'.text.black.size(28.sp).make(),
            32.w.heightBox,
            GestureDetector(
              onTap: () {
                MyHousePage(
                  needFindPayTag: true,
                ).to();
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
                        kEstateName.text.black.size(32.sp).bold.make(),
                        10.w.heightBox,
                        userProvider.currentHouse
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
            BeeDivider.horizontal()
          ],
        ),
      ),
    );
  }
}
