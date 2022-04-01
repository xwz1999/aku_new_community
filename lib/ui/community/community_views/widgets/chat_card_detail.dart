import 'dart:math';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/model/community/event_item_model.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/community/community_views/event_detail_page.dart';
import 'package:aku_new_community/ui/community/community_views/widgets/send_a_chat.dart';
import 'package:aku_new_community/utils/bee_date_util.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/login_util.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/picker/bee_image_preview.dart';
import 'package:aku_new_community/widget/views/bee_grid_image_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatCardDetail extends StatefulWidget {
  final EventItemModel? model;

  final VoidCallback? onDelete;

  final bool hideLine;
  final bool canTap;

  ChatCardDetail({
    Key? key,
    required this.model,
    this.onDelete,
    this.hideLine = false,
    this.canTap = true,
  }) : super(key: key);

  @override
  _ChatCardDetailState createState() => _ChatCardDetailState();
}

class _ChatCardDetailState extends State<ChatCardDetail> {
  bool get _isMyself {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return (userProvider.userInfoModel?.id ?? -1) == widget.model!.createId;
  }

  _renderImage() {
    if (widget.model!.imgUrls!.isEmpty) return SizedBox();
    if (widget.model!.imgUrls!.length == 1)
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
            path: ImgModel.first(widget.model!.imgUrls),
            tag: ImgModel.first(widget.model!.imgUrls),
          );
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 300.w,
            maxWidth: 300.w,
          ),
          child: Hero(
            tag: ImgModel.first(widget.model!.imgUrls),
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: API.image(ImgModel.first(widget.model!.imgUrls)),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  height: 300.w,
                  width: 300.w,
                );
              },
            ),
          ),
        ),
      );
    else
      return BeeGridImageView(
          urls: widget.model!.imgUrls!.map((e) => e.url).toList());
  }

  _buildMoreButton() {
    return Builder(builder: (context) {
      final userProvider = Provider.of<UserProvider>(context);
      return MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.w),
        ),
        padding: EdgeInsets.zero,
        height: 40.w,
        minWidth: 0,
        color: Color(0xFFD8D8D8),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          if (LoginUtil.isNotLogin) return;
          BotToast.showAttachedWidget(
            targetContext: context,
            preferDirection: PreferDirection.leftCenter,
            attachedBuilder: (cancel) {
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Material(
                  color: Color(0xFFD8D8D8),
                  borderRadius: BorderRadius.circular(8.w),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    height: 78.w,
                    child: Row(

                      children: [
                        MaterialButton(
                          height: 78.w,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () async {
                            cancel();
                            await NetUtil().get(
                              API.community.like,
                              params: {'themeId': widget.model!.id},
                              showMessage: true,
                            );
                            setState(() {
                              if (widget.model!.isLike == 0) {
                                widget.model!.likeNames!.add(
                                  LikeNames(
                                    id: Random().nextInt(1000),
                                    name: userProvider.userInfoModel!.nickName,
                                  ),
                                );
                              } else {
                                widget.model!.likeNames!.removeWhere(
                                    (element) =>
                                        element.name ==
                                        userProvider.userInfoModel!.nickName);
                              }
                              widget.model!.isLike =
                                  (widget.model!.isLike == 1) ? 0 : 1;
                            });
                          },
                          child: [
                            widget.model!.isLike == 1
                                ? Icon(Icons.favorite,
                                    size: 30.w, color: Colors.red)
                                : Icon(Icons.favorite_border, size: 30.w),
                            10.wb,
                            '赞'.text.make(),
                          ].row(),
                        ),
                        VerticalDivider(width: 1.w, thickness: 1.w),
                        MaterialButton(
                          height: 78.w,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            if (widget.model!.isComment == 1)
                              SendAChat.send(
                                parentId: 0,
                                themeId: widget.model!.id,
                              );
                            else
                              BotToast.showText(text: '不可评论');
                          },
                          child: [
                            Icon(CupertinoIcons.bubble_right, size: 30.w),
                            10.wb,
                            '评论'.text.make(),
                          ].row(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Row(
          children: [
            20.wb,
            Container(
              height: 8.w,
              width: 8.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.w),
              ),
            ),
            8.wb,
            Container(
              height: 8.w,
              width: 8.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.w),
              ),
            ),
            20.wb,
          ],
        ),
      );
    });
  }

  _buildLikeAndComment(){
    return Row(
      children: [
        30.wb,
        '${widget.model!.views}浏览'

            .text
            .size(24.sp)
            .color(Color(0xFF999999))
            .make(),
        Spacer(),
        Image.asset(R.ASSETS_ICONS_COMMUNITY_LIKE_PNG,width: 32.w,height: 32.w,),
        //Image.asset(widget.model!.isLike!=1? R.ASSETS_ICONS_COMMUNITY_LIKE_PNG:R.ASSETS_ICONS_COMMUNITY_LIKE_IS_PNG,width: 32.w,height: 32.w,),
        5.wb,
        '${widget.model!.likeNamesNum}'
            .text
            .size(24.sp)
            .color(Color(0xFF999999))
            .make(),
        20.wb,
        Image.asset(R.ASSETS_ICONS_COMMUNITY_COMMENT_PNG,width: 32.w,height: 32.w,),
        //Image.asset(widget.model!.isComment!=1?R.ASSETS_ICONS_COMMUNITY_COMMENT_PNG:R.ASSETS_ICONS_COMMUNITY_COMMENT_IS_PNG,width: 32.w,height: 32.w,),
        5.wb,
        '${widget.model!.gambitThemeCommentNum}'
            .text
            .size(24.sp)
            .color(Color(0xFF999999))
            .make(),
        30.wb,
      ],
    );
  }
  _renderLike() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Icon(Icons.favorite_border_rounded, size: 24.w),
          14.wb,
          ...widget.model!.likeNames!
              .map((e) => Container(child: e.name!.text.make(),margin: EdgeInsets.only(right: 10.w),))
              .toList()
              .sepWidget(separate: ','.text.make()),
        ],
      ),
    );
  }

  _renderComment() {
    return Padding(
      padding:  EdgeInsets.only(left: 20.w,right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.model!.gambitThemeCommentVoList!.map((e) {

          // StringBuffer buffer = StringBuffer();
          // buffer.write(e.createName);
          //
          // if (e.parentName != null) buffer.write('  回复  ${e.parentName}');
          // buffer.write(': ${e.content}');
          return InkWell(
            child:     e.createName!.richText.color(Color(0xFF5D98F9)).size(24.sp).withTextSpanChildren([

              e.parentName != null ?' 回复'.textSpan.size(24.sp).color(ktextSubColor).make():
              ''.textSpan.size(24.sp).color(Color(0xFF5D98F9)).make(),
              e.parentName != null ?' ${e.parentName}'.textSpan.size(24.sp).color(Color(0xFF5D98F9)).make():
              ''.textSpan.size(24.sp).color(ktextPrimary).make(),
              ' : '.textSpan.size(24.sp).color(ktextPrimary).make(),
              '${e.content}'.textSpan.size(24.sp).black.make(),
            ]).make(),
            onTap: () {
              SendAChat.send(parentId: e.id, themeId: widget.model!.id);
            },
          );
        }).toList(),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
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
                    image: API
                        .image(ImgModel.first(widget.model!.headSculptureImgUrl)),
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
                      widget.model!.createName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.85),
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    12.hb,
                    BeeDateUtil(widget.model!.date)
                        .timeAgoWithHm
                        .text
                        .size(24.sp)
                        .color(Color(0xFF999999))
                        .make(),
                  ],
                ),
                Spacer(),
                Image.asset(R.ASSETS_ICONS_COMMUNITY_LIKE_PNG,width: 40.w,height: 40.w,),
                //Image.asset(widget.model!.isLike!=1? R.ASSETS_ICONS_COMMUNITY_LIKE_PNG:R.ASSETS_ICONS_COMMUNITY_LIKE_IS_PNG,width: 32.w,height: 32.w,),
                5.wb,
                '${widget.model!.likeNamesNum}'
                    .text
                    .size(24.sp)
                    .color(Color(0xFF999999))
                    .make(),
                32.wb,
              ].row(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          32.hb,
                          widget.model!.content!.text.size(28.sp).color(ktextSubColor).make(),
                          32.hb,
                          _renderImage(),
                        ],
                      ).paddingOnly(left: 116.w),
                      Row(
                        children: [
                          widget.model!.gambitTitle?.isEmpty ?? true
                              ? SizedBox()
                              : Chip(
                            label: '# ${widget.model!.gambitTitle}'
                                .text
                                .color(Color(0xFF547fc0))
                                .size(28.sp)
                                .make(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 5.w),
                            labelPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            // shape: StadiumBorder(
                            //   side: BorderSide(),
                            // ),
                          ).pOnly(top: 20.w),

                        ],
                      ),

                      20.hb,
                    ],
                  ).paddingOnly(right: 32.w, left: 32.w)
                 ,

                  // Divider(height: 1.w, thickness: 1.w),
                  // 10.hb,
                  // Row(
                  //   children: [
                  //     // 64.hb,
                  //
                  //     Spacer(),
                  //     _buildMoreButton(),
                  //     20.wb,
                  //   ],
                  // ),
                  20.hb,
                  //_buildLikeAndComment(),

                ],
              ),
            ],
          ).paddingOnly(top: 20.w),
        ).marginOnly(top: 12.w, bottom: 12.w),
        _renderLikeAndCommentWidget()
      ]


    ).paddingOnly(bottom: 16.w);
  }

  _renderLikeAndComment() {
    if (widget.model!.likeNames!.isEmpty &&
        widget.model!.gambitThemeCommentVoList!.isEmpty) return SizedBox();
    return Material(
      borderRadius: BorderRadius.circular(8.w),
      color: Color(0xFFF7F7F7),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.model!.likeNames!.isEmpty ? SizedBox() : _renderLike(),
            10.hb,
            (widget.model!.likeNames!.isNotEmpty &&
                widget.model!.gambitThemeCommentVoList!.isNotEmpty)
                ? Divider(height: 1.w, thickness: 1.w)
                : SizedBox(),
            10.hb,
            widget.model!.gambitThemeCommentVoList!.isEmpty
                ? SizedBox()
                : _renderComment(),
          ],
        ),
      ),
    );
  }

  _renderLikeAndCommentWidget(){
    return Container(
      padding: EdgeInsets.only(top: 22.w,bottom: 22.w),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              32.wb,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  ('评论'+'${widget.model!.gambitThemeCommentNum!}').text.size(28.sp).black.make(),
                  Container(
                    width: 32.w,
                    height: 2.w,
                    color: Color(0xCCFFB634),
                  )
                ],
              ),
              Spacer(),
              GestureDetector(
                child: Container(
                  child: Row(
                    children: [
                      Image.asset(R.ASSETS_ICONS_ICON_SORT_PNG,height: 40.w,width: 40.w,),
                      8.wb,
                      ('按时间').text.size(28.sp).color(ktextPrimary).make(),
                    ],
                  ),
                ),
              ),
              32.wb,
            ],
          ),
          _renderLikeAndComment(),


        ],
      ),
    );
  }

  _commentWidget(List<ImgModel>? headSculptureImgUrl,String createName,DateTime? date,num? likeNamesNum){
    return Container(
      color: Colors.white,
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
                image: API
                    .image(ImgModel.first(headSculptureImgUrl)),
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
                  createName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.85),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500),
                ),
                12.hb,
                BeeDateUtil(date)
                    .timeAgoWithHm
                    .text
                    .size(24.sp)
                    .color(Color(0xFF999999))
                    .make(),
              ],
            ),
            Spacer(),
            Image.asset(R.ASSETS_ICONS_COMMUNITY_LIKE_PNG,width: 40.w,height: 40.w,),
            //Image.asset(widget.model!.isLike!=1? R.ASSETS_ICONS_COMMUNITY_LIKE_PNG:R.ASSETS_ICONS_COMMUNITY_LIKE_IS_PNG,width: 32.w,height: 32.w,),
            5.wb,
            '${likeNamesNum}'
                .text
                .size(24.sp)
                .color(Color(0xFF999999))
                .make(),
            32.wb,
          ].row(),
          20.hb,
          widget.model!.content!.text.size(28.sp).color(ktextSubColor).make(),


        ],
      ).paddingOnly(top: 20.w),
    ).marginOnly(top: 12.w, bottom: 12.w);
  }

}
