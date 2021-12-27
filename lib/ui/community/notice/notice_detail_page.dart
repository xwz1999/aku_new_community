import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/community/board_detail_model.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/picker/bee_image_preview.dart';
import 'package:aku_new_community/widget/views/bee_download_view.dart';
import 'package:aku_new_community/widget/views/doc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

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
                  DocViw(
                    title: model?.fileDocName ?? '',
                    onPressed: () async {
                      String? result = await Get.dialog(BeeDownloadView(
                        file: model!.fileDocUrl,
                      ));
                      if (result != null) OpenFile.open(result);
                    },
                  ),
                ],
              ),
      ).material(color: Colors.white),
    );
  }
}
