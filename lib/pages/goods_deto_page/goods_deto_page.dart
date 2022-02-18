import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/app_theme.dart';
import 'package:aku_new_community/model/manager/goods_out_model.dart';
import 'package:aku_new_community/pages/goods_deto_page/deto_create_page/deto_create_page.dart';
import 'package:aku_new_community/pages/manager_func.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/buttons/radio_button.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'widget/goods_info_card.dart';

class GoodsDetoPage extends StatefulWidget {
  GoodsDetoPage({Key? key}) : super(key: key);

  @override
  _GoodsDetoPageState createState() => _GoodsDetoPageState();
}

class _GoodsDetoPageState extends State<GoodsDetoPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  List<int?> _select = [];
  bool _isEdit = false;

  bool _canSkew(int? state) {
    switch (state) {
      case 1:
        return false;
      case 2:
      case 3:
        return true;
      default:
        return true;
    }
  }

  Widget _buildPositioned(GoodsOutModel model) {
    return AnimatedPositioned(
      bottom: 0,
      top: 0,
      left: (_canSkew(model.status) && _isEdit) ? 80.w : 0.w,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      width: 750.w,
      child: GoodsInfoCard(
        model: model,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return BeeScaffold(
      systemStyle: SystemStyle.yellowBottomBar,
      title: '物品出户',
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
      body: Padding(
        padding: EdgeInsets.only(bottom: 98.w),
        child: BeeListView<GoodsOutModel>(
          controller: _refreshController,
          path: API.manager.articleOut,
          convert: (model) {
            return model.rows.map((e) => GoodsOutModel.fromJson(e)).toList();
          },
          builder: (items) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Stack(children: [
                  GestureDetector(
                    onTap: () {
                      if (_select.contains(items[index].id)) {
                        _select.remove(items[index].id);
                      } else
                        _select.add(items[index].id);
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 50.w, horizontal: 32.w),
                      alignment: Alignment.topLeft,
                      constraints: BoxConstraints(
                          minHeight: 652.w + 96.w, minWidth: 686.w),
                      child: BeeRadio(
                          value: items[index].id, groupValues: _select),
                    ),
                  ),
                  _buildPositioned(items[index]),
                ]);
              },
              itemCount: items.length,
            );
          },
        ),
      ),
      bottomNavi: BottomButton(
        onPressed: _isEdit
            ? _select.isEmpty
                ? null
                : () async {
                    await ManagerFunc.articleOutDelete(_select);
                    _select.clear();
                    _refreshController.callRefresh();
                  }
            : userProvider.isLogin
                ? () async {
                    await Get.to(() => DetoCreatePage());
                    _refreshController.callRefresh();
                  }
                : () {
                    BotToast.showText(text: '请先登录！');
                  },
        child: _isEdit
            ? '删除'.text.size(32.sp).bold.make()
            : '新增'.text.size(32.sp).bold.make(),
      ),
    );
  }
}
