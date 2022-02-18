import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/models/login/community_model.dart';
import 'package:aku_new_community/models/login/history_login_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:aku_new_community/widget/picker/bee_city_picker.dart';
import 'package:aku_new_community/widget/picker/bee_community_picker.dart';

class SelectCommunity extends StatefulWidget {
  const SelectCommunity({
    Key? key,
  }) : super(key: key);

  @override
  _SelectCommunityState createState() => _SelectCommunityState();
}

class _SelectCommunityState extends State<SelectCommunity> {
  String get cityName {
    var _model = UserTool.appProveider.pickedCityAndCommunity;
    if (_model == null) {
      return '请选择省、市、县/区';
    } else {
      return _model.cityModel.province.name +
          _model.cityModel.city.name +
          _model.cityModel.district.name;
    }
  }

  String get communityName {
    var _community =
        UserTool.appProveider.pickedCityAndCommunity?.communityModel;
    if (_community == null) {
      return '请选择小区';
    } else {
      return _community.name;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    Future.delayed(Duration(milliseconds: 0), () async {
      if (UserTool.appProveider.pickedCityAndCommunity != null &&
          UserTool.appProveider.pickedCityAndCommunity?.communityModel ==
              null) {
        UserTool.appProveider.resetPickedCity();
      }
    });
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var selectCity = GestureDetector(
      onTap: () async {
        var _city = await BeeCityPicker.pick(context);
        if (_city != null) {
          UserTool.appProveider.setPickedCity(city: _city);
        }
        setState(() {});
      },
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 88.w,
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        child: Row(
          children: [
            '选择城市'.text.size(28.sp).black.make(),
            Spacer(),
            '${cityName}'.text.black.make(),
            32.w.widthBox,
            Icon(
              CupertinoIcons.right_chevron,
              size: 20.w,
            )
          ],
        ),
      ),
    );
    var selectCommunity = GestureDetector(
      onTap: () async {
        var cancel = BotToast.showLoading();
        List<CommunityModel> _communities = [];
        var base = await NetUtil().get(SARSAPI.login.allCommunity, params: {
          'cityId': UserTool
              .appProveider.pickedCityAndCommunity!.cityModel.district.id,
        });
        if (base.success) {
          _communities = (base.data as List)
              .map((e) => CommunityModel.fromJson(e))
              .toList();
        }
        cancel();
        var _community = await BeeCommunityPicker.pick(context, _communities);
        print(_community?.name);
        if (_community != null) {
          UserTool.appProveider.setPickedCity(community: _community);
        }
        setState(() {});
      },
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 88.w,
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        child: Row(
          children: [
            '选择小区'.text.size(28.sp).black.make(),
            Spacer(),
            '${communityName}'.text.black.make(),
            32.w.widthBox,
            Icon(
              CupertinoIcons.right_chevron,
              size: 20.w,
            )
          ],
        ),
      ),
    );
    var history = Offstage(
      offstage: UserTool.dataProvider.loginHistories.length == 0,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '历史登录'.text.size(28.sp).color(Colors.black.withOpacity(0.2)).make(),
            24.w.widthBox,
            ...UserTool.dataProvider.loginHistories
                .map((e) => _historyTile(e))
                .toList(),
          ],
        ),
      ),
    );
    return WillPopScope(
      onWillPop: () async {
        var bool = UserTool.appProveider.pickedCityAndCommunity != null &&
            UserTool.appProveider.pickedCityAndCommunity?.communityModel ==
                null;
        if (bool) {
          BotToast.showText(text: '请选择小区');
          return false;
        } else {
          return true;
        }
      },
      child: BeeScaffold(
        title: '选择登录小区',
        body: ListView(
          children: [
            selectCity,
            selectCommunity,
            10.w.heightBox,
            history,
          ],
        ),
      ),
    );
  }

  Widget _historyTile(HistoryLoginModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.search,
            size: 30.w,
            color: Colors.black.withOpacity(0.2),
          ),
          24.w.widthBox,
          '${model.communityModel!.name}(${model.cityModel.province.name}·${model.cityModel.city.name}·${model.cityModel.district.name})'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.2))
              .make(),
        ],
      ),
    );
  }
}
