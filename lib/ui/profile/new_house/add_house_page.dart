import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/extensions/int_ext.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/saas_model/my_house/estate_cascade_model.dart';
import 'package:aku_new_community/saas_model/my_house/picked_house.dart';
import 'package:aku_new_community/ui/profile/new_house/widgets/add_house_button.dart';
import 'package:aku_new_community/utils/bee_map.dart';
import 'package:aku_new_community/utils/enum/identify.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:aku_new_community/widget/picker/bee_house_cascade_picker.dart';
import 'package:aku_new_community/widget/picker/bee_identify_picker.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddHousePage extends StatefulWidget {
  const AddHousePage({Key? key}) : super(key: key);

  @override
  _AddHousePageState createState() => _AddHousePageState();
}

class _AddHousePageState extends State<AddHousePage> {
  Identify _identify = Identify.OWNER;
  List<PickedHouseModel> _pickedHouses = [PickedHouseModel()];
  PickedHouseModel? _otherPickHouse;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _telController = TextEditingController();

  List<int> get manageEstateIds {
    if (_otherPickHouse == null && _pickedHouses.first.house == null) {
      return [];
    }
    if (_identify == Identify.OWNER) {
      return _pickedHouses.map((e) => e.house!.id).toList();
    } else {
      return [_otherPickHouse!.house!.id];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var identify = Padding(
      padding: EdgeInsets.only(bottom: 24.w),
      child: Row(
        children: [
          SizedBox(
            width: 170.w,
            child: '认证身份'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.65))
                .make(),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                _identify = await BeeIdentifyPicker.pick(context);
                setState(() {});
              },
              child: Material(
                color: Colors.transparent,
                child: Row(
                  children: [
                    '${BeeMap.getIdentify(_identify)}'
                        .text
                        .size(28.sp)
                        .color(Colors.black.withOpacity(0.65))
                        .make(),
                    Spacer(),
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 20.w,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    var name = Padding(
      padding: EdgeInsets.symmetric(vertical: 24.w),
      child: Row(
        children: [
          SizedBox(
            width: 170.w,
            child: '姓名'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.65))
                .make(),
          ),
          Expanded(
            child: Row(
              children: [
                '${UserTool.userProvider.userInfoModel!.name}'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
              ],
            ),
          ),
        ],
      ),
    );
    var code = Padding(
      padding: EdgeInsets.symmetric(vertical: 24.w),
      child: Row(
        children: [
          SizedBox(
            width: 170.w,
            child: '身份证号'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.65))
                .make(),
          ),
          Expanded(
            child: Row(
              children: [
                '${UserTool.userProvider.userInfoModel!.idCard}'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
              ],
            ),
          ),
        ],
      ),
    );
    var tel = Padding(
      padding: EdgeInsets.only(top: 24.w),
      child: Row(
        children: [
          SizedBox(
            width: 170.w,
            child: '手机号'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.65))
                .make(),
          ),
          Expanded(
            child: Row(
              children: [
                '${UserTool.userProvider.userInfoModel!.tel}'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
              ],
            ),
          ),
        ],
      ),
    );
    return BeeScaffold(
      title: '身份认证',
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        children: [
          Container(
            width: 686.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
                  child: '身份信息'.text.size(32.sp).black.bold.make(),
                ),
                BeeDivider.horizontal(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      identify,
                      BeeDivider.horizontal(),
                      name,
                      BeeDivider.horizontal(),
                      code,
                      BeeDivider.horizontal(),
                      tel
                    ],
                  ),
                ),
              ],
            ),
          ),
          24.w.heightBox,
          _getProperty(),
        ],
      )),
      bottomNavi: Padding(
        padding: EdgeInsets.all(32.w),
        child: AddHouseButton(
            text: '提交',
            onTap: () async {
              if (manageEstateIds.isEmpty) {
                BotToast.showText(text: '请选择房屋');
                return;
              }
              var cancel = BotToast.showLoading();
              var base = await NetUtil().post(SAASAPI.profile.house.addHouse,
                  params: {
                    'identity': _identify.index + 1,
                    'manageEstateIds': manageEstateIds,
                    'ownerName': _nameController.text,
                    'ownerTel': _telController.text,
                    'tenantName': _nameController.text,
                    'tenantTel': _telController.text,
                  },
                  showMessage: true);
              cancel();
              if (base.success) {
                Get.back();
              }
            }),
      ),
    );
  }

  Widget _getProperty() {
    switch (_identify) {
      case Identify.OWNER:
        return _propertyRightOwner();
      case Identify.OWNER_RELATIVES:
        return _propertyRightOther();
      case Identify.TENANT:
        return _propertyRightOther();
      case Identify.TENANT_RELATIVES:
        return _propertyRightOther();
    }
  }

  Widget _propertyRightOwner() {
    return Container(
      width: 686.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
            child: Row(
              children: [
                '产权信息'.text.size(32.sp).black.bold.make(),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 20.w, minHeight: 20.w),
                  onPressed: () {
                    _pickedHouses.add(PickedHouseModel());
                    setState(() {});
                  },
                  icon: Icon(
                    CupertinoIcons.plus,
                    size: 30.w,
                  ),
                ),
              ],
            ),
          ),
          BeeDivider.horizontal(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _pickedHouses
                  .mapIndexed((currentValue, index) =>
                      _propertyOwnerTile(currentValue, index))
                  .toList()
                  .sepWidget(separate: BeeDivider.horizontal()),
            ),
          )
        ],
      ),
    );
  }

  Widget _propertyRightOther() {
    var house = GestureDetector(
      onTap: () async {
        var cancel = BotToast.showLoading();
        var base = await NetUtil().get(SAASAPI.house.allHouses, params: {
          'communityId': UserTool.userProvider.userInfoModel!.communityId
        });
        cancel();
        if (base.success) {
          if ((base.data as List).isNotEmpty) {
            var _buildings = (base.data as List)
                .map((e) => EstateCascadeModel.fromJson(e))
                .toList();
            _otherPickHouse =
                await BeeHouseCascadePicker.pick(context, _buildings);
            setState(() {});
          } else {
            BotToast.showText(text: '房屋列表为空');
          }
        } else {
          BotToast.showText(text: base.msg);
        }
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: 105.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.w),
          child: Row(
            children: [
              '选择房屋'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.65))
                  .make(),
              56.w.widthBox,
              Expanded(
                child:
                    '${_otherPickHouse == null ? '请选择楼层房号' : '${_otherPickHouse!.building!.name}-${_otherPickHouse!.unit!.name}-${_otherPickHouse!.floor!.name}-${_otherPickHouse!.house!.name}'}'
                        .text
                        .size(28.sp)
                        .color(Colors.black.withOpacity(0.25))
                        .maxLines(2)
                        .make(),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                size: 25.w,
                color: Colors.black.withOpacity(0.25),
              )
            ],
          ),
        ),
      ),
    );
    var name = Container(
      width: double.infinity,
      height: 105.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.w),
      child: Row(
        children: [
          '${_identify.index == 3 ? '房屋租户' : '房屋业主'}'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.65))
              .make(),
          56.w.widthBox,
          Expanded(
              child: TextField(
            controller: _nameController,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: '${_identify.index == 3 ? '请输入租户姓名' : '请输入业主姓名'}',
                hintStyle: TextStyle(
                  fontSize: 28.sp,
                  color: Colors.black.withOpacity(0.25),
                )),
          )),
        ],
      ),
    );
    var tel = Container(
      width: double.infinity,
      height: 105.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.w),
      child: Row(
        children: [
          '${_identify.index == 3 ? '租户手机' : '业主手机'}'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.65))
              .make(),
          56.w.widthBox,
          Expanded(
              child: TextField(
            controller: _telController,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: '${_identify.index == 3 ? '请输入租户手机号' : '请输入业主手机号'}',
                hintStyle: TextStyle(
                  fontSize: 28.sp,
                  color: Colors.black.withOpacity(0.25),
                )),
          )),
        ],
      ),
    );
    return Container(
      width: 686.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
            child: Row(
              children: [
                '产权信息'.text.size(32.sp).black.bold.make(),
                Spacer(),
              ],
            ),
          ),
          BeeDivider.horizontal(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                house,
                BeeDivider.horizontal(),
                name,
                BeeDivider.horizontal(),
                tel
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _propertyOwnerTile(PickedHouseModel model, int index) {
    return Column(
      children: [
        32.w.heightBox,
        Container(
          width: double.infinity,
          height: 60.w,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 32.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: Colors.black.withOpacity(0.06)),
          child: '产权信息${(index + 1).toChinese}'
              .text
              .size(26.sp)
              .color(Colors.black.withOpacity(0.45))
              .make(),
        ),
        GestureDetector(
          onTap: () async {
            var cancel = BotToast.showLoading();
            var base = await NetUtil().get(SAASAPI.house.allHouses, params: {
              'communityId': UserTool.userProvider.userInfoModel!.communityId
            });
            cancel();
            if (base.success) {
              var _buildings = (base.data as List)
                  .map((e) => EstateCascadeModel.fromJson(e))
                  .toList();
              _pickedHouses[index] =
                  await BeeHouseCascadePicker.pick(context, _buildings);
              setState(() {});
            } else {
              BotToast.showText(text: base.msg);
            }
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: 105.w,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.w),
              child: Row(
                children: [
                  '选择房屋'
                      .text
                      .size(28.sp)
                      .color(Colors.black.withOpacity(0.65))
                      .make(),
                  56.w.widthBox,
                  Expanded(
                    child:
                        '${model.house == null ? '请选择楼层房号' : '${model.building!.name}-${model.unit!.name}-${model.floor!.name}-${model.house!.name}'}'
                            .text
                            .size(28.sp)
                            .color(model.house != null
                                ? Colors.black.withOpacity(0.5)
                                : Colors.black.withOpacity(0.25))
                            .make(),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 25.w,
                    color: Colors.black.withOpacity(0.25),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
