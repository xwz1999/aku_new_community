import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int _sex = 1;
  DateTime _birthday = DateTime.now();
  Widget _buildTile(String title, Widget suffix, {VoidCallback onPressed}) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      onPressed: onPressed,
      height: 96.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 34.sp,
          color: ktextPrimary,
        ),
        child: Row(
          children: [
            32.wb,
            title.text.make(),
            Spacer(),
            suffix ?? SizedBox(),
            24.wb,
            Icon(
              CupertinoIcons.chevron_forward,
              color: Color(0xFFDCDCDC),
              size: 32.w,
            ),
            16.wb,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return BeeScaffold(
      title: '个人资料',
      body: ListView(
        children: [
          _buildTile(
            '头像',
            CircleAvatar(),
            onPressed: () {},
          ),
          _buildTile(
            '姓名',
            userProvider.userInfoModel.name.text.make(),
            onPressed: () {},
          ),
          _buildTile(
            '昵称',
            userProvider.userInfoModel.nickName.text.make(),
            onPressed: () {},
          ),
          _buildTile(
            '手机号',
            TextUtil.hideNumber(userProvider.userInfoModel.tel).text.make(),
            onPressed: () {},
          ),
          _buildTile(
            '性别',
            userProvider.userInfoModel.sexValue.text.make(),
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: '请选择'.text.isIntrinsic.make(),
                    content: SizedBox(
                      child: CupertinoPicker(
                        itemExtent: 50,
                        onSelectedItemChanged: (index) {
                          _sex = index + 1;
                        },
                        children: [
                          '男'.text.isIntrinsic.make().centered(),
                          '女'.text.isIntrinsic.make().centered(),
                        ],
                        useMagnifier: true,
                      ),
                      height: 300.w,
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: '取消'.text.isIntrinsic.make(),
                        onPressed: Get.back,
                      ),
                      CupertinoDialogAction(
                        child: '确定'.text.isIntrinsic.make(),
                        onPressed: () {
                          userProvider.setSex(_sex);
                          Get.back();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          _buildTile(
            '出生日期',
            userProvider.userInfoModel.birthdayValue.text.make(),
            onPressed: () {
              Get.dialog(
                CupertinoAlertDialog(
                  title: '请选择'.text.isIntrinsic.make(),
                  content: SizedBox(
                    height: 340.w,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        maximumYear: DateTime.now().year,
                        minimumYear: 1900,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (date) {
                          _birthday = date;
                        },
                      ),
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: '取消'.text.isIntrinsic.make(),
                      onPressed: Get.back,
                    ),
                    CupertinoDialogAction(
                      child: '确定'.text.isIntrinsic.make(),
                      onPressed: () {
                        userProvider.setBirthday(_birthday);
                        Get.back();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ].sepWidget(
            separate: Divider(
          indent: 104.w,
          height: 1.w,
          thickness: 1.w,
          color: Color(0xFFEEEEEE),
        )),
      ),
    );
  }
}
