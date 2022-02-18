import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/sars_model/my_house/my_family_examine_list_model.dart';
import 'package:aku_new_community/utils/bee_map.dart';
import 'package:aku_new_community/utils/enum/identify.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';

class ExamineView extends StatefulWidget {
  const ExamineView({Key? key}) : super(key: key);

  @override
  _ExamineViewState createState() => _ExamineViewState();
}

class _ExamineViewState extends State<ExamineView> {
  List<MyFamilyExamineListModel> _examineModels = [];
  int _currentIndex = 0;
  List<String> _tabs = ['全部', '待审核', '同意', '驳回'];
  EasyRefreshController _refreshController = EasyRefreshController();
  ScrollController _listScroll = ScrollController();

  @override
  void dispose() {
    _refreshController.dispose();
    _listScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
          child: Row(
            children: _tabs
                .mapIndexed((e, index) => _tab(index, e))
                .toList()
                .sepWidget(),
          ),
        ),
        Flexible(
            child: EasyRefresh(
          firstRefresh: true,
          controller: _refreshController,
          scrollController: _listScroll,
          header: MaterialHeader(),
          footer: MaterialFooter(),
          onRefresh: () async {
            var base = await NetUtil()
                .get(SARSAPI.profile.family.myFamilyMember, params: {
              'status': _currentIndex,
            });
            if (base.success) {
              _examineModels = (base.data as List)
                  .map((e) => MyFamilyExamineListModel.fromJson(e))
                  .toList();
              setState(() {});
            }
          },
          child: ListView.separated(
            shrinkWrap: true,
            controller: _listScroll,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
            itemBuilder: (context, index) {
              return _card(_examineModels[index]);
            },
            separatorBuilder: (_, __) {
              return 24.w.heightBox;
            },
            itemCount: _examineModels.length,
          ),
        )),
      ],
    );
  }

  Widget _tab(int index, String title) {
    return GestureDetector(
      onTap: () {
        _currentIndex = index;
        _refreshController.callRefresh();
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.w),
        decoration: BoxDecoration(
          color: _currentIndex == index
              ? Color(0xFFFAC058).withOpacity(0.5)
              : Colors.black.withOpacity(0.06),
          borderRadius: BorderRadius.circular(30.w),
          border: _currentIndex == index
              ? Border.all(color: Color(0xFFFAC058))
              : Border(),
        ),
        child: title.text
            .size(28.sp)
            .color(
                Colors.black.withOpacity(_currentIndex == index ? 0.65 : 0.45))
            .make(),
      ),
    );
  }

  Widget _card(MyFamilyExamineListModel model) {
    var info = Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 160.w,
                child: '申请人'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.45))
                    .make(),
              ),
              model.name.text.size(28.sp).black.make(),
            ],
          ),
          24.w.heightBox,
          Row(
            children: [
              SizedBox(
                width: 160.w,
                child: '申请身份'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.45))
                    .make(),
              ),
              '${BeeMap.getIdentify(Identify.values[model.identity])}'
                  .text
                  .size(28.sp)
                  .black
                  .make(),
            ],
          ),
          24.w.heightBox,
          Row(
            children: [
              SizedBox(
                width: 160.w,
                child: '联系方式'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.45))
                    .make(),
              ),
              model.tel.text.size(28.sp).black.make(),
            ],
          )
        ],
      ),
    );
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color(0xFFFFEAC3).withOpacity(0.31),
                      Colors.white
                    ])),
                child:
                    '${model.buildingName}${model.unitName}${model.estateName}'
                        .text
                        .size(32.sp)
                        .color(Colors.black.withOpacity(0.85))
                        .bold
                        .make(),
              ),
              Divider(
                color: Colors.black.withOpacity(0.06),
                height: 1.w,
              ),
              info,
              model.status == 1
                  ? Column(
                      children: [
                        BeeDivider.horizontal(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32.w, vertical: 24.w),
                          child: Row(
                            children: [
                              Spacer(),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26.sp)),
                                elevation: 0,
                                minWidth: 116.w,
                                height: 52.w,
                                color: Color(0xFFFAC058),
                                onPressed: () async {
                                  var base = await NetUtil().post(
                                      SARSAPI.profile.family.myFamilyReview,
                                      params: {
                                        'operate': 1,
                                        'estateReviewId': model.estateId,
                                      });
                                  if (base.success) {
                                    _refreshController.callRefresh();
                                  } else {
                                    BotToast.showText(text: base.msg);
                                  }
                                },
                                child: '通过'.text.size(28.sp).black.make(),
                              ),
                              24.w.widthBox,
                              MaterialButton(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.black.withOpacity(0.25)),
                                    borderRadius: BorderRadius.circular(26.sp)),
                                minWidth: 116.w,
                                height: 52.w,
                                color: Colors.white,
                                onPressed: () async {
                                  var base = await NetUtil().post(
                                      SARSAPI.profile.family.myFamilyReview,
                                      params: {
                                        'operate': 2,
                                        'estateReviewId': model.estateId,
                                      });
                                  if (base.success) {
                                    _refreshController.callRefresh();
                                  } else {
                                    BotToast.showText(text: base.msg);
                                  }
                                },
                                child: '驳回'
                                    .text
                                    .size(28.sp)
                                    .color(Colors.black.withOpacity(0.45))
                                    .make(),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
        if (model.status != 1)
          Positioned(
            right: 24.w,
            top: 110.w,
            child: Image.asset(model.status == 2
                ? Assets.icons.reject.path
                : Assets.icons.pass.path),
            width: 200.w,
            height: 200.w,
          )
      ],
    );
  }
}
