import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '我的收货地址',
          subtitle: '添加新地址',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
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
