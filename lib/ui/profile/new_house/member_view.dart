import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/saas_model/my_house/my_family_member_list_model.dart';
import 'package:aku_new_community/ui/profile/new_house/my_house_page.dart';
import 'package:aku_new_community/utils/bee_map.dart';
import 'package:aku_new_community/utils/enum/identify.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import '../../../model/common/img_model.dart';
import '../../../widget/bee_avatar_widget.dart';

class MemberView extends StatefulWidget {
  const MemberView({Key? key}) : super(key: key);

  @override
  _MemberViewState createState() => _MemberViewState();
}

class _MemberViewState extends State<MemberView> {
  List<MyFamilyMemberListModel> _memberModels = [];

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      firstRefresh: true,
      header: MaterialHeader(),
      footer: MaterialFooter(),
      onRefresh: () async {
        var base = await NetUtil().get(SAASAPI.profile.family.myFamilyMember);
        if (base.success) {
          _memberModels = (base.data as List)
              .map((e) => MyFamilyMemberListModel.fromJson(e))
              .toList();
          setState(() {});
        }
      },
      child: _memberModels.isEmpty
          ? HouseEmptyWidget()
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
              itemBuilder: (context, index) {
                return _card(_memberModels[index]);
              },
              separatorBuilder: (_, __) {
                return 24.w.heightBox;
              },
              // itemCount: _memberModels.length,
              itemCount: _memberModels.length,
            ),
    );
  }

  Widget _card(MyFamilyMemberListModel model) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
            child: '${model.buildingName}栋${model.unitName}单元${model.estateName}'
                .text
                .size(32.sp)
                .color(Colors.black.withOpacity(0.85))
                .bold
                .make(),
          ),
          BeeDivider.horizontal(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                ...model.members
                    .map((e) => _avatar(e.imgList,Identify.values[e.identity], e.name))
                    .toList()
              ],
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          )
        ],
      ),
    );
  }

  Widget _avatar(
    List<ImgModel> imgModel,
    Identify identify,
    String name,
  ) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          fit: StackFit.passthrough,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.w),
                  border: Border.all(color: kPrimaryColor, width: 4.w)),
              child: BeeAvatarWidget(
                width: 80.w,
                height: 80.w,
                imgs: imgModel,
              ),
            ),
            Positioned(
                bottom: -20.w,
                left: -10.w,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(58.w),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                      width: 108.w,
                      height: 40.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1C87F).withOpacity(0.4),
                      ),
                      child: Text(
                        '${BeeMap.getIdentify(identify)}',
                        style: TextStyle(
                            fontSize: 22.sp,
                            color: Colors.black.withOpacity(0.85)),
                      )),
                ))
          ],
        ),
        26.w.heightBox,
        name.text.size(28.sp).color(Colors.black.withOpacity(0.45)).make(),
      ],
    );
  }
}
