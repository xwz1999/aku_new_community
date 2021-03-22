import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'widget/address_item.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List _addressInfoList = [
    {
      'name': '马泽鹏',
      'phone': '18868741879',
      'address': '广东省深圳市福田区福华路8号',
      'isDefualt': true
    },
    {
      'name': '王珂',
      'phone': '13868741123',
      'address': '广东省深圳市福田区红荔西路8007号',
      'isDefualt': false
    },
    {
      'name': '叶一样',
      'phone': '13944743213',
      'address': '广东省深圳市布吉街道布沙路大芬油画村对面',
      'isDefualt': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '我的收货地址',
      actions: [
        InkWell(
          onTap: () {},
          child: '添加新地址'.text.black.size(24.sp).make(),
        )
      ],
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => AddressItem(
          name: _addressInfoList[index]['name'],
          phone: _addressInfoList[index]['phone'],
          address: _addressInfoList[index]['address'],
          isDefualt: _addressInfoList[index]['isDefualt'],
        ),
        itemCount: _addressInfoList.length,
      ),
    );
  }
}
