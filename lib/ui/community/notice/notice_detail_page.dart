import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/community/board_detail_model.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/picker/bee_image_preview.dart';
import 'package:aku_community/widget/views/%20bee_download_view.dart';

class NoticeDetailPage extends StatefulWidget {
  final int? id;
  NoticeDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _NoticeDetailPageState createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  BoardDetailModel? model;

  Widget get emptyWidget => Column(
        children: [],
      );

  Widget docView(String? title, String? path) {
    if (title?.isEmpty ?? true) return SizedBox();
    return Container(
      margin: EdgeInsets.only(right: 113.w),
      alignment: Alignment.centerLeft,
      child: MaterialButton(
        minWidth: 606.w,
        height: 154.w,
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Row(
          children: [
            title!.text.size(32.sp).make().expand(),
            Image.asset(
              R.ASSETS_ICONS_FILE_PNG,
              height: 52.w,
              width: 52.w,
            ),
          ],
        ),
        onPressed: () async {
          String? result = await Get.dialog(BeeDownloadView(file: path));
          if (result != null) OpenFile.open(result);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
          side: BorderSide(color: Color(0xFFD4CFBE)),
        ),
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '社区公告',
      body: EasyRefresh(
        controller: _refreshController,
        header: MaterialHeader(),
        onRefresh: () async {
          BaseModel baseModel = await NetUtil().get(
            API.community.boardDetail,
            params: {'announcementId': widget.id},
          );
          if (baseModel.data != null) {
            model = BoardDetailModel.fromJson(baseModel.data);
          }
          setState(() {});
        },
        firstRefresh: true,
        firstRefreshWidget: emptyWidget,
        child: model == null
            ? SizedBox()
            : ListView(
                padding: EdgeInsets.all(32.w),
                children: [
                  model!.title!.text.size(32.sp).bold.make(),
                  50.hb,
                  ...model!.imgUrls!
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            BeeImagePreview.toPath(
                              path: e.url,
                              tag: '${e.url!}${e.hashCode}',
                            );
                          },
                          child: Hero(
                            tag: '${e.url!}${e.hashCode}',
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.w),
                                color: Colors.black12,
                              ),
                              child: FadeInImage.assetNetwork(
                                placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                                image: API.image(e.url),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  44.hb,
                  model!.content!.text.size(28.sp).make(),
                  43.hb,
                  docView(model!.fileDocName, model!.fileDocUrl),
                ],
              ),
      ).material(color: Colors.white),
    );
  }
}
