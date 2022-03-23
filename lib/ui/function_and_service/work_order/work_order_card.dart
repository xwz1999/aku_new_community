import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/work_order/work_order_list_model.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_detail_page.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_func.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_map.dart';
import 'package:aku_new_community/utils/bee_date_util.dart';
import 'package:aku_new_community/widget/buttons/card_bottom_button.dart';
import 'package:aku_new_community/widget/views/bee_hor_image_view.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class WorkOrderCard extends StatelessWidget {
  final WorkOrderListModel model;
  final VoidCallback refresh;

  const WorkOrderCard({Key? key, required this.model, required this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 9.35.w,
            right: 0,
            child: Container(
              width: 160.w,
              height: 60.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFFFAC058),
                      Color(0xFFFFD589),
                    ]),
                color: kPrimaryColor,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(12.w)),
              ),
              alignment: Alignment.center,
              child: Text(
                '${WorkOrderMap.orderStatus[model.status]}',
                style: TextStyle(
                  fontSize: 26.sp,
                  color: Colors.black,
                ),
              ),
            )),
        GestureDetector(
          onTap: () {
            Get.to(() => WorkOrderDetailPage(
                  model: model,
                ));
          },
          child: ClipPath(
            clipper: WorkOrderCardClip(),
            child: Container(
              padding: EdgeInsets.all(24.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.w),
                    bottomLeft: Radius.circular(12.w),
                    bottomRight: Radius.circular(12.w)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.w, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFBE6),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: '${model.workOrderTypeName}'
                            .text
                            .size(24.sp)
                            .color(Color(0xFFD48806))
                            .make(),
                      ),
                    ],
                  ),
                  16.hb,
                  Row(
                    children: [
                      Assets.icons.alarmClock.image(width: 40.w, height: 40.w),
                      24.wb,
                      '${model.updateDate}'
                          .text
                          .size(24.sp)
                          .color(Colors.black.withOpacity(0.45))
                          .make(),
                    ],
                  ),
                  16.hb,
                  Row(
                    children: [
                      Assets.icons.taskLocation
                          .image(width: 40.w, height: 40.w),
                      24.wb,
                      '${model.reserveAddress}'
                          .text
                          .size(24.sp)
                          .color(Colors.black.withOpacity(0.45))
                          .make(),
                    ],
                  ),
                  60.hb,
                  '${model.content}'
                      .text
                      .size(28.sp)
                      .color(Colors.black.withOpacity(0.65))
                      .make(),
                  24.hb,
                  BeeHorImageView(
                      maxCount: 4, imgs: [], imgWidth: 146.w, imgHeight: 146.w),
                  24.hb,
                  Row(
                    children: [
                      BeeDateUtil(DateUtil.getDateTime(model.createDate))
                          .timeAgo
                          .text
                          .size(24.sp)
                          .color(Colors.black.withOpacity(0.45))
                          .make(),
                      Spacer(),
                      24.wb,
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          CupertinoIcons.ellipsis_vertical,
                          size: 40.w,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget getCardBottomButton() {
    switch (model.status) {
      case 1:
        return SizedBox.shrink();
      case 2:
        return SizedBox.shrink();
      case 3:
      case 4:
        return CardBottomButton.yellow(
            text: '催促进度',
            onPressed: () async {
              var re = await WorkOrderFuc.promotionRate(model.id);
              if (re) {
                refresh();
              }
            });
      case 5:
        return CardBottomButton.yellow(
            text: '确认完成',
            onPressed: () async {
              var re = await WorkOrderFuc.confirmComplete(model.id);
              if (re) {
                refresh();
              }
            });
      case 6:
        return CardBottomButton.yellow(text: '去支付', onPressed: () {});
      case 7:
        return CardBottomButton.yellow(text: '去评价', onPressed: () {});
      case 8:
        return CardBottomButton.yellow(text: '查看评价', onPressed: () {});
      case 9:
      case 10:
      default:
        return SizedBox.shrink();
    }
  }
}

class WorkOrderCardClip extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    //第一段圆弧起始位置的横坐标
    double asx = 531.w;
    //第一段圆弧终点位置横坐标
    double aex = 542.46.w;
    //第一段圆弧终点位置纵坐标
    double aey = 9.34.w;

    //第一段圆弧控制点位置横坐标
    double acx = 540.w;

    //第二段圆弧起始点位置横坐标
    double bsx = 558.45.w;
    //第二段圆弧起始点位置纵坐标
    double bsy = 58.88.w;
    //第二段圆弧终点点位置横坐标
    double bex = 569.91.w;
    //第二段圆弧终点位纵横坐标
    double bey = 67.35.w;
    //第二段圆弧控制点位置横坐标
    double bcx = 561.06.w;
    //第二段圆弧控制点位置纵坐标
    double bcy = 67.35.w;
    path.lineTo(asx, 0);
    path.quadraticBezierTo(acx, 0, aex, aey);
    path.lineTo(bsx, bsy);
    path.quadraticBezierTo(bcx, bcy, bex, bey);
    path.lineTo(size.width, bey);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }
}
