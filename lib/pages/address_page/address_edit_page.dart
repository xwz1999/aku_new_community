// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'widget/address_edit_item.dart';

class AddressEditPage extends StatefulWidget {
  final Bundle bundle;
  AddressEditPage({Key key, this.bundle}) : super(key: key);

  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool isDefault = false;

  Widget _containerSelectDefault() {
    return Container(
      color: Colors.white,
      height: 96.w,
      padding: EdgeInsets.symmetric(
        vertical: 28.w,
        horizontal: 32.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '设为默认地址',
            style: TextStyle(
              fontSize: 28.sp,
              color: Color(0xff333333),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isDefault = !isDefault;
              });
            },
            child: CupertinoSwitch(
              value: isDefault,
              activeColor: Color(0xffffc40c), // 激活时原点颜色
              onChanged: (bool val) {
                setState(() {
                  isDefault = !isDefault;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _containerDelete() {
    return InkWell(
      onTap: () {},
      child: Container(
        color: Colors.white,
        height: 96.w,
        padding: EdgeInsets.symmetric(
          vertical: 28.w,
          horizontal: 32.w,
        ),
        alignment: Alignment.center,
        child: Text(
          '删除地址',
          style: TextStyle(
            fontSize: 28.sp,
            color: Color(0xffe60e0e),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '${widget.bundle.getMap('details')['title']}',
      actions: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
              height: 98.w,
              width: 48.w + 32.w * 2,
              alignment: Alignment.center,
              child: '保存'.text.color(Color(0xFFFFC40C)).size(24.sp).make()),
        )
      ],
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AddressEditItem(addressInfo: {
                        'name': widget.bundle.getMap('details')['name'],
                        'phone': widget.bundle.getMap('details')['phone'],
                        'address': widget.bundle.getMap('details')['address']
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 66.w),
                _containerSelectDefault(),
                SizedBox(height: 66.w),
                widget.bundle.getMap('details')['isDelete']
                    ? _containerDelete()
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
