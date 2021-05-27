import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/models/market/order/my_order_list_model.dart';
import 'package:aku_community/ui/market/order/my_order_func.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/others/bee_text_field.dart';

class MyOrderEvaluationPage extends StatefulWidget {
  final MyOrderListModel model;
  MyOrderEvaluationPage({Key? key, required this.model}) : super(key: key);

  @override
  _MyOrderEvaluationPageState createState() => _MyOrderEvaluationPageState();
}

class _MyOrderEvaluationPageState extends State<MyOrderEvaluationPage> {
  late TextEditingController _editingController;
  int _rating = 10;
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '商品评价',
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          _goodsInfoWidget(),
          24.w.heightBox,
          _resonWidget(),
        ],
      ),
      bottomNavi: BottomButton(
          onPressed: () async {
            await MyOrderFunc.goodsEvalution(
                widget.model.id, _rating, _editingController.text);
          },
          child: '确认提交'.text.size(32.sp).color(ktextPrimary).bold.make()),
    );
  }

  Widget _goodsInfoWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              '商品信息'.text.size(32.sp).bold.color(ktextPrimary).make(),
              Spacer(),
              // widget.model.statusString.text
              //     .size(30.sp)
              //     .bold
              //     .color(widget.model.statusColor)
              //     .make(),
            ],
          ),
          16.w.heightBox,
          BeeDivider.horizontal(),
          24.w.heightBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.w),
                clipBehavior: Clip.antiAlias,
                child: FadeInImage.assetNetwork(
                    width: 160.w,
                    height: 160.w,
                    fit: BoxFit.cover,
                    placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                    image:
                        API.image(ImgModel.first(widget.model.goodsImgList))),
              ),
              24.w.widthBox,
              SizedBox(
                height: 160.w,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.model.goodsName.text
                            .size(28.sp)
                            .color(ktextPrimary)
                            .maxLines(2)
                            .overflow(TextOverflow.ellipsis)
                            .bold
                            .make(),
                        Spacer(),
                        '¥${widget.model.sellingPrice}'
                            .text
                            .size(28.sp)
                            .bold
                            .color(Color(0xFFE60E0E))
                            .make(),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        ('${widget.model.levelOneCategory}|${widget.model.levelTwoCategory}')
                            .text
                            .size(24.sp)
                            .color(ktextSubColor)
                            .make()
                      ],
                    ),
                    // 12.w.heightBox,
                    // Row(
                    //   children: [
                    //     ('${widget.model.levelTwoCategory}')
                    //         .text
                    //         .size(24.sp)
                    //         .color(ktextSubColor)
                    //         .make()
                    //   ],
                    // ),
                  ],
                ),
              ).expand()
            ],
          ),
        ],
      ),
    );
  }

  Widget _resonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 24.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '商品评价'.text.size(32.sp).bold.color(ktextPrimary).make(),
          32.w.heightBox,
          RatingBar.builder(
            initialRating: _rating / 2,
            minRating: 0,
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
              _rating = rating.floor();
            },
            glow: false,
          ),
          32.w.heightBox,
          BeeTextField(controller: _editingController, hintText: '请输入评价内容')
        ],
      ),
    );
  }
}
