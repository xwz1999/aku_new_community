import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/model/community/my_event_item_model.dart';
import 'package:aku_new_community/models/community/dynamic_my_list_body.dart';
import 'package:aku_new_community/models/community/dynamic_my_list_head.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/community/community_views/widgets/my_event_card.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/login_util.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/line/vertical_line_painter.dart';
import 'package:aku_new_community/widget/picker/bee_image_preview.dart';
import 'package:aku_new_community/widget/views/bee_grid_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../community_func.dart';

class MyCommunityView extends StatefulWidget {
  MyCommunityView({Key? key}) : super(key: key);

  @override
  MyCommunityViewState createState() => MyCommunityViewState();
}

class MyCommunityViewState extends State<MyCommunityView>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _refreshController = EasyRefreshController();
  bool _onload = true;
  List<DynamicMyListBody> _myEventItems = [];
  DynamicMyListHead? _head;

  refresh() {
    _refreshController.callRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var head = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: new DecorationImage(
            image: new AssetImage(
              R.ASSETS_IMAGES_COMMUNITY_MY_BG_PNG,
            ),
            fit: BoxFit.fitWidth),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          12.hb,
          Image.asset(
            R.ASSETS_ICONS_ICON_LOGISTICS_PNG,
            width: 132.w,
            height: 132.w,
          ),
          32.hb,
          '${_head?.createName}'
              .text
              .size(32.sp)
              .fontWeight(FontWeight.bold)
              .color(Color(0xD9000000))
              .make(),
          12.hb,
          '当一个新时代的有志青年'.text.size(24.sp).color(Color(0x73000000)).make(),
          32.hb,
        ],
      ),
    );
    var headNum = Container(
      width: double.infinity,
      height: 156.w,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                '${_head?.dynamicNum}'
                    .text
                    .size(40.sp)
                    .fontWeight(FontWeight.bold)
                    .color(Color(0xD9000000))
                    .make(),
                '动态'.text.size(24.sp).color(Color(0x73000000)).make(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                '${_head?.commentNum}'
                    .text
                    .size(40.sp)
                    .fontWeight(FontWeight.bold)
                    .color(Color(0xD9000000))
                    .make(),
                '评论'.text.size(24.sp).color(Color(0x73000000)).make(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                '${_head?.likesNum}'
                    .text
                    .size(40.sp)
                    .fontWeight(FontWeight.bold)
                    .color(Color(0xD9000000))
                    .make(),
                '点赞'.text.size(24.sp).color(Color(0x73000000)).make(),
              ],
            ),
          ),
        ],
      ),
    );
    return EasyRefresh(
      firstRefresh: true,
      header: MaterialHeader(),
      controller: _refreshController,
      onRefresh: () async {
        _myEventItems = await CommunityFunc.getMyEventItem();
        var base = await NetUtil().get(SAASAPI.community.dynamicMyListH);
        if (base.success) {
          _head = DynamicMyListHead.fromJson(base.data);
        }
        _onload = false;
        setState(() {});
      },
      child: _onload
          ? SizedBox()
          : ListView(
              children: [
                head,
                headNum,
                20.hb,
                ..._myEventItems
                    .map(
                      (e) => _getMoments(e),
                    )
                    .toList()
                    .sepWidget(separate: 20.hb),

                //_getMoments(),
                // _getMoments(),
              ],
            ),
    );

    BeeListView<MyEventItemModel>(
      path: API.community.myEvent,
      controller: _refreshController,
      convert: (model) {
        return model.rows.map((e) => MyEventItemModel.fromJson(e)).toList();
      },
      builder: (items) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          itemBuilder: (context, index) {
            final MyEventItemModel model = items[index];
            MyEventItemModel? preModel;
            if (index >= 1) preModel = items[index - 1];
            return MyEventCard(model: model, preModel: preModel);
          },
          separatorBuilder: (_, __) => 8.hb,
          itemCount: items.length,
        );
      },
    );
  }

  Widget _getMoments(DynamicMyListBody item) {
    return Container(
      padding:
          EdgeInsets.only(top: 32.w, left: 25.w, right: 32.w, bottom: 32.w),
      color: Colors.white,
      child: CustomPaint(
        painter: VerticalLinePainter(
            color: Color(0x0F000000),
            //最后一个调整为透明
            width: 4.w,
            //根据UI调整即可
            paddingTop: 100.w,
            //根据UI调整即可
            paddingLeft: 0,
            //根据UI调整即可
            paddingBottom: 100.w), //根据UI
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                '11.15'
                    .text
                    .size(32.sp)
                    .color(Color(0xA6000000))
                    .bold
                    .isIntrinsic
                    .make(),
                '2021'
                    .text
                    .size(24.sp)
                    .color(Color(0x73000000))
                    .bold
                    .isIntrinsic
                    .make(),
              ],
            ),
            50.wb,
            Column(
              children: [
                Container(
                  width: 552.w,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      '25.61'
                          .text
                          .size(28.sp)
                          .color(Color(0xA6000000))
                          .isIntrinsic
                          .make(),
                      PopupMenuButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.w)),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: '删除'.text.isIntrinsic.make(),
                              value: 0,
                            )
                          ];
                        },
                        onSelected: (dynamic _) async {
                          if (LoginUtil.isNotLogin) return;
                          bool? result = await Get.dialog(CupertinoAlertDialog(
                            title: '你确定删除吗'.text.isIntrinsic.make(),
                            actions: [
                              CupertinoDialogAction(
                                child: '取消'.text.black.isIntrinsic.make(),
                                onPressed: () => Get.back(),
                              ),
                              CupertinoDialogAction(
                                child: '确定'
                                    .text
                                    .color(Colors.orange)
                                    .isIntrinsic
                                    .make(),
                                onPressed: () => Get.back(result: true),
                              ),
                            ],
                          ));

                          // if (result == true) {
                          //   await NetUtil().get(
                          //     API.community.deleteMyEvent,
                          //     params: {'themeId': widget.model!.id},
                          //     showMessage: true,
                          //   );
                          //
                          // }
                        },
                        child: Container(
                            width: 32.w,
                            height: 32.w,
                            child: Image.asset(
                              R.ASSETS_ICONS_ICON_MORE_PNG,
                              width: 32.w,
                              height: 32.w,
                              fit: BoxFit.fitHeight,
                            )),
                      ),
                    ],
                  ),
                ),
                32.hb,
                Container(
                  width: 552.w,
                  child: item.content!.text
                      .size(28.sp)
                      .color(Color(0xA6000000))
                      .isIntrinsic
                      .black
                      .make(),
                ),
                40.hb,
                _renderImage(item)
              ],
            ),
          ],
        ),
      ),
    );
  }

  _renderImage(DynamicMyListBody item) {
    if (item.dynamicImgList.isEmpty) return SizedBox();
    if (item.dynamicImgList.length == 1)
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
            path: ImgModel.first(item.dynamicImgList),
            tag: ImgModel.first(item.dynamicImgList),
          );
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 300.w,
            maxWidth: 300.w,
          ),
          child: Hero(
            tag: ImgModel.first(item.dynamicImgList),
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: SAASAPI.image(ImgModel.first(item.dynamicImgList)),
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
      return Container(
        width: 552.w,
        child: BeeGridImageView(
            urls: item.dynamicImgList.map((e) => e.url).toList()),
      );
  }

  @override
  bool get wantKeepAlive => true;
}
