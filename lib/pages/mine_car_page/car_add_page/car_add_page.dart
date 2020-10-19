import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
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
          top: Screenutil.length(19),
          bottom: Screenutil.length(21),
        ),
        alignment: Alignment.center,
        width: Screenutil.length(686),
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
            fontSize: Screenutil.size(32),
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
          title: '添加车辆',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
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
                top: Screenutil.length(32),
                left: Screenutil.length(32),
                right: Screenutil.length(32),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: Screenutil.length(23),
                      bottom: Screenutil.length(24),
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
                              fontSize: Screenutil.size(28),
                              color: Color(0xff333333)),
                        ),
                        SizedBox(height: Screenutil.length(25)),
                        CommonInput(
                          hintText: '请输入您的车牌号',
                          inputController: _carNum,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Screenutil.length(89)),
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
