import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/ui/profile/house/identify_selection_page.dart';
import 'package:aku_community/ui/profile/house/my_house_list.dart';
import 'package:aku_community/ui/profile/house/tenant_house_list_page.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/const/resource.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/ui/profile/house/add_house_page.dart';
import 'package:aku_community/ui/profile/house/house_card.dart';
import 'package:aku_community/ui/profile/house/house_func.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class HouseOwnersPage extends StatefulWidget {
  final int identify;
  HouseOwnersPage({Key? key, required this.identify}) : super(key: key);

  @override
  _HouseOwnersPageState createState() => _HouseOwnersPageState();
}

class _HouseOwnersPageState extends State<HouseOwnersPage> {
  EasyRefreshController _refreshController = EasyRefreshController();

  bool get _emptyHouse {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return appProvider.houses.isEmpty;
  }

  ///存在已认证的房屋
  bool get _haveAuthedHouse {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    // return (appProvider.selectedHouse?.status ?? 0) == 4;
    return appProvider.selectedHouse != null;
  }

  //没有已认证房屋显示的文字
  Widget get _houseTitle {
    // final appProvider = Provider.of<AppProvider>(context, listen: false);
    if (_emptyHouse) return Text('还没有绑定房屋');
    // if (appProvider.selectedHouse!.status == 1) return Text('您的身份正在审核中，请耐心等待');
    // if (appProvider.selectedHouse!.status == 3) return Text('审核未通过');
    return SizedBox();
  }

  bool get isOwner {
    switch (widget.identify) {
      case 1:
        return true;
      case 3:
        return false;

      default:
        return false;
    }
  }

  bool get isTourist {
    switch (widget.identify) {
      case 1:
        return false;
      case 2:
        return true;
      case 3:
        return false;
      case 4:
        return true;
      default:
        return true;
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return isTourist
        ? _touristBody()
        : BeeScaffold(
            title: '我的房屋',
            actions: [
              TextButton(
                onPressed: () {
                  isOwner
                      ? Get.to(() => MyHouseList())
                      : Get.to(TenantHouseListPage());
                },
                child: Text(isOwner ? '审核记录' : '我的选房'),
              ),
            ],
            body: EasyRefresh(
              header: MaterialHeader(),
              controller: _refreshController,
              firstRefresh: true,
              onRefresh: () async {
                appProvider.updateHouses(await HouseFunc.passedHouses);
              },
              child: ListView(
                children: [
                  _emptyHouse
                      ? 280.hb
                      : Padding(
                          padding: EdgeInsets.all(32.w),
                          child: HouseCard(
                            isOwner: isOwner,
                            type: appProvider.selectedHouse != null
                                ? CardAuthType.SUCCESS
                                : CardAuthType.FAIL,
                            model: appProvider.selectedHouse,
                          ),
                        ),
                  if (!_emptyHouse) 88.hb,
                  if (!_haveAuthedHouse)
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 75.w),
                          child: Image.asset(R.ASSETS_STATIC_REVIEWING_WEBP),
                        ),
                        Positioned(
                          bottom: 100.w,
                          left: 0,
                          right: 0,
                          child: _houseTitle.centered(),
                        ),
                      ],
                    ),
                  if (_emptyHouse)
                    Center(
                      child: ElevatedButton(
                        onPressed: _addHouse,
                        child: Text('添加房屋'),
                      ),
                    ),
                  if (!isOwner && !_emptyHouse) _contractRelevant(),
                ],
              ),
            ),
            bottomNavi: BottomButton(
                onPressed: _addHouse,
                child: '新增房屋'.text.size(32.sp).color(ktextPrimary).bold.make()),
          );
  }

  ///跳转到添加房屋
  _addHouse() async {
    bool? result = await Get.to(() => AddHousePage());
    if (result == true) _refreshController.callRefresh();
  }

  //租客身份才会显示合同相关入口
  Widget _contractRelevant() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 326 / 241,
      mainAxisSpacing: 32.w,
      crossAxisSpacing: 32.w,
      children: [
        _cardBuild(
            R.ASSETS_ICONS_PAY_PNG, '缴费查询', '查看租金及保证金情况', () {}),
        _cardBuild(
            R.ASSETS_ICONS_CHANGE_PNG, '合同变更', '变更合同信息、重新签约', () {}),
        _cardBuild(
            R.ASSETS_ICONS_CONTRACT_PNG, '合同续签', '到期前线上办理续签手续', () {}),
        _cardBuild(R.ASSETS_ICONS_FINISH_PNG, '合同终止', '线上申请终止合同', () {
          
        })
      ],
    );
  }

  Widget _cardBuild(
      String assetPath, String title, String subTitle, VoidCallback onPressed) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.w)),
      color: Colors.white,
      elevation: 0,
      minWidth: 326.w,
      height: 241.w,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            width: 88.w,
            height: 88.w,
          ),
          16.w.heightBox,
          title.text.size(28.sp).color(ktextPrimary).bold.make(),
          16.w.heightBox,
          subTitle.text
              .size(24.sp)
              .color(ktextSubColor)
              .maxLines(2)
              .ellipsis
              .make()
        ],
      ),
    );
  }

//游客身份页面显示
  Widget _touristBody() {
    var center = Center(
      child: Column(
        children: [
          280.w.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 75.w),
            child: Image.asset(R.ASSETS_STATIC_REVIEWING_WEBP),
          ),
          32.w.heightBox,
          MaterialButton(
              color: kPrimaryColor,
              minWidth: 280.w,
              elevation: 0,
              height: 88.w,
              child: '添加房屋'.text.size(32.sp).color(ktextPrimary).bold.make(),
              onPressed: () {
                Get.to(() => IdentifySelectionPage());
              })
        ],
      ),
    );
    return BeeScaffold(
      title: '我的房屋',
      body: center,
    );
  }
}
