// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/common_input.dart';

class CarAddPage extends StatefulWidget {
  CarAddPage({Key key}) : super(key: key);

  @override
  _CarAddPageState createState() => _CarAddPageState();
}

class _CarAddPageState extends State<CarAddPage> {
  TextEditingController _carNum = new TextEditingController();

  InkWell _inkWellSave() {
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
            fontSize: 32.sp,
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '添加车辆',
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
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
                  Container(
                    padding: EdgeInsets.only(
                      top: 23.w,
                      bottom: 24.w,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xffeeeeee), width: 0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '您的车牌号',
                          style: TextStyle(
                              fontSize: 28.sp, color: Color(0xff333333)),
                        ),
                        SizedBox(height: 25.w),
                        CommonInput(
                          hintText: '请输入您的车牌号',
                          inputController: _carNum,
                        ),
                      ],
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
