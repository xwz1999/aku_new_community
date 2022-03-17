import 'dart:math';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/community/comment_list_model.dart';
import 'package:aku_new_community/models/community/dynamic_detail_model.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/community/community_views/widgets/chat_card.dart';
import 'package:aku_new_community/ui/community/community_views/widgets/chat_card_detail.dart';
import 'package:aku_new_community/utils/bee_date_util.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/login_util.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EventDetailPage extends StatefulWidget {
  final int dynamicId;
  final VoidCallback? onDelete;

  EventDetailPage({
    Key? key,
    required this.dynamicId,
    this.onDelete,
  }) : super(key: key);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  DynamicDetailModel? _model;

  bool get _isMyself {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return (userProvider.userInfoModel?.id ?? -1) == widget.dynamicId;
  }

  TextEditingController _textEditingController = TextEditingController();

  //评论根id
  int _rootId = 0;

  //回复的id
  int _parentId = 0;

  int _page = 1;
  int _type = 1;
  int _size = 10;
  int _currentCommentIndex = 0;
  List<CommentListModel> _comments = [];
  List<bool> _folds = [];
  List<bool> _likes = [];

  //评论输入框焦点
  FocusNode _focusNode = FocusNode();

  Map<String, dynamic> get params => {
        'rootId': _rootId,
        'parentId': _parentId,
        'dynamicId': widget.dynamicId,
        'content': _textEditingController.text
      };

  Future updateComments() async {
    var base = await NetUtil().get(SAASAPI.community.singleComment, params: {
      'commentId': _comments[_currentCommentIndex].id,
    });
    if (base.success) {
      _comments.removeAt(_currentCommentIndex);
      _comments.insert(
          _currentCommentIndex, CommentListModel.fromJson(base.data));
    } else {
      BotToast.showText(text: base.msg);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '详情',
      bottomNavi: _bottomButton(),
      actions: [
        (CommunityPopButton(
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
                    child: '确定'.text.color(Colors.orange).isIntrinsic.make(),
                    onPressed: () => Get.back(result: true),
                  ),
                ],
              ));

              if (result == true) {
                if (widget.onDelete != null) {
                  widget.onDelete!();
                  Get.back();
                }
              }
            }
          },
        )).paddingOnly(right: 32.w),
      ],
      body: EasyRefresh.custom(
        controller: _refreshController,
        header: MaterialHeader(),
        firstRefresh: true,
        onRefresh: () async {
          BaseModel model = await NetUtil().get(
            SAASAPI.community.dynamicDetail,
            params: {'dynamicId': widget.dynamicId},
          );
          _model = DynamicDetailModel.fromJson(model.data);
          _page = 1;
          var base =
              await NetUtil().getList(SAASAPI.community.commentList, params: {
            'pageNum': _page,
            'size': _size,
            'dynamicId': widget.dynamicId,
            'type': _type,
          });
          _comments =
              base.rows.map((e) => CommentListModel.fromJson(e)).toList();
          _folds = List.filled(_size, true);
          _comments.forEach((element) {
            if (element.isLike) {
              _likes.add(true);
            } else {
              _likes.add(false);
            }
          });
          setState(() {});
        },
        onLoad: () async {
          _page++;
          var base =
              await NetUtil().getList(SAASAPI.community.commentList, params: {
            'pageNum': _page,
            'size': _size,
            'dynamicId': widget.dynamicId,
            'type': _type,
          });
          if (_comments.length < base.total) {
            var _list =
                base.rows.map((e) => CommentListModel.fromJson(e)).toList();
            _comments.addAll(_list);
            _folds.addAll(List.filled(_list.length, true));
            _list.forEach((element) {
              if (element.isLike) {
                _likes.add(true);
              } else {
                _likes.add(false);
              }
            });
          }
          setState(() {});
        },
        slivers: _model == null
            ? []
            : [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _rootId = 0;
                          _parentId = 0;
                        },
                        child: ChatCardDetail(
                          model: _model!,
                          hideLine: true,
                          canTap: false,
                        ),
                      ),
                      _renderLikeAndCommentWidget(),
                    ],
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(_comments
                        .mapIndexed((e, index) => _commentWidget(e, index))
                        .toList()
                        .sepWidget(
                            separate: BeeDivider.horizontal(
                          indent: 32.w,
                          endIndent: 32.w,
                        ))))
              ],
      ),
    );
  }

  _renderLikeAndCommentWidget() {
    return Container(
      padding: EdgeInsets.only(top: 22.w, bottom: 22.w),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              32.wb,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ('评论 ' + '${_model!.commentNum}')
                      .text
                      .size(28.sp)
                      .black
                      .make(),
                  8.hb,
                  Container(
                    width: 64.w,
                    height: 4.w,
                    color: Color(0xCCFFB634),
                  )
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  if (_type == 1) {
                    _type = 2;
                  } else {
                    _type = 1;
                  }
                  _refreshController.callRefresh();
                },
                child: Container(
                  child: Row(
                    children: [
                      Image.asset(
                        R.ASSETS_ICONS_ICON_SORT_PNG,
                        height: 40.w,
                        width: 40.w,
                      ),
                      8.wb,
                      ('${_type == 1 ? '按时间' : '按热度'}')
                          .text
                          .size(28.sp)
                          .color(ktextPrimary)
                          .make(),
                    ],
                  ),
                ),
              ),
              32.wb,
            ],
          ),
          // _renderLikeAndComment(),
        ],
      ),
    );
  }

  Widget _commentWidget(CommentListModel model, int rootIndex) {
    return Container(
      // key: UniqueKey(),
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
      width: double.infinity,
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
                image: SAASAPI.image(ImgModel.first(model.avatarImgList)),
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
            ),
            20.wb,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.createName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.85),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500),
                ),
                12.hb,
                BeeDateUtil(DateUtil.getDateTime(model.createDate))
                    .timeAgoWithHm
                    .text
                    .size(24.sp)
                    .color(Color(0xFF999999))
                    .make(),
              ],
            ),
            Spacer(),
            CommunityPopButton(isMyself: false, onSelect: (value) {})
          ].row(),
          40.hb,
          model.content.text.size(28.sp).color(ktextSubColor).make(),
          30.hb,
          GestureDetector(
            onTap: () async {
              var res =
                  await NetUtil().get(SAASAPI.community.commentLike, params: {
                'commentId': model.id,
              });
              if (res.success) {
                _likes[rootIndex] = !_likes[rootIndex];
                setState(() {});
              }
            },
            child: Row(
              children: [
                Spacer(),
                Image.asset(
                  R.ASSETS_ICONS_COMMUNITY_LIKE_PNG,
                  width: 40.w,
                  height: 40.w,
                ),
                5.wb,
                '${model.likes}'
                    .text
                    .size(24.sp)
                    .color(Color(0xFF999999))
                    .make(),
                32.wb,
                GestureDetector(
                  onTap: () {
                    _rootId = model.id;
                    _parentId = model.id;
                    _focusNode.requestFocus();
                    _currentCommentIndex = rootIndex;
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        R.ASSETS_ICONS_COMMUNITY_COMMENT_PNG,
                        width: 40.w,
                        height: 40.w,
                      ),
                    ],
                  ),
                ),
                5.wb,
                '${model.commentNum}'
                    .text
                    .size(24.sp)
                    .color(Color(0xFF999999))
                    .make(),
              ],
            ),
          ),
          40.hb,
          model.commentTwoList.isEmpty
              ? SizedBox.shrink()
              : Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16.w)),
                  margin: EdgeInsets.only(left: 125.w),
                  width: 600.w,
                  padding:
                      EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...List.generate(
                          model.commentTwoList.length < 3
                              ? model.commentTwoList.length
                              : 3,
                          (index) => _subCommentWidget(
                              model.commentTwoList[index],
                              model.createId,
                              model.id,
                              rootIndex)),
                      if (model.commentTwoList.length > 3)
                        _foldComment(model, rootIndex)
                    ].sepWidget(separate: 24.hb),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _foldComment(CommentListModel model, int rootIndex) {
    return _folds[rootIndex]
        ? Row(
            children: [
              '共有${model.commentNum}条回复'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              Spacer(),
              TextButton(
                  onPressed: () {
                    _folds[rootIndex] = false;
                    setState(() {});
                  },
                  child: '展开'.text.size(28.sp).color(Color(0xFF5D98F9)).make())
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                  model.commentTwoList.length - 3,
                  (index) => _subCommentWidget(model.commentTwoList[index + 3],
                      model.createId, model.id, rootIndex))
            ].sepWidget(separate: 24.hb),
          );
  }

  Widget _subCommentWidget(
      CommentTwoList model, int createId, int rootId, int rootIndex) {
    return GestureDetector(
      onTap: () {
        _rootId = rootId;
        _parentId = model.id;
        _focusNode.requestFocus();
        _currentCommentIndex = rootIndex;
      },
      child: RichText(
          text: TextSpan(
              text: '${model.createName}',
              style: TextStyle(
                color: Color(0xFF5D98F9),
                fontSize: 28.sp,
              ),
              children: [
            if (createId == model.createId)
              WidgetSpan(
                  child: Container(
                width: 56.w,
                height: 28.w,
                margin: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 4.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFFF8B133),
                    borderRadius: BorderRadius.circular(4.w)),
                child: Text(
                  '楼主',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold),
                ),
              )),
            if (model.parentName != null)
              TextSpan(
                  text: ' 回复 ',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.85),
                    fontSize: 28.sp,
                  )),
            if (model.parentName != null)
              TextSpan(
                text: '${model.parentName}',
                style: TextStyle(
                  color: Color(0xFF5D98F9),
                  fontSize: 28.sp,
                ),
              ),
            TextSpan(
                text: '：${model.content}',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.85),
                  fontSize: 28.sp,
                ))
          ])),
    );
  }

  _bottomButton() {
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
        width: double.infinity,
        height: 100.w,
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 32.w),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 56.w,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(32.w),
                ),
                child: TextField(
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: '参与评论',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.w),
                      isDense: true,
                      hintStyle: TextStyle(
                        fontSize: 28.sp,
                        color: Colors.black.withOpacity(0.25),
                      ),
                      border: InputBorder.none),
                ),
              ),
            ),
            24.w.widthBox,
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(34.w),
              ),
              elevation: 0,
              color: kPrimaryColor,
              minWidth: 120.w,
              height: 55.w,
              onPressed: () async {
                var res = await NetUtil()
                    .post(SAASAPI.community.commentInsert, params: params);
                if (res.success) {
                  _textEditingController.clear();
                  if (_rootId == 0) {
                    _refreshController.callRefresh();
                  } else {
                    await updateComments();
                    _focusNode.unfocus();
                  }
                  setState(() {});
                } else {
                  BotToast.showText(text: res.msg);
                }
              },
              child: Text(
                '发布',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.sp),
              ),
            )
          ],
        ));
  }
}
