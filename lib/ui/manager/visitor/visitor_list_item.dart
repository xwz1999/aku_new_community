import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flustars/flustars.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/model/manager/visitor_list_item_model.dart';
import 'package:akuCommunity/ui/manager/visitor/visitor_passport_page.dart';
import 'package:akuCommunity/utils/headers.dart';

class VisitorListItem extends StatefulWidget {
  final VisitorListItemModel model;
  VisitorListItem({Key key, @required this.model}) : super(key: key);

  @override
  _VisitorListItemState createState() => _VisitorListItemState();
}

class _VisitorListItemState extends State<VisitorListItem> {
  String get _name {
    StringBuffer buffer = StringBuffer();
    var name = widget.model.name;
    buffer.write(name);
    var car = widget.model.carNum;
    if (TextUtil.isEmpty(car)) return buffer.toString();
    buffer.write('($car)');
    return buffer.toString();
  }

  bool get outDate => DateTime.now().isAfter(widget.model.date);
  _buildSuffix() {
    if (outDate)
      return MaterialButton(
        onPressed: () {},
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
      onPressed: () {
        if (!outDate) {
          VisitorPassportPage(model: widget.model).to();
        }
      },
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
