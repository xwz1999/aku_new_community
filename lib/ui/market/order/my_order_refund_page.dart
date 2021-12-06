import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/market/order/my_order_list_model.dart';
import 'package:aku_new_community/ui/market/order/my_order_func.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/aku_single_check_button.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/others/bee_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MyOrderRefundPage extends StatefulWidget {
  final MyOrderListModel model;

  MyOrderRefundPage({Key? key, required this.model}) : super(key: key);

  @override
  _MyOrderRefundPageState createState() => _MyOrderRefundPageState();
}

class _MyOrderRefundPageState extends State<MyOrderRefundPage> {
  int _type = 1; //退换类型，1为退款，2为换货
  late TextEditingController _editingController;

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
      title: '商品退换',
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
            BaseModel baseModel = await MyOrderFunc.refundOrder(
                widget.model.id, _editingController.text, _type);
            if (baseModel.status ?? false) {
              Get.back();
            }
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
          '退换原因'.text.size(32.sp).bold.color(ktextPrimary).make(),
          32.w.heightBox,
          Row(
            children: [
              AkuSingleCheckButton(
                text: '退款',
                value: 1,
                gropValue: _type,
                onPressed: () {
                  _type = 1;
                  setState(() {});
                },
              ),
              80.w.widthBox,
              AkuSingleCheckButton(
                text: '换货',
                value: 2,
                gropValue: _type,
                onPressed: () {
                  _type = 2;
                  setState(() {});
                },
              ),
            ],
          ),
          32.w.heightBox,
          BeeTextField(controller: _editingController, hintText: '请详细描述问题及原因')
        ],
      ),
    );
  }
}
