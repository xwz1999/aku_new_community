import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/others/stack_avatar.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ActivityDetailPage extends StatefulWidget {
  const ActivityDetailPage({Key? key}) : super(key: key);

  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  @override
  Widget build(BuildContext context) {
    var content = Container(
      width: double.infinity,
      padding: EdgeInsets.all(32.w),
      child: Column(
        children: [
          '活动详情'.text.size(32.sp).color(Colors.black).bold.make(),
          32.w.heightBox,
          ''.text.size(28.sp).color(Colors.black.withOpacity(0.45)).make(),
          32.w.heightBox,
          ...List.generate(
              0,
              (index) => Container(
                    width: 686.w,
                    height: 432.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Image.network(
                      '',
                      fit: BoxFit.fill,
                    ),
                  )),
        ],
      ),
    );
    return BeeScaffold(
      title: '活动详情',
      body: ListView(
        children: [
          _headWidget(),
          24.w.heightBox,
          content,
          24.w.heightBox,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
            height: 132.w,
            child: Row(
              children: [
                CircleAvatar(
                  child: FadeInImage.assetNetwork(
                    placeholder: Assets.images.placeholder.path,
                    image: '',
                  ),
                ),
                20.w.widthBox,
                Column(
                  children: [
                    '印象物业'.text.size(28.sp).color(Colors.black).make(),
                    8.w.heightBox,
                    '${S.of(context)!.tempPlotName}'
                        .text
                        .size(24.sp)
                        .color(Colors.black.withOpacity(0.25))
                        .make()
                  ],
                ),
                Spacer(),
                MaterialButton(
                  minWidth: 120.w,
                  height: 60.w,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.circular(30.w)),
                  child:
                      '联系物业'.text.size(24.sp).color(Colors.blueAccent).make(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavi: BottomButton(
        child: '立即报名'.text.size(32.sp).color(Colors.black).bold.make(),
        onPressed: () {},
      ),
    );
  }

  Container _headWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            Assets.images.logo.path,
            width: double.infinity,
            height: 280.w,
          ),
          Padding(
            padding: EdgeInsets.all(32.w),
            child: Column(
              children: [
                '人才公寓党政建设讲座系列活动——庆祝中国共产党建党71周年活动'
                    .text
                    .size(32.sp)
                    .color(Colors.black.withOpacity(0.85))
                    .maxLines(3)
                    .bold
                    .make(),
                32.w.heightBox,
                Container(
                  width: 104.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                      color: Color(0xFFFEC076).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.w)),
                  alignment: Alignment.center,
                  child:
                      '报名中'.text.size(24.sp).color(Color(0xFFF481170)).make(),
                ),
                32.w.heightBox,
                _buildTile(
                  '报名时间',
                  '${DateUtil.formatDate(
                    DateTime.now(),
                    format: 'yyyy.MM.dd HH:mm',
                  )}-${DateUtil.formatDate(
                    DateTime.now(),
                    format: 'yyyy.MM.dd HH:mm',
                  )}',
                ),
                _buildTile(
                  '活动时间',
                  '${DateUtil.formatDate(
                    DateTime.now(),
                    format: 'yyyy.MM.dd HH:mm',
                  )}-${DateUtil.formatDate(
                    DateTime.now(),
                    format: 'yyyy.MM.dd HH:mm',
                  )}',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Row(
                    children: [
                      '活动方式'.text.size(28.sp).make().box.width(136.w).make(),
                      '本次活动介绍'
                          .richText
                          .tap(() {
                            var bottomSheet = Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(32.w),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.w)),
                              child: Column(
                                children: [
                                  '活动介绍'.text.size(32.sp).black.bold.make(),
                                  32.w.heightBox,
                                ],
                              ),
                            );
                            Get.bottomSheet(
                              bottomSheet,
                            );
                          })
                          .size(28.sp)
                          .make(),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Row(
                    children: [
                      '活动费用'.text.size(28.sp).make().box.width(136.w).make(),
                      '免费'.richText.size(28.sp).make(),
                      Spacer(),
                    ],
                  ),
                ),
                32.w.heightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Row(
                    children: [
                      '活动地点'.text.size(28.sp).make().box.width(136.w).make(),
                      '永恒智慧大厦'.richText.tap(() {}).size(28.sp).make(),
                      Spacer(),
                    ],
                  ),
                ),
                32.w.heightBox,
                BeeDivider.horizontal(
                  indent: 32.w,
                  endIndent: 32.w,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 32.w, right: 32.w, top: 16.w, bottom: 24.w),
                    child: Row(
                      children: [
                        StackAvatar(
                          avatars: [],
                        ),
                        16.w.heightBox,
                        '200'
                            .richText
                            .withTextSpanChildren(
                                ['/1000人参与'.textSpan.size(24.sp).black.make()])
                            .color(Colors.blueAccent)
                            .size(24.sp)
                            .make(),
                        Spacer(),
                        Icon(
                          CupertinoIcons.chevron_right,
                          size: 40.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildTile(String title, String subTitle) {
    return Row(
      children: [
        title.text.size(28.sp).make().box.width(136.w).make(),
        subTitle.text.size(28.sp).make().expand(),
      ],
    ).pSymmetric(h: 32.w);
  }
}
