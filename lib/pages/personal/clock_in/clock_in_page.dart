import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/integral/add_integral_config_model.dart';
import 'package:aku_new_community/models/integral/clocked_record_list_model.dart';
import 'package:aku_new_community/models/integral/integral_info_model.dart';
import 'package:aku_new_community/pages/personal/clock_in/clock_success_dialog.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_back_button.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ClockInPage extends StatefulWidget {
  const ClockInPage({Key? key}) : super(key: key);

  @override
  _ClockInPageState createState() => _ClockInPageState();
}

class _ClockInPageState extends State<ClockInPage> {
  IntegralInfoModel? _integralModel;
  List<AddIntegralConfigModel> _configs = [];

  List<ClockedRecordListModel> _records = [];

  bool _openRemind = false; //演示用，之后删除
  bool get hasClocked => _integralModel?.isSign ?? false;

  Future getData() async {
    var base = await NetUtil().get(API.intergral.info);
    if (base.status ?? false) {
      _integralModel = IntegralInfoModel.fromJson(base.data);
    } else {
      BotToast.showText(text: base.message!);
    }
  }

  @override
  void initState() {
    getData().then((value) {
      if (_integralModel != null) {
        _records = _integralModel!.signRecordList;
        _configs = _integralModel!.rewardSetting
            .split(',')
            .mapIndexed((currentValue, index) => AddIntegralConfigModel(
                addIntegral: int.parse(currentValue),
                hasClocked: index < _integralModel!.serialNumber))
            .toList();
        setState(() {});
      }
    });
    super.initState();
  }

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
                                  '${_integralModel?.serialNumber ?? 0}'
                                      .textSpan
                                      .size(40.sp)
                                      .make(),
                                  ' 天'.textSpan.make(),
                                ]),
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  color: Colors.black.withOpacity(0.85),
                                ),
                              ),
                              4.hb,
                              Text(
                                '明日签到即可获得'
                                '${_configs.isNotEmpty ? _configs[_integralModel!.serialNumber != 7 ? _integralModel!.serialNumber : 0].addIntegral : 0}'
                                '积分',
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
                      '${_integralModel?.points ?? 0}'
                          .text
                          .size(32.sp)
                          .white
                          .make(),
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
                    value: UserTool.userProvider.userConfig.clockRemind,
                    onChanged: (value) {
                      UserTool.userProvider.changeClockRemind();
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
            onPressed: hasClocked
                ? null
                : () async {
                    var base = await NetUtil().get(API.intergral.sign);
                    if (base.status ?? false) {
                      await Get.dialog(ClockSuccessDialog(
                          todayIntegral: 1, tomorrowIntegral: 2));
                      await UserTool.userProvider.changeTodayClocked();
                      await getData();
                    } else {
                      BotToast.showText(text: base.message!);
                    }
                  },
            elevation: 0,
            color: kPrimaryColor,
            disabledColor: kPrimaryColor.withOpacity(0.4),
            minWidth: 560,
            height: 93.w,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(59.w)),
            child: (hasClocked ? '已签到' : '签到')
                .text
                .size(32.sp)
                .color(Colors.black.withOpacity(hasClocked ? 0.4 : 1.0))
                .bold
                .make(),
          )
        ],
      ),
    );
    var bottomList = Flexible(
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
              padding: EdgeInsets.only(top: 32.w, left: 32.w, right: 32.w),
              child: '签到记录'.text.size(32.sp).black.bold.make(),
            ),
            24.hb,
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ..._records
                      .mapIndexed((currentValue, index) => recordListTile(
                          currentValue.serialNumber,
                          currentValue.signDate,
                          currentValue.addNums))
                      .toList(),
                  Container(
                    width: double.infinity,
                    height: 82.w,
                    alignment: Alignment.center,
                    color: Color(0xFFE5E5E5),
                    child:
                        '没有更多记录了~'.text.size(28.sp).color(ktextSubColor).make(),
                  ),
                ].sepWidget(separate: 32.hb),
              ),
            )
          ],
        ),
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
              bottomList,
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
