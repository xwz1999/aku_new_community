import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/user/fixed_submit_model.dart';
import 'package:akuCommunity/pages/manager_func.dart';
import 'package:akuCommunity/pages/things_page/widget/add_fixed_submit_page.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/pages/things_page/widget/fixed_check_box.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/bee_map.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/horizontal_image_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:akuCommunity/extensions/num_ext.dart';
import 'package:akuCommunity/extensions/page_router.dart';

class FixedSubmitPage extends StatefulWidget {
  FixedSubmitPage({Key key}) : super(key: key);

  @override
  _FixedSubmitPageState createState() => _FixedSubmitPageState();
}

class _FixedSubmitPageState extends State<FixedSubmitPage> {
  EasyRefreshController _easyRefreshController;
  bool _isEdit = false;
  List<int> _selected = [];
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

  bool _canSkew(int state) {
    switch (state) {
      case 1:
      case 2:
      case 3:
        return false;
      case 4:
      case 5:
      case 6:
      case 7:
        return true;
      default:
        return true;
    }
  }

  Widget _buildCard(FixedSubmitModel model) {
    return AnimatedPositioned(
      top: 0,
      left: (_canSkew(4) && _isEdit) ? 55.w : 0,
      bottom: 0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: Container(
        width: 686.w,
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
      ),
    );
  }

  Widget _buildCheckBox(FixedSubmitModel model) {
    return Container(
        alignment: Alignment.centerLeft,
        constraints: BoxConstraints(minHeight: 384.w, minWidth: 686.w),
        child: FixedCheckBox(
          onChanged: (isSelect) {
            if (isSelect) {
              _selected.add(model.id);
            } else {
              _selected.remove(model.id);
            }
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return BeeScaffold(
      title: '报事报修',
      actions: [
        IconButton(
            icon: _isEdit
                ? '完成'.text.black.size(28.sp).make()
                : '编辑'.text.black.size(28.sp).make(),
            onPressed: () {
              _isEdit = !_isEdit;
              setState(() {});
            })
      ],
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
                    return Stack(
                      children: [
                        _buildCheckBox(items[index]),
                        _buildCard(items[index])
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 24.w.heightBox;
                  },
                  itemCount: items.length);
            },
          ).expand(),
          MaterialButton(
            onPressed: _isEdit
                ? () {
                    ManagerFunc.reportRepairDelete(_selected);
                    _easyRefreshController.callRefresh();
                  }
                : () {
                    userProvider.isLogin
                        ? AddFixedSubmitPage().to()
                        : BotToast.showText(text: '请先登录！');
                  },
            child: _isEdit
                ? '删除订单'.text.bold.color(ktextPrimary).size(32.sp).make()
                : '新增'.text.bold.color(ktextPrimary).size(32.sp).make(),
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
