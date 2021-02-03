import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_back_button.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AllApplicationPage extends StatefulWidget {
  AllApplicationPage({Key key}) : super(key: key);

  @override
  _AllApplicationPageState createState() => _AllApplicationPageState();
}

class _AllApplicationPageState extends State<AllApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BeeBackButton(),
        title: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          height: 72.w,
          shape: StadiumBorder(),
          elevation: 0,
          minWidth: double.infinity,
          color: Color(0xFFF3F3F3),
          onPressed: () {},
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 32.w,
                color: Color(0xFF666666),
              ),
              10.wb,
              '搜索商品、活动、帖子、应用'
                  .text
                  .size(28.sp)
                  .color(ktextSubColor)
                  .make()
                  .expand(),
            ],
          ),
        ),
      ),
      // body: ,
    );
  }
}
