import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/card_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class TenantHouseListPage extends StatefulWidget {
  TenantHouseListPage({Key? key}) : super(key: key);

  @override
  _TenantHouseListPageState createState() => _TenantHouseListPageState();
}

class _TenantHouseListPageState extends State<TenantHouseListPage> {
  bool _onload = true;
  late EasyRefreshController _refreshController;
  @override
  void initState() {
    _refreshController = EasyRefreshController();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '可选房屋',
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        controller: _refreshController,
        onRefresh: () async {
          _onload = false;
          setState(() {});
        },
        child: _onload
            ? Container()
            : ListView(
                padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
                children: [houseCard()],
              ),
      ),
    );
  }

  List<Color> _getColors(int type) {
    switch (type) {
      case 1:
        return [
          Color(0xFFFFE5D2),
          Color(0xFFFFFFFF),
        ];
      case 2:
        return [
          Color(0xFFFFEEBB),
          Color(0xFFFFF4D2),
        ];
      default:
        return [Colors.white, Colors.white];
    }
  }

  Widget houseCard() {
    var buttons = Row(
      children: [CardBottomButton.yellow(text: '填写信息', onPressed: () {})],
    );
    var bottom = Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            '二类人才'.text.size(28.sp).color(ktextSubColor).make(),
            8.w.heightBox,
            'B座C1户型'.text.size(28.sp).color(ktextSubColor).make(),
          ],
        ).expand(),
        buttons
      ],
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        gradient: LinearGradient(
            colors: _getColors(1),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                width: 40.w,
                height: 40.w,
              ),
              16.w.widthBox,
              '南宁金融人才公寓'.text.size(32.sp).color(ktextPrimary).make().expand(),
              '待签署'.text.size(32.sp).color(ktextPrimary).bold.make(),
            ],
          ),
          12.w.heightBox,
          Row(
            children: [
              '1幢-1单元-702室'
                  .text
                  .size(40.sp)
                  .color(ktextPrimary)
                  .bold
                  .make()
                  .expand(),
            ],
          ),
          56.w.heightBox,
          bottom,
        ],
      ),
    );
  }
}
