import 'package:aku_new_community/models/login/community_model.dart';
import 'package:aku_new_community/models/login/picked_city_model.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/picker/bee_city_picker.dart';
import 'package:aku_new_community/widget/picker/bee_community_picker.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class SelectCommunity extends StatefulWidget {
  const SelectCommunity({
    Key? key,
  }) : super(key: key);

  @override
  _SelectCommunityState createState() => _SelectCommunityState();
}

class _SelectCommunityState extends State<SelectCommunity> {
  PickedCityModel? _model;
  CommunityModel? _community;

  String get cityName {
    if (_model == null) {
      return '请选择省、市、县/区';
    } else {
      return _model!.province.name + _model!.city.name + _model!.district.name;
    }
  }

  String get communityName {
    if (_community == null) {
      return '请选择小区';
    } else {
      return _community!.name;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择登录小区',
      body: ListView(
        children: [
          GestureDetector(
            onTap: () async {
              _model = await BeeCityPicker.pick(context);
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
          ),
          GestureDetector(
            onTap: () async {
              var cancel = BotToast.showLoading();
              List<CommunityModel> _communities = [];
              // var base = await NetUtil().get(API.sarsApi.login.allCommunity);
              // if (base.status ?? false) {
              //   _communities = (base.data as List)
              //       .map((e) => CommunityModel.fromJson(e))
              //       .toList();
              // }
              cancel();
              _communities = [
                CommunityModel(
                    id: 0,
                    name: '111',
                    address: 'address',
                    addressDetails: 'addressDetails'),
                CommunityModel(
                    id: 0,
                    name: '2222',
                    address: 'address',
                    addressDetails: 'addressDetails'),
                CommunityModel(
                    id: 0,
                    name: '3333',
                    address: 'address',
                    addressDetails: 'addressDetails'),
                CommunityModel(
                    id: 0,
                    name: '444',
                    address: 'address',
                    addressDetails: 'addressDetails'),
                CommunityModel(
                    id: 0,
                    name: '5555',
                    address: 'address',
                    addressDetails: 'addressDetails')
              ];
              _community = await BeeCommunityPicker.pick(context, _communities);
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
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
