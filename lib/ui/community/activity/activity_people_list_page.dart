import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/model/community/activity_people_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class ActivityPeopleListPage extends StatefulWidget {
  final int? id;
  ActivityPeopleListPage({Key? key, required this.id}) : super(key: key);

  @override
  _ActivityPeopleListPageState createState() => _ActivityPeopleListPageState();
}

class _ActivityPeopleListPageState extends State<ActivityPeopleListPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '参与人员',
      body: BeeListView<ActivityPeopleModel>(
        controller: _refreshController,
        path: API.community.activityPeopleList,
        extraParams: {'activityId': widget.id},
        convert: (model) => model.tableList!
            .map((e) => ActivityPeopleModel.fromJson(e))
            .toList(),
        builder: (items) {
          return ListView.separated(
            padding: EdgeInsets.all(32.w),
            itemBuilder: (context, index) {
              final ActivityPeopleModel model = items[index];
              return Row(
                children: [
                  96.hb,
                  20.wb,
                  FadeInImage.assetNetwork(
                    placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                    image: API.image(ImgModel.first(model.imgUrl)),
                    height: 60.w,
                    width: 60.w,
                  ),
                  18.wb,
                  model.name!.text.size(28.sp).make(),
                  Spacer(),
                  model.tel!.text.size(28.sp).make(),
                ],
              );
            },
            separatorBuilder: (_, __) => Divider(height: 1.w),
            itemCount: items.length,
          );
        },
      ).material(color: Colors.white),
    );
  }
}
