import 'dart:math';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/community/event_item_model.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/community/community_views/widgets/chat_card_detail.dart';
import 'package:aku_new_community/ui/community/community_views/widgets/send_a_chat.dart';
import 'package:aku_new_community/utils/login_util.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class EventDetailPage extends StatefulWidget {
  final int? themeId;
  final EventItemModel eventItemModel;
  final VoidCallback? onDelete;

  EventDetailPage({
    Key? key,
    required this.themeId,
    required this.eventItemModel, this.onDelete,
  }) : super(key: key);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  EventItemModel? _model;

  bool get _isMyself {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return (userProvider.userInfoModel?.id ?? -1) ==
        widget.eventItemModel.createId;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '详情',
      bottomNavi: _bottomButton(),
      actions: [
        PopupMenuButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
          itemBuilder: (context) {
            return [
              _isMyself
                  ? PopupMenuItem(
                      child: '删除'.text.isIntrinsic.make(),
                      value: 0,
                    )
                  : PopupMenuItem(
                      child: '举报'.text.isIntrinsic.make(),
                      value: 0,
                    ),
            ];
          },
          onSelected: (dynamic _) async {
            if (LoginUtil.isNotLogin) return;
            if (!_isMyself) {
              VoidCallback cancel = BotToast.showLoading();
              await Future.delayed(
                  Duration(milliseconds: 500 + Random().nextInt(500)));
              cancel();
              BotToast.showText(text: '举报成功');
            } else {
              bool? result = await Get.dialog(CupertinoAlertDialog(
                title: '你确定删除吗'.text.isIntrinsic.make(),
                actions: [
                  CupertinoDialogAction(
                    child: '取消'.text.black.isIntrinsic.make(),
                    onPressed: () => Get.back(),
                  ),
                  CupertinoDialogAction(
                    child: '确定'.text.color(Colors.orange).isIntrinsic.make(),
                    onPressed: () => Get.back(result: true),
                  ),
                ],
              ));

              if (result == true) {
                await NetUtil().get(
                  API.community.deleteMyEvent,
                  params: {'themeId': widget.themeId},
                  showMessage: true,
                );
                if (widget.onDelete != null) {
                  widget.onDelete!();
                  Get.back();
                }
              }
            }
          },
          child: Container(
              width: 40.w,
              height: 32.w,
              alignment: Alignment.center,
              child: Image.asset(
                R.ASSETS_ICONS_ICON_MORE_BLACK_PNG,
                width: 40.w,
                height: 32.w,
                fit: BoxFit.fitHeight,
              )),
        ).paddingOnly(right: 32.w),
      ],
      body: EasyRefresh(
        controller: _refreshController,
        header: MaterialHeader(),
        firstRefresh: true,
        onRefresh: () async {
          BaseModel model = await NetUtil().get(
            API.community.getEventDetail,
            params: {'themeId': widget.themeId},
          );
          _model = EventItemModel.fromJson(model.data);
          setState(() {});
        },
        child: _model == null
            ? SizedBox()
            : ListView(
                children: [
                  ChatCardDetail(
                    model: _model,
                    hideLine: true,
                    canTap: false,
                  ),
                ],
              ),
      ),
    );
  }

  _bottomButton() {
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
        width: double.infinity,
        height: 100.w,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Color(0x4D000000),
              offset: Offset(0.0, -1), //阴影xy轴偏移量
              blurRadius: 0, //阴影模糊程度
              spreadRadius: 0 //阴影扩散程度
              )
        ]
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  if (widget.eventItemModel.isComment == 1)
                    SendAChat.send(
                      parentId: 0,
                      themeId: widget.eventItemModel.id,
                    );
                  else
                    BotToast.showText(text: '不可评论');
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Image.asset(R.ASSETS_ICONS_COMMUNITY_COMMENT_PNG,width: 50.w,height: 50.w,),
                      //Image.asset(widget.model!.isComment!=1?R.ASSETS_ICONS_COMMUNITY_COMMENT_PNG:R.ASSETS_ICONS_COMMUNITY_COMMENT_IS_PNG,width: 32.w,height: 32.w,),
                      5.wb,
                      '评论'
                          .text
                          .size(30.sp)
                          .color(Color(0xFF999999))
                          .make(),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: GestureDetector(
                onTap: ()async{
                  await NetUtil().get(
                    API.community.like,
                    params: {'themeId': widget.eventItemModel.id},
                    showMessage: true,
                  );
                  setState(() {
                    if (widget.eventItemModel.isLike == 0) {
                      widget.eventItemModel.likeNames!.add(
                        LikeNames(
                          id: Random().nextInt(1000),
                          name: userProvider.userInfoModel!.nickName,
                        ),
                      );
                    } else {
                      widget.eventItemModel.likeNames!.removeWhere(
                              (element) =>
                          element.name ==
                              userProvider.userInfoModel!.nickName);
                    }
                    widget.eventItemModel.isLike =
                    (widget.eventItemModel.isLike == 1) ? 0 : 1;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(widget.eventItemModel.isLike!=1? R.ASSETS_ICONS_COMMUNITY_LIKE_PNG:R.ASSETS_ICONS_COMMUNITY_LIKE_IS_PNG,width: 50.w,height: 50.w,),
                      5.wb,
                      '点赞'
                          .text
                          .size(30.sp)
                          .color(Color(0xFF999999))
                          .make(),
                    ],
                  ),
                ),
              ),
            ),

          ],
        )

    );
  }

}
