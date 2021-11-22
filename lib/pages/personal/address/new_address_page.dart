import 'dart:convert';
import 'dart:ui';

import 'package:aku_community/model/user/ProvinceModel.dart';
import 'package:aku_community/model/user/adress_model.dart';
import 'package:aku_community/pages/personal/user_func.dart';
import 'package:aku_community/utils/hive_store.dart';
import 'package:aku_community/utils/text_utils.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/utils/headers.dart';

import 'address_selector.dart';
import 'editView.dart';

class NewAddressPage extends StatefulWidget {
  final bool? isFirstAdd;
  final AddressModel? addressModel;
  NewAddressPage({Key? key, this.isFirstAdd, this.addressModel}) : super(key: key);

  @override
  _NewAddressPageState createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage>{
  EasyRefreshController _refreshController = EasyRefreshController();
  late AddressModel _address = AddressModel.empty();
  late List<ProvinceModel> _cityJsonModels = [];
  late StateSetter _addressStateSetter;

  @override
  void initState() {
    super.initState();
    if (widget.addressModel != null) {
      _address = widget.addressModel!;
    }
  }


  @override
  Widget build(BuildContext context) {

    return  BeeScaffold(
      title: '新建收货地址',
      body:_buildBody(context),
    );




  }
  _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        child:ListView(
          children: [
            Container(
              height: 10,
            ),
            EditTile(
              constraints: BoxConstraints.tight(Size(double.infinity, 45)),
              title: "收货人",
              value: _address.name??'',
              hint: "请填写收货人姓名",
              textChanged: (value) {
                _address.name = value;
              },
            ),
            Container(
              height: 3,
            ),
            EditTile(
              constraints: BoxConstraints.tight(Size(double.infinity, 45)),
              title: "手机号码",
              value: _address.tel??'',
              hint: "请填写收货人手机号码",
              maxLength: 11,
              textChanged: (value) {
                _address.tel = value;
              },
            ),
            Container(
              height: 3,
            ),
            _addressView(),
            Container(
              height: 3,
            ),
            EditTile(
              title: "详细地址",
              hint: "街道门牌号等",
              value: _address.addressDetail??'',
              maxLength: 100,
              maxLines: 3,
              direction: Axis.vertical,
              constraints: BoxConstraints(maxHeight: 100),
              textChanged: (value) {
                _address.addressDetail = value;
              },
            ),
            Container(
              height: 30,
            ),
            // _defaultAddressTile(),
            Container(
              height: 100,
            ),
            _saveButton(context)
          ],
        )
      ),
    );
  }

  Container _saveButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: (){

            _saveAddress(context);

        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(8.w)),
          ),
          height: 45.w,
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Text(
            "保存地址",style: TextStyle(
            color: Colors.white,
            fontSize: 17 * 2.sp,
          ),
          ),

        ),
      ),
    );
  }

  _addressView() {
    return  StatefulBuilder(
        builder: (BuildContext context, StateSetter setSta) {
          _addressStateSetter = setSta;
          return GestureDetector(
            onTap: () {
              print('1');
              if (_cityJsonModels.isEmpty) {
                print('2');
                getCityList().then((success) {
                  if (success) {
                    _selectAddress(context);
                  }
                }
                );
                return;
              }
              _selectAddress(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5))),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80.w,
                    child: Text(
                      "所在地区",
                      style:TextStyle(fontSize: 15.sp,)
                    ),
                  ),
                  Expanded(
                      child: Text(
                        TextUtils.isEmpty(_address.locationName??'')
                            ? "选择地址"
                            : "${_address.locationName} : ""}",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                      )),
                  Icon(
                    Icons.navigate_next,
                    size: 16,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          );
        },

    );
  }



  /// 弹出地址选择
  _selectAddress(BuildContext context) {
    AddressSelectorHelper.show(context,
        models: _cityJsonModels,
        province: _address.province,
        city: _address.city,
        district: _address.district,
        callback: (String province, String city, String district,int? locationId) {
          _address.locationName= province+city+district;
          _address.id = locationId??null;
          _addressStateSetter(() {});
         print("$province - $city -$district");
        });
  }

  Future<bool> getCityList() async {
    _cityJsonModels = await  HiveStore.appBox?.get('cityList')??[];
    return true;
  }

  /// 保存地址
  _saveAddress(BuildContext context) async {
    if (TextUtils.isEmpty(_address.name??"")) {
      BotToast.showText(text: '收货人不能为空');
      return;
    }

    if (TextUtils.isEmpty(_address.tel??'') ||
        !TextUtils.verifyPhone(_address.tel)) {
      BotToast.showText(text: '手机号格式不正确');
      return;
    }

    if (TextUtils.isEmpty(_address.province??'')) {
      BotToast.showText(text: '所在地区不能为空');
      return;
    }

    if (TextUtils.isEmpty(_address.addressDetail??'')) {
      BotToast.showText(text: '详细地址不能为空');
      return;
    }


    if (_address.id != null) {
      Userfunc.insertAddress( _address.name??'', _address.tel??'',
          _address.location??null, _address.addressDetail??'', _address.isDefault??null);
    } else {
      Userfunc.updateAddress(_address.id!, _address.name??'', _address.tel??'',
          _address.location??null, _address.addressDetail??'', _address.isDefault??null);
    }


    Navigator.maybePop<dynamic>(context, _address);
  }
}
