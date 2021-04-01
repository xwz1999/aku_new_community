import 'package:akuCommunity/constants/app_values.dart';
import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/ui/profile/house/pick_my_house_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/life_pay/widget/my_house_page.dart';
import 'package:akuCommunity/pages/manager_func.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/ui/manager/visitor/visitor_record_page.dart';
import 'package:akuCommunity/utils/bee_parse.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_divider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/common_input.dart';
import 'package:akuCommunity/widget/picker/bee_date_picker.dart';

class VisitorAccessPage extends StatefulWidget {
  VisitorAccessPage({Key key}) : super(key: key);

  @override
  _VisitorAccessPageState createState() => _VisitorAccessPageState();
}

class _VisitorAccessPageState extends State<VisitorAccessPage> {
  TextEditingController _userName = new TextEditingController();
  TextEditingController _userCarNum = new TextEditingController();
  DateTime dateTime;
  int _selectSex = 1;

  Widget _buildHouseCard(
    String title,
    String detail,
  ) {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '来访房屋'.text.black.size(28.sp).make(),
          32.w.heightBox,
          GestureDetector(
            onTap: () {
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
                      title.text.black.size(32.sp).bold.make(),
                      10.w.heightBox,
                      detail.text.black.size(32.sp).bold.make()
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
          BeeDivider.horizontal(),
        ],
      ),
    );
  }

  Widget _input(String title, hintText, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(
        left: 36.w,
        right: 36.w,
        top: 32.w,
        bottom: 24.w,
      ),
      margin: EdgeInsets.only(bottom: 60.w),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
          ),
          SizedBox(height: 25.w),
          CommonInput(inputController: controller, hintText: hintText)
        ],
      ),
    );
  }

  Widget _sexButton(
    String sex,
    IconData sexIcon,
    int value,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectSex = value;
        });
      },
      child: Container(
        height: 72.w,
        width: 176.w,
        padding: EdgeInsets.symmetric(
          vertical: 13.w,
        ),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.all(Radius.circular(36)),
            border: Border.all(
                color:
                    value == _selectSex ? Color(0xffffc40c) : Color(0xff979797),
                width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              sexIcon,
              size: 32.sp,
              color:
                  value == _selectSex ? Color(0xff333333) : Color(0xff979797),
            ),
            SizedBox(width: 9.w),
            Text(
              sex,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30.sp,
                  color: value == _selectSex
                      ? Color(0xff333333)
                      : Color(0xff979797)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sexSelect() {
    return Container(
      padding: EdgeInsets.only(
        left: 36.w,
        right: 36.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '访客性别',
            style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
          ),
          SizedBox(height: 32.w),
          Container(
            child: Row(
              children: [
                _sexButton('先生', AntDesign.man, 1),
                SizedBox(width: 80.w),
                _sexButton('女士', AntDesign.woman, 2),
              ],
            ),
          ),
          SizedBox(height: 26.w),
        ],
      ),
    );
  }

  Widget _selectTime() {
    return InkWell(
      onTap: () async {
        DateTime date = await BeeDatePicker.pick(DateTime.now());
        if (date != null) dateTime = date;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 36.w,
          right: 36.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '到访时间',
              style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
            ),
            SizedBox(height: 32.w),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateTime == null
                        ? '请选择到访时间'
                        : '${dateTime.toString().substring(0, 11)}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 34.sp,
                        color: Color(0xff333333)),
                  ),
                  Icon(
                    AntDesign.right,
                    size: 36.sp,
                    color: Color(0xffd8d8d8),
                  ),
                ],
              ),
            ),
            SizedBox(height: 26.w),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _create(
    int id,
    int type,
    String tel,
  ) {
    return MaterialButton(
      onPressed: () async {
        VoidCallback cancel = BotToast.showLoading();
        await ManagerFunc.insertVisitorInfo(id, type, _userName.text,
            _selectSex, tel, _userCarNum.text, dateTime);
        cancel();
        Get.off(VisitorRecordPage());
      },
      minWidth: double.infinity,
      height: 96.w,
      shape: StadiumBorder(),
      color: Color(0xffffc40c),
      elevation: 0,
      child: Text(
        '生成通行证',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 32.sp,
          color: Color(0xff333333),
        ),
      ),
    ).pSymmetric(h: 26.w);
  }

  Widget _tips() {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.w,
        ),
        child: Text(
          '通行证只在到访当天单次有效,逾期或超次需要重新生成',
          style: TextStyle(fontSize: 20.sp, color: Color(0xff999999)),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return BeeScaffold(
      title: '访客通行',
      actions: [
        MaterialButton(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          onPressed: () {
            Get.to(() => VisitorRecordPage());
          },
          child: '访客记录'.text.black.size(28.sp).make(),
        )
      ],
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SingleChildScrollView(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: [
                    _buildHouseCard(
                      S.of(context).tempPlotName,
                      appProvider.selectedHouse.roomName,
                    ),
                    _input('访客姓名', '请输入访客姓名', _userName),
                    _sexSelect(),
                    _input('是否驾车', '请输入,例如浙A88888(没有驾车可不填)', _userCarNum),
                    _selectTime(),
                    SizedBox(height: 64.w),
                    _create(
                      appProvider.selectedHouse.estateId,
                      userProvider.userDetailModel.type,
                      userProvider.userDetailModel.tel,
                    ),
                    _tips(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
