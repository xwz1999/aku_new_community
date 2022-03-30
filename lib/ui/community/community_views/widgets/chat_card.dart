import 'dart:math';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/community/all_dynamic_list_model.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/community/community_views/add_new_event_page.dart';
import 'package:aku_new_community/ui/community/community_views/event_detail_page.dart';
import 'package:aku_new_community/utils/bee_date_util.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/login_util.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/picker/bee_image_preview.dart';
import 'package:aku_new_community/widget/views/bee_grid_image_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatCard extends StatefulWidget {
  final AllDynamicListModel model;
  final VoidCallback? onDelete;

  final bool hideLine;
  final bool canTap;

  ChatCard({
    Key? key,
    required this.model,
    this.onDelete,
    this.hideLine = false,
    this.canTap = true,
  }) : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  bool get _isMyself {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return (userProvider.userInfoModel?.id ?? -1) == widget.model.createId;
  }

  late bool _isLiked;
  late int _likeNum;

  _renderImage() {
    if (widget.model.dynamicList.isEmpty) return SizedBox();
    if (widget.model.dynamicList.length == 1)
      return MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        minWidth: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
        ),
        onPressed: () {
          BeeImagePreview.toPath(
            path: ImgModel.first(widget.model.dynamicList),
            tag: ImgModel.first(widget.model.dynamicList),
          );
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 300.w,
            maxWidth: 300.w,
          ),
          child: FadeInImage.assetNetwork(
            placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            image: SAASAPI.image(ImgModel.first(widget.model.dynamicList)),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                height: 300.w,
                width: 300.w,
              );
            },
          ),
        ),
      );
    else
      return BeeGridImageView(
          urls: widget.model.dynamicList.map((e) => e.url).toList());
  }

  _buildLikeAndComment() {
    return Padding(
      padding: EdgeInsets.only(top: 24.w, left: 32.w, right: 32.w),
      child: Row(
        children: [
          '${widget.model.views}浏览'
              .text
              .size(24.sp)
              .color(Color(0xFF999999))
              .make(),
          Spacer(),
          GestureDetector(
            onTap: () async {
              var res = await NetUtil().get(SAASAPI.community.dynamicLike,
                  params: {'dynamicId': widget.model.id});
              if (res.success) {
                _isLiked = !_isLiked;
                if (_isLiked) {
                  _likeNum += 1;
                } else {
                  _likeNum -= 1;
                }

                BotToast.showText(text: _isLiked ? '点赞成功' : '取消点赞成功');
                setState(() {});
              } else {
                BotToast.showText(text: res.msg);
              }
            },
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  Image.asset(
                    R.ASSETS_ICONS_COMMUNITY_LIKE_PNG,
                    width: 32.w,
                    height: 32.w,
                    color: !_isLiked
                        ? Colors.black.withOpacity(0.45)
                        : kPrimaryColor,
                  ),
                  5.wb,
                  '${_likeNum}'
                      .text
                      .size(24.sp)
                      .color(Color(0xFF999999))
                      .make(),
                ],
              ),
            ),
          ),
          20.wb,
          GestureDetector(
            onTap: widget.model.isComment == 1 ? () async {} : () async {},
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  Image.asset(R.ASSETS_ICONS_COMMUNITY_COMMENT_PNG,
                      width: 32.w,
                      height: 32.w,
                      color: Colors.black.withOpacity(0.45)),
                  5.wb,
                  '${widget.model.commentNum}'
                      .text
                      .size(24.sp)
                      .color(Color(0xFF999999))
                      .make(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _isLiked = widget.model.isLike;
    _likeNum = widget.model.likes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: widget.canTap
            ? () async {
                Get.to(() => EventDetailPage(
                      dynamicId: widget.model.id,
                      onDelete: widget.onDelete,
                    ));
              }
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            [
              Material(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(48.w),
                clipBehavior: Clip.antiAlias,
                child: FadeInImage.assetNetwork(
                  placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  image:
                      SAASAPI.image(ImgModel.first(widget.model.avatarImgList)),
                  height: 96.w,
                  width: 96.w,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                      height: 86.w,
                      width: 86.w,
                    );
                  },
                ),
              ).paddingOnly(left: 32.w),
              20.wb,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.createName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.85),
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  12.hb,
                  BeeDateUtil(DateUtil.getDateTime(widget.model.createDate))
                      .timeAgoWithHm
                      .text
                      .size(24.sp)
                      .color(Color(0xFF999999))
                      .make(),
                ],
              ),
              Spacer(),
              CommunityPopButton(
                isMyself: _isMyself,
                onSelect: (dynamic _) async {
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
                          child:
                              '确定'.text.color(Colors.orange).isIntrinsic.make(),
                          onPressed: () => Get.back(result: true),
                        ),
                      ],
                    ));

                    if (result == true) {
                      await NetUtil().get(
                        API.community.deleteMyEvent,
                        params: {'themeId': widget.model.id},
                        showMessage: true,
                      );
                      if (widget.onDelete != null) widget.onDelete!();
                    }
                  }
                },
              ).paddingOnly(right: 32.w),
            ].row(crossAlignment: CrossAxisAlignment.start),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    32.hb,
                    Offstage(
                      offstage: widget.model.content.isEmptyOrNull,
                      child: Column(
                        children: [
                          widget.model.content!.text.size(32.sp).black.make(),
                          32.hb,
                        ],
                      ),
                    ),
                    _renderImage(),
                    widget.model.topicTags.isEmpty
                        ? SizedBox()
                        : TopicWidgets(topicTags: widget.model.topicTags)
                            .pOnly(top: 20.w),
                    20.hb,
                  ],
                ).paddingOnly(right: 32.w, left: 32.w),
                Divider(height: 1.w, thickness: 1.w),
                10.hb,
                _buildLikeAndComment(),
              ],
            ),
          ],
        ).paddingOnly(top: 32.w, bottom: 32.w),
      ),
    ).paddingOnly(bottom: 16.w);
  }
}

class CommunityPopButton extends StatelessWidget {
  const CommunityPopButton({
    Key? key,
    required this.isMyself,
    required this.onSelect,
  }) : super(key: key);

  final bool isMyself;
  final Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
      itemBuilder: (context) {
        return [
          isMyself
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
      onSelected: onSelect,
      child: Container(
          width: 80.w,
          height: 80.w,
          alignment: Alignment.center,
          child: Image.asset(
            R.ASSETS_ICONS_ICON_MORE_PNG,
            width: 8.w,
            height: 32.w,
            fit: BoxFit.fitHeight,
          )),
    );
  }
}
