/*
 * ====================================================
 * package   : 
 * author    : Created by nansi.
 * time      : 2019/6/24  4:05 PM 
 * remark    : 
 * ====================================================
 */

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/model/user/adress_model.dart';
import 'package:flutter/material.dart';
import 'package:aku_community/utils/headers.dart';


// ignore: must_be_immutable
class MyAddressItem extends StatelessWidget {
  final AddressModel addressModel;
  final VoidCallback setDefaultListener;
  final VoidCallback deleteListener;
  final VoidCallback editListener;

  Color _titleColor = Colors.black;

  MyAddressItem(
      {required this.addressModel,
      required this.deleteListener,
      required this.editListener,
      required this.setDefaultListener})
      : assert(addressModel != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  this.setDefaultListener;
                },
                child: Container(
                  child: Image.asset(R.ASSETS_ICONS_ICON_MY_SETTING_PNG,width: 40.w,height: 40.w,),
                ),
              ),

              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical:6.w),
                child: Text(
                    addressModel.locationName??'',
                    style:TextStyle(fontSize: 24.sp,color: ktextPrimary)
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical:6.w),
                child: Text(
                    addressModel.addressDetail??'',
                    style:TextStyle(fontSize: 32.sp,color: ktextPrimary)
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                        addressModel.name??'',
                        style: TextStyle(fontSize: 24.sp,color: ktextPrimary)
                    ),
                    30.wb,
                    Text(
                        addressModel.tel??'',
                        style: TextStyle(fontSize: 24.sp,color: ktextPrimary)
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  child: Image.asset(R.ASSETS_ICONS_ICON_MY_SETTING_PNG,width: 40.w,height: 40.w,),
                ),
              )
            ],
          ),


          Container(
            height: 1,
            color: Colors.grey[200],
          ),
          Row(
            children: <Widget>[
              Text(
                addressModel.isDefault == 0 ? "" : "默认地址",
                style: TextStyle(fontSize: 28.sp,color: ktextSubColor),
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  this.setDefaultListener;
                },
                child: Container(
                  child:Text(
                    "删除",
                    style: TextStyle(fontSize: 28.sp,color: ktextSubColor),
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
