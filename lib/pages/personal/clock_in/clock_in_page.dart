import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/integral/add_integral_config_model.dart';
import 'package:aku_new_community/models/integral/clocked_record_list_model.dart';
import 'package:aku_new_community/widget/bee_back_button.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ClockInPage extends StatefulWidget {
  const ClockInPage({Key? key}) : super(key: key);

  @override
  _ClockInPageState createState() => _ClockInPageState();
}

class _ClockInPageState extends State<ClockInPage> {
  List<AddIntegralConfigModel> _configs = [
    AddIntegralConfigModel(addIntegral: 1, hasClocked: true),
    AddIntegralConfigModel(addIntegral: 2, hasClocked: false),
    AddIntegralConfigModel(addIntegral: 3, hasClocked: false),
    AddIntegralConfigModel(addIntegral: 5, hasClocked: false),
    AddIntegralConfigModel(addIntegral: 8, hasClocked: false),
    AddIntegralConfigModel(addIntegral: 15, hasClocked: false),
    AddIntegralConfigModel(addIntegral: 50, hasClocked: false),
  ];

  List<ClockedRecordListModel> _records = [
    ClockedRecordListModel(day: 1, date: '2021-12-29 13:29:24', addIntegral: 1),
    ClockedRecordListModel(day: 2, date: '2021-12-28 13:29:24', addIntegral: 2),
    ClockedRecordListModel(day: 3, date: '2021-12-27 13:29:24', addIntegral: 3),
    ClockedRecordListModel(day: 4, date: '2021-12-26 13:29:24', addIntegral: 5),
    ClockedRecordListModel(day: 5, date: '2021-12-25 13:29:24', addIntegral: 8),
    ClockedRecordListModel(
        day: 6, date: '2021-12-24 13:29:24', addIntegral: 15),
    ClockedRecordListModel(
        day: 7, date: '2021-12-23 13:29:24', addIntegral: 50),
    ClockedRecordListModel(day: 1, date: '2021-12-22 13:29:24', addIntegral: 1),
  ];

  bool _openRemind = false; //演示用，之后删除

  @override
  Widget build(BuildContext context) {
    var top = Container(
      width: double.infinity,
      // height: 441.w,
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          48.hb,
          Container(
            margin: EdgeInsets.only(left: 32.w),
            child: Row(
              children: [
                Hero(
                  tag: 'AVATAR',
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: Assets.images.placeholder.path,
                      image: API.image(UserTool
                              .userProvider.userInfoModel!.imgUrls.isNotEmpty
                          ? UserTool
                              .userProvider.userInfoModel!.imgUrls.first.url
                          : ''),
                      height: 106.w,
                      width: 106.w,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Assets.icons.iconMySetting.path,
                          height: 106.w,
                          width: 106.w,
                        );
                      },
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 16.w),
                    child: UserTool.userProvider.isLogin
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(children: [
                                  '已连续签到 '.textSpan.make(),
                                  '1'.textSpan.size(40.sp).make(),
                                  ' 天'.textSpan.make(),
                                ]),
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  color: Colors.black.withOpacity(0.85),
                                ),
                              ),
                              4.hb,
                              Text(
                                '明日签到即可获得2积分',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: Colors.black.withOpacity(0.45),
                                ),
                              ),
                            ],
                          )
                        : Text(
                            '登录/注册',
                            style: TextStyle(
                              fontSize: 32.sp,
                              color: Color(0xffad8940),
                            ),
                          )),
                Spacer(),
                MaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  color: Colors.white.withOpacity(0.2),
                  minWidth: 155.w,
                  height: 72.w,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.w)),
                  child: Row(
                    children: [
                      Assets.icons.intergral.image(width: 36.w, height: 36.w),
                      12.wb,
                      '123'.text.size(32.sp).white.make(),
                    ],
                  ),
                ),
                32.w.widthBox,
              ],
            ),
          ),
        ],
      ),
    );
    var clockInCard = Container(
      width: 686.w,
      height: 428.w,
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              '连续签到领好礼'.text.size(28.sp).black.make(),
              14.wb,
              Icon(
                CupertinoIcons.question_circle,
                size: 30.w,
                color: Colors.black.withOpacity(0.25),
              ),
              Spacer(),
              '开启签到提醒'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.25))
                  .make(),
              24.wb,
              SizedBox(
                  width: 72.w,
                  height: 40.w,
                  child: Switch(
                    value: _openRemind,
                    onChanged: (value) {
                      _openRemind = value;
                      setState(() {});
                    },
                  )),
            ],
          ),
          Spacer(),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 7,
            childAspectRatio: 70 / 100,
            mainAxisSpacing: 24.w,
            children: _configs
                .mapIndexed((currentValue, index) => gridCard(
                    index, currentValue.addIntegral,
                    hasClocked: currentValue.hasClocked))
                .toList(),
          ),
          Spacer(),
          MaterialButton(
            onPressed: () {},
            elevation: 0,
            color: kPrimaryColor,
            minWidth: 560,
            height: 93.w,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(59.w)),
            child: '签到'.text.size(32.sp).black.bold.make(),
          )
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: '每日签到'.text.size(32.sp).white.make(),
        leading: BeeBackButton(
          color: Colors.white,
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.fitHeight,
              image: AssetImage(Assets.static.signInBackground.path)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              top,
              80.hb,
              clockInCard,
              40.hb,
              Flexible(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 32.w, left: 32.w, right: 32.w),
                        child: '签到记录'.text.size(32.sp).black.bold.make(),
                      ),
                      24.hb,
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            ..._records
                                .mapIndexed((currentValue, index) =>
                                    recordListTile(
                                        currentValue.day,
                                        currentValue.date,
                                        currentValue.addIntegral))
                                .toList(),
                            Container(
                              width: double.infinity,
                              height: 82.w,
                              alignment: Alignment.center,
                              color: Color(0xFFE5E5E5),
                              child: '没有更多记录了~'
                                  .text
                                  .size(28.sp)
                                  .color(ktextSubColor)
                                  .make(),
                            ),
                          ].sepWidget(separate: 32.hb),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget recordListTile(int continuityDay, String date, int addIntegral) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, right: 32.w),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              '连续$continuityDay天签到'.text.size(28.sp).black.make(),
              date.text.size(24.sp).color(ktextSubColor).make(),
            ],
          ),
          Spacer(),
          SizedBox(
            width: 100.w,
            child: Row(
              children: [
                Assets.icons.intergral.image(width: 30.w, height: 30.w),
                Spacer(),
                '+$addIntegral'.text.size(28.sp).color(kPrimaryColor).make(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget gridCard(int index, int addIntegral, {bool hasClocked = false}) {
    return Column(
      children: [
        Container(
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35.w),
              border: (hasClocked
                  ? Border.fromBorderSide(BorderSide.none)
                  : Border.all(color: kPrimaryColor)),
              color: (hasClocked ? kPrimaryColor : Colors.white)),
          alignment: Alignment.center,
          child: hasClocked
              ? Icon(
                  CupertinoIcons.check_mark,
                  size: 40.w,
                  color: Colors.white,
                )
              : '+ $addIntegral'.text.size(22.sp).color(kPrimaryColor).make(),
        ),
        14.hb,
        '第${index + 1}天'.text.size(22.sp).black.make(),
      ],
    );
  }
}
