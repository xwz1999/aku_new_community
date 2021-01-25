import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AdviceEvaluatePage extends StatefulWidget {
  final int id;
  AdviceEvaluatePage({Key key, @required this.id}) : super(key: key);

  @override
  _AdviceEvaluatePageState createState() => _AdviceEvaluatePageState();
}

class _AdviceEvaluatePageState extends State<AdviceEvaluatePage> {
  int _rating = 10;
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '评价',
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          VxBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                '请您对本次服务进行评价'.text.size(28.sp).color(Color(0xFF999999)).make(),
                50.hb,
                Row(
                  children: [
                    '综合评价'.text.size(28.sp).color(Color(0xFF999999)).make(),
                    50.wb,
                    RatingBar.builder(
                      initialRating: _rating / 2,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      // itemPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemBuilder: (context, _) => Icon(
                        Icons.star_border_rounded,
                        color: kPrimaryColor,
                      ),
                      itemSize: 64.w,
                      onRatingUpdate: (rating) {
                        _rating = (rating * 2).floor();
                      },
                      glow: false,
                    )
                  ],
                ),
              ],
            ),
          ).padding(EdgeInsets.all(32.w)).white.make(),
          42.hb,
          MaterialButton(
            height: 96.w,
            shape: StadiumBorder(),
            color: kPrimaryColor,
            elevation: 0,
            onPressed: () async {
              BaseModel baseModel = await NetUtil().post(
                API.manager.adviceEvaluate,
                params: {'id': widget.id, 'score': _rating},
                showMessage: true,
              );
              if (baseModel.status) {
                Get.back();
                Get.back();
              }
            },
            child: '确认'.text.bold.size(32.sp).make(),
          ),
        ],
      ),
    );
  }
}
