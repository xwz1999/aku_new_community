import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/app_theme.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/model/user/fixed_submit_model.dart';
import 'package:aku_new_community/pages/manager_func.dart';
import 'package:aku_new_community/pages/things_page/widget/add_fixed_submit_page.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/pages/things_page/widget/fixed_check_box.dart';
import 'package:aku_new_community/pages/things_page/widget/fixed_detail_page.dart';
import 'package:aku_new_community/utils/bee_map.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/views/horizontal_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class FixedSubmitPage extends StatefulWidget {
  FixedSubmitPage({Key? key}) : super(key: key);

  @override
  _FixedSubmitPageState createState() => _FixedSubmitPageState();
}

class _FixedSubmitPageState extends State<FixedSubmitPage> {
  EasyRefreshController? _easyRefreshController;
  bool _isEdit = false;
  List<int?> _selected = [];

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

  Color _getColor(int? state) {
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

  bool _canSkew(int? state) {
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
      left: (_canSkew(model.status) && _isEdit) ? 55.w : 0,
      bottom: 0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: GestureDetector(
        onTap: () {
          Get.to(() => FixedDetailPage(model.id ?? 0));
        },
        child: Container(
          width: 686.w,
          decoration: BoxDecoration(
              color: kForeGroundColor,
              borderRadius: BorderRadius.circular(8.w)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 24.w, 24.w, 0),
                child: Row(
                  children: [
                    BeeMap.fixTag[model.type!]!.text
                        .color(ktextPrimary)
                        .bold
                        .size(32.sp)
                        .make(),
                    Spacer(),
                    BeeMap.fixState[model.status!]!.text
                        .color(_getColor(model.status))
                        .size(24.sp)
                        .make(),
                  ],
                ),
              ),
              24.hb,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Divider(
                  thickness: 1.w,
                  height: 0,
                ),
              ),
              24.hb,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: model.reportDetail!.text
                    .color(ktextSubColor)
                    .size(28.sp)
                    .ellipsis
                    .make(),
              ),
              // 16.hb,
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: model.imgUrls!.length != 0
                    ? HorizontalImageView(List.generate(model.imgUrls!.length,
                        (index) => model.imgUrls![index].url))
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckBox(FixedSubmitModel model) {
    return
        // GestureDetector(
        //   onTap: () {
        //     if (_selected.contains(model.id)) {
        //       _selected.remove(model.id);
        //     } else {
        //       _selected.add(model.id);
        //     }
        //     setState(() {});
        //   },
        // child:
        Container(
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(minHeight: 384.w, minWidth: 686.w),
      child: FixedCheckBox(
        key: ValueKey(model.id),
        onChanged: (isSelect) {
          if (isSelect) {
            _selected.add(model.id);
          } else {
            _selected.remove(model.id);
          }
          setState(() {});
        },
      ),
      // child: BeeRadio(value: model.id, groupValues: _selected),
      // ),
    );
  }

  Widget _showDeletDialog() {
    return CupertinoAlertDialog(
      title: '删除订单'.text.black.size(34.sp).isIntrinsic.make(),
      content: '您确定要删除订单吗?'.text.black.size(28.sp).isIntrinsic.make(),
      actions: [
        CupertinoDialogAction(
          child: '先等等'.text.black.size(34.sp).isIntrinsic.make(),
          onPressed: () {
            Get.back();
          },
        ),
        CupertinoDialogAction(
          child: '删除订单'
              .text
              .color(Color(0xFFFF8200))
              .size(34.sp)
              .bold
              .isIntrinsic
              .make(),
          onPressed: () async {
            await ManagerFunc.reportRepairDelete(_selected);
            Get.back();
            _selected.clear();
            _easyRefreshController!.callRefresh();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      systemStyle: SystemStyle.yellowBottomBar,
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
      body: BeeListView<FixedSubmitModel>(
        controller: _easyRefreshController,
        path: API.manager.fixedSubmit,
        convert: (model) {
          return model.tableList!
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
      ),
      bottomNavi: BottomButton(
        onPressed: _isEdit
            ? _selected.isEmpty
                ? null
                : () {
                    Get.dialog(_showDeletDialog());
                  }
            : () async {
                bool? needRefresh = await Get.to(() => AddFixedSubmitPage());
                if (needRefresh == null) _easyRefreshController!.callRefresh();
              },
        child: _isEdit
            ? '删除订单'.text.bold.size(32.sp).make()
            : '新增'.text.bold.size(32.sp).make(),
      ),
    );
  }
}
