import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class SelectParkingPage extends StatefulWidget {
  final Bundle bundle;
  SelectParkingPage({Key key, this.bundle}) : super(key: key);

  @override
  _SelectParkingPageState createState() => _SelectParkingPageState();
}

class _SelectParkingPageState extends State<SelectParkingPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '车位列表',
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(32.w),
            child: Text(
              '所有社区',
              style: TextStyle(
                fontSize: 28.sp,
                color: Color(0xff333333),
              ),
            ),
          ),
          Column(
            children: List.generate(
              11,
              (index) => InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: 28.w, horizontal: 32.w),
                  child: Text(
                    '${widget.bundle.getString('title')}地下车库11号${index + 1}',
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: Color(0xff333333),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
