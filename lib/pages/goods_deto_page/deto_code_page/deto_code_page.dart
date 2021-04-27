import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:aku_community/model/manager/article_QR_code_model.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/dotted_line.dart';

class DetoCodePage extends StatelessWidget {
  final int? id;
  final ArticleQRModel? model;
  const DetoCodePage({Key? key, this.id, this.model}) : super(key: key);

  Widget _header(String estateName) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(Get.context!)!.tempPlotName,
            style: TextStyle(fontSize: 40.sp, color: Color(0xffffffff)),
          ),
          SizedBox(height: 10.w),
          Text(
            estateName,
            style: TextStyle(fontSize: 26.sp, color: Color(0xffffffff)),
          ),
        ],
      ),
    );
  }

  Widget _card(String? name, String? effectiveTime) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(16.w)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 75.w,
        vertical: 32.w,
      ),
      padding: EdgeInsets.only(
        bottom: 16.w,
        left: 32.w,
        right: 21.w,
        top: 25.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    AntDesign.contacts,
                    size: 40.sp,
                    color: Color(0xff999999),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '$name先生',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 36.sp,
                        color: Color(0xff333333)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 13.w),
          Text(
            '有效时间：$effectiveTime',
            style: TextStyle(
              fontSize: 26.sp,
              color: Color(0xff999999),
            ),
          ),
          SizedBox(height: 23.w),
          DottedLine(color: Color(0xfff5f5f5)),
          Container(
            padding: EdgeInsets.only(
              top: 30.w,
              bottom: 38.w,
            ),
            height: 389.w,
            alignment: Alignment.center,
            child: Column(
              children: [
                // Text(
                //   '020-598-230',
                //   style: TextStyle(
                //     fontWeight: FontWeight.w600,
                //     fontSize: 36.sp,
                //     color: Color(0xff333333),
                //   ),
                // ),
                // SizedBox(height: 11.w),
                QrImage(
                  padding: EdgeInsets.zero,
                  data: model!.appArticleOutQRCodeVo!.id.toString(),
                  size: 260.w,
                ),
              ],
            ),
          ),
          DottedLine(color: Color(0xfff5f5f5)),
          SizedBox(height: 16.w),
          Container(
            alignment: Alignment.center,
            child: Text(
              '出户时，请出示此证给门岗',
              style: TextStyle(
                fontSize: 24.sp,
                color: Color(0xff999999),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return BeeScaffold(
      title: '出户二维码',
      body: Container(
        color: Color(0xff333333),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 192.w - kToolbarHeight),
                _header(appProvider.selectedHouse!.roomName!),
                SizedBox(height: 32.w),
                _card(model!.appArticleOutQRCodeVo!.applicantName,
                    model!.appArticleOutQRCodeVo!.effectiveTime),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
