import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/model/message/comment_message_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/utils/bee_date_util.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CommentMessagePage extends StatefulWidget {
  CommentMessagePage({Key? key}) : super(key: key);

  @override
  _CommentMessagePageState createState() => _CommentMessagePageState();
}

class _CommentMessagePageState extends State<CommentMessagePage> {
  EasyRefreshController? _easyRefreshController;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _easyRefreshController?.dispose();
    super.dispose();
  }

  String getTime(String time) {
//  var dif= DateTime.now().difference(DateUtil.getDateTime(time));
    return BeeDateUtil(DateUtil.getDateTime(time)).timeAgo;
  }

  Widget _messageContent(CommentMessageModel model) {
    if (model.type == 2) {
      return Icon(
        CupertinoIcons.heart,
        size: 32.w,
      );
    } else {
      return ((model.respondentName?.isEmptyOrNull ?? true)
              ? model.content
              : '回复了${model.respondentName}:${model.content}')!
          .text
          .black
          .size(28.sp)
          .isIntrinsic
          .make();
    }
  }

  Widget buildCard(CommentMessageModel model) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 750.w),
      padding: EdgeInsets.fromLTRB(32.w, 32.w, 32.w, 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 86.w,
            height: 86.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.w),
            ),
            clipBehavior: Clip.antiAlias,
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: API.image(ImgModel.first(model.headSculpture)),
              fit: BoxFit.cover,
            ),
          ),
          10.wb,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              model.createName!.text.black.size(36.sp).ellipsis.make(),
              10.w.heightBox,
              _messageContent(model),
              16.w.heightBox,
              getTime(model.createDate!)
                  .text
                  .color(Color(0xFF999999))
                  .size(28.sp)
                  .make(),
            ],
          ).expand(),
          Container(
            width: 160.w,
            height: 160.w,
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: API.image(ImgModel.first(model.imgUrls)),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '评论通知',
      body: BeeListView<CommentMessageModel>(
          path: API.message.commentMessageList,
          controller: _easyRefreshController,
          convert: (models) {
            return models.tableList!
                .map((e) => CommentMessageModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return buildCard(items[index]);
                },
                separatorBuilder: (_, __) {
                  return BeeDivider.horizontal();
                },
                itemCount: items.length);
          }),
    );
  }
}
