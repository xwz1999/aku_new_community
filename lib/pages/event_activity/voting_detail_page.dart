import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/voting_detail_model.dart';
import 'package:akuCommunity/pages/manager_func.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/widget/bee_divider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/buttons/bee_single_check.dart';
import 'package:akuCommunity/widget/buttons/bottom_button.dart';

class VotingDetailPage extends StatefulWidget {
  final int id;

  VotingDetailPage({Key key, this.id}) : super(key: key);

  @override
  _VotingDetailPageState createState() => _VotingDetailPageState();
}

class _VotingDetailPageState extends State<VotingDetailPage> {
  VotingDetailModel _model;
  EasyRefreshController _refreshController;
  bool _isOnload = true;
  // List<int> _select = [];
  int _selectId;
  bool _hasVoted = false;
  bool get isVoted {
    if ((_model.status == 4) || _hasVoted) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  Widget _unCheck() {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Color(0xFF979797),
          width: 3.w,
        ),
        borderRadius: BorderRadius.circular(20.w),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          color: kDarkSubColor,
          borderRadius: BorderRadius.circular(12.w),
        ),
      ),
    );
  }

  Widget _buildVoteCard(AppVoteCandidateVos model) {
    double _percent = (model.total.toDouble()) / (_model.totals.toDouble());
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.w),
      constraints: BoxConstraints(maxHeight: 230.w),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 88.w,
            height: 150.w,
            //多选
            // child: BeeCheckBox(
            //   isRound: true,
            //   size: 30.w,
            //   onChange: (value) {
            //     if (value) {
            //       if (!_select.contains(model.id)) {
            //         _select.add(model.id);
            //       }
            //     } else {
            //       _select.remove(model.id);
            //     }
            //   },
            // ),
            //
            //
            //暂时用单选
            child: _model.status == 3 || _model.status == 1
                ? _unCheck()
                : GestureDetector(
                    onTap: () {
                      _selectId = model.id;
                      setState(() {});
                    },
                    child: BeeSingleCheck(
                      value: model.id,
                      groupValue: _selectId,
                    ),
                  ).material(color: Colors.transparent),
          ),
          SizedBox(
            width: 150.w,
            height: 150.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.w),
              child: FadeInImage.assetNetwork(
                  placeholder: R.ASSETS_IMAGES_LOGO_PNG,
                  image: API.image(model.imgUrls.first.url)),
            ),
          ),
          30.w.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // '测试'.text.black.size(32.sp).make(),
              // 10.w.heightBox,
              model.name.text.black.size(32.sp).make(),
              33.w.heightBox,
              isVoted && _model.status != 3
                  ? Row(
                      children: [
                        SizedBox(
                          width: 280.w,
                          child: LinearProgressIndicator(
                            value: _percent,
                          ),
                        ),
                        8.w.widthBox,
                        '$_percent%'
                            .text
                            .color(ktextSubColor)
                            .size(24.sp)
                            .make(),
                      ],
                    )
                  : SizedBox()
            ],
          ).expand(),
        ],
      ),
    );
  }

  Widget _emptyWidget() {
    return Container();
  }

  Widget _shouwVoteDialog() {
    return CupertinoAlertDialog(
      title: '投票成功'.text.black.size(32.sp).bold.isIntrinsic.make(),
      actions: [
        CupertinoDialogAction(
          child: '取消'.text.black.size(34.sp).isIntrinsic.make(),
          onPressed: () {
            Get.back();
          },
        ),
        CupertinoDialogAction(
          child: '查看结果'
              .text
              .color(kPrimaryColor)
              .size(34.sp)
              .bold
              .isIntrinsic
              .make(),
          onPressed: () {
            Get.back();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '活动详情',
      body: EasyRefresh(
        firstRefresh: true,
        controller: _refreshController,
        onRefresh: () async {
          await ManagerFunc.voteDetail(widget.id)
              .then((value) => _model = value);
          _isOnload = false;
          setState(() {});
        },
        header: MaterialHeader(),
        child: _isOnload
            ? _emptyWidget()
            : ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 26.w,
                ),
                children: [
                  _model.title.text.black.size(32.sp).bold.maxLines(2).make(),
                  44.w.heightBox,
                  SizedBox(
                    width: double.infinity,
                    height: 228.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.w),
                      child: FadeInImage.assetNetwork(
                          placeholder: R.ASSETS_IMAGES_LOGO_PNG,
                          image: API.image(_model.imgUrls.first.url)),
                    ),
                  ),
                  44.w.heightBox,
                  _model.content.text.black.size(28.sp).make(),
                  44.w.heightBox,
                  Container(
                    padding: EdgeInsets.fromLTRB(32.w, 50.w, 32.w, 0),
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // '测试标题'
                        //     .text
                        //     .color(Color(0xFF999999))
                        //     .size(32.sp)
                        //     .make(), //TODO:缺少字段；
                        // 26.w.heightBox,
                        ..._model.appVoteCandidateVos
                            .map((e) => _buildVoteCard(e))
                            .toList()
                            .sepWidget(separate: BeeDivider.horizontal()),
                      ],
                    ),
                  )
                ],
              ),
      ),
      bottomNavi: BottomButton(
          onPressed: () async {
            if (_selectId == null) {
              BotToast.showText(text: '请先选择候选人！');
            } else {
              BaseModel baseModel =
                  await ManagerFunc.vote(_selectId, widget.id);
              if (baseModel.status) {
                Get.dialog(_shouwVoteDialog());
                _hasVoted = true;
                setState(() {});
              } else {
                BotToast.showText(text: '${baseModel.message}');
              }
            }
          },
          child: '投票'.text.black.size(28.sp).bold.make()),
    );
  }
}
