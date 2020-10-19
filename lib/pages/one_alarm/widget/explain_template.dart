import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:akuCommunity/utils/screenutil.dart';


class ExplainTemplate extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  ExplainTemplate(this.options) : super(options);

  @override
  final illustrationPath = 'img/bg/authentication.png';
  @override
  Color get primaryColor => options.primaryColor ?? Color(0xff15c0ec);
  @override
  final maxWidth = Screenutil.length(400);
  @override
  final maxHeight = Screenutil.length(617);
  @override
  final bodyMargin = 0;
  @override
  get layout {
    return [
      Positioned(
        child: background,
      ),
      Positioned(
        top: percentH(32),
        child: title,
      ),
      Positioned(
        top: percentH(42),
        left: percentW(10),
        right: percentW(10),
        height: percentH(actions == null ? 52 : 38),
        child: content,
      ),
      Positioned(
        bottom: percentW(8),
        left: percentW(8),
        right: percentW(8),
        child: actions ?? Container(),
      ),
    ];
  }
}

// class Explain extends StatelessWidget {
//   const Explain({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.only(
//         top: Screenutil.length(32),
//         left: Screenutil.length(32),
//         right: Screenutil.length(32),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '一键报警',
//             style: TextStyle(
//               fontSize: BaseStyle.fontSize32,
//               color: BaseStyle.color333333,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: Screenutil.length(20)),
//             child: Text(
//               '点击“呼叫110”后，您可以直接拨打本地110。页面中提供了您当前所在位置，以便您与警方沟通。（GPS信号弱时，位置可能存在偏移）',
//               style: TextStyle(
//                 fontSize: BaseStyle.fontSize28,
//                 color: BaseStyle.color666666,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
