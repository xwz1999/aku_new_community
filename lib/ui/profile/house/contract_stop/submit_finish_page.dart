import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/models/house/lease_detail_model.dart';
import 'package:aku_community/ui/profile/house/house_func.dart';
import 'package:aku_community/ui/profile/house/contract_stop/pay_surplus_rent_page.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/others/finish_result_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SubmitFinishPage extends StatefulWidget {
  final int status;
  final int leaseId;
  SubmitFinishPage({Key? key, required this.status, required this.leaseId})
      : super(key: key);

  @override
  _SubmitFinishPageState createState() => _SubmitFinishPageState();
}

class _SubmitFinishPageState extends State<SubmitFinishPage> {
  String get statusString {
    switch (widget.status) {
      case 11:
        return '审核中';
      case 12:
        return '审核失败';
      case 13:
        return '审核通过';
      default:
        return '未知';
    }
  }
    String get contentString {
    switch (widget.status) {
      case 11:
        return '您提交的申请正在人工审核中，请耐心等待';
      case 12:
        return '您提交的申请审核未通过，详情情况请联系物业';
      case 13:
        return '您的提交的申请审核成功！';
      default:
        return '未知';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      body: Center(
        child: Column(
          children: [
            276.w.heightBox,
            FinishResultImage(
              status: widget.status == 12 ? false : true,
              haveInHandStatus: widget.status == 11 ? true : false,
            ),
            48.w.heightBox,
            statusString.text.black.size(36.sp).make(),
            48.w.heightBox,
            contentString.text.black.size(28.sp).make(),
            96.w.heightBox,
            widget.status != 13
                ? SizedBox()
                : MaterialButton(
                    elevation: 0,
                    minWidth: 702.w,
                    height: 98.w,
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.w)),
                    onPressed: () async {
                      LeaseDetailModel? model =
                          await HouseFunc().leaseDetail(widget.leaseId);
                      if (model != null) {
                        Get.to(() => PaySuerplusRentPage(
                          id:widget.leaseId,
                              time: model.notMeterRentDate ?? '',
                              amount: model.requiredRent ?? 0,
                            ));
                      }
                    },
                    child: '去支付'.text.color(ktextPrimary).size(36.sp).make(),
                  ),
          ],
        ),
      ),
    );
  }
}
