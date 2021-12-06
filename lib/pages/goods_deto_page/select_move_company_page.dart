import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/model/manager/moving_company_model.dart';
import 'package:aku_new_community/pages/goods_deto_page/deto_create_page/widget/common_radio.dart';
import 'package:aku_new_community/pages/manager_func.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class SelectMoveCompanyPage extends StatefulWidget {
  SelectMoveCompanyPage({Key? key}) : super(key: key);

  @override
  _SelectMoveCompanyPageState createState() => _SelectMoveCompanyPageState();
}

class _SelectMoveCompanyPageState extends State<SelectMoveCompanyPage> {
  int? _selected;
  late MovingCompanyModel _companyModel;
  EasyRefreshController? _controller;
  bool _onloading = true;

  String? get result {
    if (_selected == _companyModel.appMovingCompanyVoList!.length) {
      return '已选择自己联系';
    } else {
      return _companyModel.appMovingCompanyVoList![_selected!].tel;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    _controller = EasyRefreshController();
    super.dispose();
  }

  Widget _buildCard(int index, String name, String? tel) {
    return GestureDetector(
      onTap: () {
        _selected = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 28.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
              child: CommonRadio(
                size: 32.w,
                value: index,
                groupValue: _selected,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                name.text.color(ktextPrimary).size(28.sp).bold.make(),
                20.w.heightBox,
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.phone_arrow_up_right,
                      size: 40.w,
                      color: kDarkSubColor,
                    ),
                    8.w.widthBox,
                    '电话：$tel'
                        .text
                        .color(Color(0xFF999999))
                        .size(24.sp)
                        .bold
                        .make(),
                  ],
                ),
              ],
            ).expand(),
          ],
        ).material(color: Colors.transparent),
      ),
    );
  }

  Widget _buildForself(int index) {
    return GestureDetector(
      onTap: () {
        _selected = index;
        setState(() {});
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 28.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
              child: CommonRadio(
                size: 32.w,
                value: index,
                groupValue: _selected,
              ),
            ),
            '自己联系'.text.color(ktextPrimary).size(28.sp).bold.make()
          ],
        ),
      ).material(color: Colors.transparent),
    );
  }

  Widget _emptyWidget() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '搬家公司',
      body: EasyRefresh(
        firstRefresh: true,
        controller: _controller,
        onRefresh: () async {
          _companyModel = await ManagerFunc.getMovingCompanyTel();
          _onloading = false;
          setState(() {});
        },
        header: MaterialHeader(),
        child: _onloading
            ? _emptyWidget()
            : ListView(
                padding: EdgeInsets.all(32.w),
                children: [
                  ..._companyModel.appMovingCompanyVoList!
                      .map((e) => _buildCard(
                          _companyModel.appMovingCompanyVoList!.indexOf(e),
                          e.name!,
                          e.tel))
                      .toList(),
                  _buildForself(_companyModel.appMovingCompanyVoList!.length)
                ].sepWidget(separate: BeeDivider.horizontal()),
              ),
      ),
      bottomNavi: BottomButton(
        child: '确定'.text.color(ktextPrimary).size(32.sp).bold.make(),
        onPressed: () {
          if (_selected == null) {
            BotToast.showText(text: '请选择搬家公司！');
          } else {
            Get.back(result: result);
          }
        },
      ),
    );
  }
}
