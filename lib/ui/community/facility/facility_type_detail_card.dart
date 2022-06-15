import 'package:aku_new_community/ui/community/facility/facility_preorder_date_picker.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/utils/headers.dart';
import '../../../constants/saas_api.dart';
import '../../../models/facility/facility_type_detail_model.dart';
import '../../../models/facility/facility_type_model.dart';
import '../../../utils/network/base_model.dart';
import '../../../utils/network/net_util.dart';
import '../../../widget/bee_image_network.dart';
import 'facility_preorder_page.dart';

class FacilityTypeDetailCard extends StatefulWidget {
  final FacilityTypeDetailModel model;
  final FacilityTypeModel facilityModel;

  FacilityTypeDetailCard(
      {Key? key, required this.model, required this.facilityModel})
      : super(key: key);

  @override
  _FacilityTypeDetailCardState createState() => _FacilityTypeDetailCardState();
}

class _FacilityTypeDetailCardState extends State<FacilityTypeDetailCard> {
  List datesNum = [];

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _load();
            }));
    super.initState();
  }

  _load() async {
    BaseModel model =
        await NetUtil().get(SAASAPI.facilities.allAppointmentPeriod, params: {
      'facilitiesManageId': widget.model.id,
      'todayDate': DateTime.now(),
    });
    if (model.success) {
      datesNum = (model.data as List);
      print(datesNum);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      padding: EdgeInsets.all(30.w),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Material(
                borderRadius: BorderRadius.circular(10.w),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: BeeImageNetwork(
                  imgs: widget.model.imgList ?? [],
                  height: 150.h,
                  width: 200.w,
                  fit: BoxFit.cover,
                ),
                // FadeInImage.assetNetwork(
                //   placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                //   image: SAASAPI.image(ImgModel.first(model.imgList)),
                //   height: 150.h,
                //   width: 200.w,
                //   fit: BoxFit.cover,
                // ),
              ),
              30.wb,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.name,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  15.hb,
                  '${DateUtil.formatDate(widget.model.openStartDT, format: 'HH:mm')}-${DateUtil.formatDate(widget.model.openEndDT, format: 'HH:mm')}  开放'
                      .text
                      .size(20.sp)
                      .make(),
                  12.hb,
                  '${widget.model.address}'
                      .text
                      .size(20.sp)
                      .color(BaseStyle.color474747)
                      .make(),
                ],
              ),
            ],
          ),
          30.hb,
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (int i = 0; i < 25; i++)
                Text(
                  '${i}',
                  style: TextStyle(
                    fontSize: 19.sp,
                  ),
                ),
            ],
          ),
          10.hb,
          Container(
            padding: EdgeInsets.only(left: 2.w, right: 2.w),
            alignment: Alignment.centerLeft,
            width: 615.w,
            height: 40.h,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black12,
              ),
            ),
            child: CustomPaint(
              foregroundPainter: MyPainter(datesNum, widget.model),
            ),
          ),
        ],
      ),
      onPressed: () {
        Get.off(
          () => FacilityPreorderPage(
            facilityModel: widget.facilityModel,
            typeModel: widget.model,
          ),
        );
      },
    );
  }
}

class MyPainter extends CustomPainter {
  Path path = new Path();
  List? dates;
  FacilityTypeDetailModel? model;
  DateTime? start;
  DateTime? end;

  MyPainter(List dates, FacilityTypeDetailModel model) {
    this.dates = dates;
    this.model = model;
    start = model.openStartDT!;
    end = model.openEndDT!;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 48; i++) {
      Paint _paint = Paint()
        ..color = dates!.contains(i)
            ? kPrimaryColor
            : i < getNum(start!) ||
                    i >= getNum(end!) ||
                    i < getNum(DateTime.now())
                ? ktextThirdColor
                : Colors.transparent
        ..strokeWidth = 40.h;
      if (dates!.contains(i) ||
          i <= getNum(start!) ||
          i >= getNum(end!) ||
          i <= getNum(DateTime.now())) {
        canvas.translate(0, 0);
        canvas.drawLine(
            Offset(12.7.w * i - 1, 0), Offset(12.7.w * (i + 1), 0), _paint);
      }
    }
    print(getNum(start!));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
