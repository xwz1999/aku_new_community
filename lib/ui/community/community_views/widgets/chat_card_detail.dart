import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/community/dynamic_detail_model.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/community/community_views/add_new_event_page.dart';
import 'package:aku_new_community/utils/bee_date_util.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/picker/bee_image_preview.dart';
import 'package:aku_new_community/widget/views/bee_grid_image_view.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatCardDetail extends StatefulWidget {
  final DynamicDetailModel model;

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
    return (userProvider.userInfoModel?.id ?? -1) == widget.model.createId;
  }

  _renderImage() {
    if (widget.model.dynamicImgList.isEmpty) return SizedBox();
    if (widget.model.dynamicImgList.length == 1)
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
            path: ImgModel.first(widget.model.dynamicImgList),
            tag: ImgModel.first(widget.model.dynamicImgList),
          );
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 300.w,
            maxWidth: 300.w,
          ),
          child: Hero(
            tag: ImgModel.first(widget.model.dynamicImgList),
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: SARSAPI.image(ImgModel.first(widget.model.dynamicImgList)),
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
          urls: widget.model.dynamicImgList.map((e) => e.url).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
                  image:
                      SARSAPI.image(ImgModel.first(widget.model.avatarImgList)),
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
              Image.asset(
                R.ASSETS_ICONS_COMMUNITY_LIKE_PNG,
                width: 40.w,
                height: 40.w,
              ),
              5.wb,
              '${widget.model.likes}'
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
                    32.hb,
                    widget.model.content!.text
                        .size(28.sp)
                        .color(ktextSubColor)
                        .make(),
                    32.hb,
                    _renderImage(),
                    20.hb,
                    TopicWidgets(
                      topicTags: widget.model.topicTags,
                    ),
                  ],
                ).paddingOnly(right: 32.w, left: 32.w),

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
    ]).paddingOnly(bottom: 16.w);
  }

  // _renderLikeAndComment() {
  //   if (widget.model!.likeNames!.isEmpty &&
  //       widget.model!.gambitThemeCommentVoList!.isEmpty) return SizedBox();
  //   return Material(
  //     borderRadius: BorderRadius.circular(8.w),
  //     color: Color(0xFFF7F7F7),
  //     child: Padding(
  //       padding: EdgeInsets.all(8.w),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           widget.model!.likeNames!.isEmpty ? SizedBox() : _renderLike(),
  //           10.hb,
  //           (widget.model!.likeNames!.isNotEmpty &&
  //                   widget.model!.gambitThemeCommentVoList!.isNotEmpty)
  //               ? Divider(height: 1.w, thickness: 1.w)
  //               : SizedBox(),
  //           10.hb,
  //           widget.model!.gambitThemeCommentVoList!.isEmpty
  //               ? SizedBox()
  //               : _renderComment(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

}
