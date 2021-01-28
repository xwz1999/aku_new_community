import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/model/manager/moving_company_model.dart';
import 'package:akuCommunity/pages/goods_deto_page/deto_create_page/widget/common_radio.dart';
import 'package:akuCommunity/pages/manager_func.dart';
import 'package:akuCommunity/widget/bee_divider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SelectMoveCompanyPage extends StatefulWidget {
  SelectMoveCompanyPage({Key key}) : super(key: key);

  @override
  _SelectMoveCompanyPageState createState() => _SelectMoveCompanyPageState();
}

class _SelectMoveCompanyPageState extends State<SelectMoveCompanyPage> {
  int _selected;
  MovingCompanyModel _companyModel;

  Widget _buildCard(int index, String name, String tel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 28.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _selected = index;
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
              child: CommonRadio(
                size: 32.w,
                value: index,
                groupValue: _selected,
              ),
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
      ),
    );
  }

  Widget _buildForself(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 28.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _selected = index;
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
              child: CommonRadio(
                size: 32.w,
                value: index,
                groupValue: _selected,
              ),
            ),
          ),
          '自己联系'.text.color(ktextPrimary).size(28.sp).bold.make()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '搬家公司',
      body: EasyRefresh(
        onRefresh: () async {
          _companyModel = await ManagerFunc.getMovingCompanyTel();
        },
        header: MaterialHeader(),
        child: ListView(
          padding: EdgeInsets.all(32.w),
          children: [
            ..._companyModel.appMovingCompanyVoList
                .map((e) => _buildCard(
                    _companyModel.appMovingCompanyVoList.indexOf(e),
                    e.name,
                    e.tel))
                .toList(),
            _buildForself(
              _companyModel.appMovingCompanyVoList.length
            )
          ].sepWidget(separate: BeeDivider.horizontal()),
        ),
      ),
    );
  }
}
