import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/common/img_model.dart';
import 'package:akuCommunity/utils/bee_date_util.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatCard extends StatefulWidget {
  final String name;
  final String title;
  final List<ImgModel> headImg;
  final List<ImgModel> contentImg;
  final DateTime date;
  final bool canDelete;
  ChatCard({
    Key key,
    this.name,
    this.title,
    this.headImg,
    this.contentImg,
    @required this.date,
    this.canDelete,
  }) : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  String get firstHead {
    if (widget.headImg == null || widget.headImg.isEmpty)
      return '';
    else
      return widget.headImg.first.url;
  }

  _renderImage() {
    if (widget.contentImg.isEmpty) return SizedBox();
    if (widget.contentImg.length == 1)
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 300.w,
          minWidth: 300.w,
        ),
        child: FadeInImage.assetNetwork(
          placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
          image: API.image(widget.contentImg.first.url),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E5),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6.w),
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: API.image(firstHead),
              height: 86.w,
              width: 86.w,
            ),
          ),
          24.wb,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.name.text.size(36.sp).make(),
              6.hb,
              widget.title.text.make(),
              20.hb,
              _renderImage(),
              Row(
                children: [
                  BeeDateUtil(widget.date).timeAgo.text.make(),
                  Spacer(),
                ],
              ),
            ],
          ).expand(),
        ],
      ).p(20.w),
    );
  }
}
