import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const aboutText =
        '“小蜜蜂社区”APP是由广州杰赛科技有限公司研究开发，为全国社区业主量身定做，本产品融合了基础物业服务，园区生活服务，周边商圈服务和邻里社交服务的一站式园区生活服务平台。该平台可提供超过30种的线上服务其中包括维修、意见建议、投诉表扬物业缴费、访客通行、粮油宅配、团购商城等，并可通过支付宝、微信支付来未完成线上支付，真正打造了智慧园区O2O平台为广大业主打造更安全、更便捷、更和睦的幸福园区。';

    TextStyle _style = TextStyle(
      fontSize: 32.sp,
      color: Color(0xff575757),
    );

    return BeeScaffold(
      title: '关于小蜜蜂智慧社区',
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          Text(
            aboutText,
            style: _style,
          ),
          SizedBox(height: 100.w),
          Text(
            '“小蜜蜂智慧社区”APP——幸福生活，简单到达',
            style: _style,
          ),
        ],
      ),
    );
  }
}
