import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/widget/common_input.dart';

class HouseAuthenticatePage extends StatefulWidget {
  HouseAuthenticatePage({Key key}) : super(key: key);

  @override
  _HouseAuthenticatePageState createState() => _HouseAuthenticatePageState();
}

class _HouseAuthenticatePageState extends State<HouseAuthenticatePage> {
  TextEditingController _userName = new TextEditingController();
  TextEditingController _userIDCard = new TextEditingController();
  TextEditingController _userPhone = new TextEditingController();

  List<Map<String, dynamic>> _inputList = [];

  @override
  void initState() {
    super.initState();
    _inputList = [
      {'title': '您的姓名', 'hintText': '请输入您的姓名', 'inputController': _userName},
      {'title': '身份证', 'hintText': '请输入您的身份证号', 'inputController': _userIDCard},
      {'title': '手机号', 'hintText': '请输入您的手机号码', 'inputController': _userPhone},
    ];
  }

  Widget _inkWellSave() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(
          top: 19.w,
          bottom: 21.w,
        ),
        alignment: Alignment.center,
        width: 686.w,
        decoration: BoxDecoration(
          color: Color(0xffffd000),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Text(
          '保存',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32.w,
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '房屋认证',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 32.w,
                left: 32.w,
                right: 32.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: List.generate(
                      _inputList.length,
                      (index) => Container(
                        padding: EdgeInsets.only(
                          top: 23.w,
                          bottom: 24.w,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffeeeeee), width: 0.5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _inputList[index]['title'],
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  color: Color(0xff333333)),
                            ),
                            SizedBox(height: 25.w),
                            CommonInput(
                              hintText: _inputList[index]['hintText'],
                              inputController: _inputList[index]
                                  ['inputController'],
                            )
                            // item['widget'],
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 89.w),
                  _inkWellSave(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
