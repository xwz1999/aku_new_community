import 'package:flutter/material.dart';

import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class AlarmDetailPage extends StatelessWidget {
  const AlarmDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '功能说明',
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          '一键报警'.text.size(32.sp).bold.make(),
          20.hb,
          '点击“呼叫110”后，您可以直接拨打本地110。页面中提供了您当前所在位置，以便您与警方沟通。（GPS信号弱时，位置可能存在偏移）'
              .text
              .size(28.sp)
              .make(),
        ],
      ),
    );
  }
}
