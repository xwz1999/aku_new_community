import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/manager/visitor_list_item_model.dart';
import 'package:aku_new_community/ui/manager/visitor/visitor_passport_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';

class VisitorListItem extends StatefulWidget {
  final VisitorListItemModel model;
  final int type;

  VisitorListItem({Key? key, required this.model, required this.type})
      : super(key: key);

  @override
  _VisitorListItemState createState() => _VisitorListItemState();
}

class _VisitorListItemState extends State<VisitorListItem> {
  String get _name {
    StringBuffer buffer = StringBuffer();
    var name = widget.model.name;
    buffer.write(name);
    var car = widget.model.carNumber;
    if (TextUtil.isEmpty(car)) return buffer.toString();
    buffer.write('($car)');
    return buffer.toString();
  }

  // bool get outDate =>
  //     DateTime.now().isAfter(widget.model.date ?? DateTime.now());
  _buildSuffix() {
    if (widget.type == 1 || widget.type == 3)
      return MaterialButton(
        onPressed: () {
          Get.back();
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.w),
        height: 56.w,
        child: '再次邀约'.text.size(24.sp).bold.make(),
        shape: StadiumBorder(
          side: BorderSide(
            color: Color(0xFFFFC500),
            width: 3.w,
          ),
        ),
      );
    else
      //二维码按钮
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.qr_code_rounded),
          16.wb,
          Icon(CupertinoIcons.chevron_forward),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        if (widget.type == 2) {
          BaseModel baseModel = await NetUtil().get(API.manager.getInviteCode,
              params: {
                "startTime": DateUtil.formatDateStr(
                    widget.model.visitDateStart ?? '',
                    format: 'yyyy/MM/dd HH:mm:ss'),
                "endTime": DateUtil.formatDateStr(
                    widget.model.visitDateEnd ?? '',
                    format: 'yyyy/MM/dd HH:mm:ss'),
                "visitorsTel": widget.model.tel
              },
              showMessage: false);

          if (baseModel.data != null) {
            Get.to(VisitorPassportPage(
              model: widget.model,
              code: baseModel.data,
            ));
          } else {
            BotToast.showText(text: '访客码获取出错！');
          }
        }
      },

      // onPressed: () {
      //   if (widget.model.status != 1) {
      //     Get.to(() => VisitorPassportPage(model: widget.model));
      //   }
      // },
      color: Colors.white,
      elevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      height: 152.w,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _name.text.size(32.sp).bold.make(),
              8.hb,
              DateUtil.formatDate(widget.model.date, format: 'yyyy-MM-dd')
                  .text
                  .size(24.sp)
                  .color(Color(0xFF999999))
                  .make(),
            ],
          ),
          Spacer(),
          _buildSuffix(),
        ],
      ),
    );
  }
}
