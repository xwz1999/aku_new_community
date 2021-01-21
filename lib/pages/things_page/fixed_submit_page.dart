import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/user/fixed_submit_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/pages/things_page/widget/image_grid.dart';
import 'package:akuCommunity/utils/bee_map.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/horizontal_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:akuCommunity/extensions/num_ext.dart';

class FixedSubmitPage extends StatefulWidget {
  FixedSubmitPage({Key key}) : super(key: key);

  @override
  _FixedSubmitPageState createState() => _FixedSubmitPageState();
}

class _FixedSubmitPageState extends State<FixedSubmitPage> {
  EasyRefreshController _easyRefreshController;
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

  Color _getColor(int state) {
    switch (state) {
      case 1:
      case 2:
      case 3:
        return kDarkPrimaryColor;
      case 4:
      case 5:
      case 6:
      case 7:
        return ktextSubColor;
      default:
        return kDangerColor;
    }
  }

  Widget _buildCard(FixedSubmitModel model) {
    return Container(
      decoration: BoxDecoration(
          color: kForeGroundColor, borderRadius: BorderRadius.circular(8.w)),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BeeMap()
                  .fixTag[model.type]
                  .text
                  .color(ktextPrimary)
                  .bold
                  .size(32.sp)
                  .make(),
              Spacer(),
              BeeMap()
                  .fixState[model.status]
                  .text
                  .color(_getColor(model.status))
                  .size(24.sp)
                  .make(),
            ],
          ),
          24.hb,
          Divider(
            thickness: 1.w,
            height: 0,
          ),
          24.hb,
          model.reportDetail.text
              .color(ktextSubColor)
              .size(28.sp)
              .ellipsis
              .make(),
          16.hb,
          model.imgUrls.length != 0
              ? HorizontalImageView(List.generate(
                  model.imgUrls.length, (index) => model.imgUrls[index].url))
              : SizedBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '报事报修',
      body: Column(
        children: [
          BeeListView(
            controller: _easyRefreshController,
            path: API.manager.fixedSubmit,
            convert: (model) {
              return model.tableList
                  .map((e) => FixedSubmitModel.fromJson(e))
                  .toList();
            },
            builder: (items) {
              return ListView.separated(
                  padding: EdgeInsets.all(32.w),
                  itemBuilder: (context, index) {
                    return _buildCard(items[index]);
                  },
                  separatorBuilder: (context, index) {
                    return 24.heightBox;
                  },
                  itemCount: items.length);
            },
          ).expand(),
          MaterialButton(
            onPressed: () {},
            child: '新增'.text.bold.color(ktextPrimary).size(32.sp).make(),
            minWidth: double.infinity,
            height: 98.w,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.zero,
          )
              .box
              .padding(EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom))
              .color(kPrimaryColor)
              .make(),
        ],
      ),
    );
  }
}
