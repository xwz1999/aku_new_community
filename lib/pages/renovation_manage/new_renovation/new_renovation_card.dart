import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/new_renovation/new_renovation_list_model.dart';
import 'package:aku_community/pages/renovation_manage/new_renovation/new_renovation_detail_page.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:aku_community/widget/buttons/card_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:get/get.dart';

class NewRenovationCard extends StatefulWidget {
  final NewRenovationListModel model;
  final VoidCallback callRefresh;
  NewRenovationCard({Key? key, required this.model, required this.callRefresh})
      : super(key: key);

  @override
  _NewRenovationCardState createState() => _NewRenovationCardState();
}

class _NewRenovationCardState extends State<NewRenovationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NewRenovationDetailPage(model: widget.model));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.w)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.model.roomName,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: ktextPrimary,
                  ),
                ),
                Spacer(),
                widget.model.statusString.text
                    .size(30.sp)
                    .color(widget.model.statusColor)
                    .bold
                    .make(),
              ],
            ),
            16.w.heightBox,
            BeeDivider.horizontal(),
            24.w.heightBox,
            ...<Widget>[
              _rowTile(
                R.ASSETS_ICONS_APPOINTMENT_CODE_PNG,
                '装修公司',
                widget.model.constructionUnit.text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .make(),
              ),
              _rowTile(
                R.ASSETS_ICONS_APPOINTMENT_CODE_PNG,
                '负责人姓名',
                widget.model.director.text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .make(),
              ),
              _rowTile(
                R.ASSETS_ICONS_APPOINTMENT_CODE_PNG,
                '负责人电话',
                widget.model.directorTel.text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .make(),
              ),
              _rowTile(
                R.ASSETS_ICONS_APPOINTMENT_CODE_PNG,
                '预计装修时间',
                widget.model.expectSlot.text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .make(),
              ),
              ..._nullableRowTile(
                  widget.model.actualEnd.isEmptyOrNull,
                  R.ASSETS_ICONS_APPOINTMENT_CODE_PNG,
                  '实际装修时间',
                  widget.model.actualSlot.text
                      .size(24.sp)
                      .color(ktextSubColor)
                      .make())
            ].sepWidget(separate: 12.w.heightBox),
            ..._bottomWidgets(),
          ],
        ),
      ),
    );
  }

  List<Widget> _bottomWidgets() {
    return (widget.model.status != 2)
        ? []
        : [
            40.w.heightBox,
            Row(
              children: [Spacer(), ..._getButtons()],
            ),
          ];
  }

  List<Widget> _getButtons() {
    List<CardBottomButton> buttons = [];
    switch (widget.model.status) {
      case 2:
        buttons = [
          CardBottomButton.yellow(
              text: '申请完工检查',
              onPressed: () async {
                BaseModel baseModel =
                    await NetUtil().get(API.manager.applyCompleteRenovation,
                        params: {
                          "userDecorationNewId": widget.model.id,
                        },
                        showMessage: true);
                if (baseModel.status ?? false) {
                  widget.callRefresh();
                }
              })
        ];
        break;
      default:
        buttons = [];
    }
    return buttons;
  }

  _nullableRowTile(
      bool isNull, String assetPath, String title, Widget content) {
    return isNull
        ? []
        : [
            _rowTile(assetPath, title, content),
          ];
  }

  Widget _rowTile(String assetPath, String titile, Widget content) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: 40.w,
          height: 40.w,
        ),
        12.w.widthBox,
        titile.text.size(24.sp).color(ktextSubColor).make(),
        Spacer(),
        content,
      ],
    );
  }
}
