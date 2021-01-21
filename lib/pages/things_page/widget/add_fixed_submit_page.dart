import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/manager_func.dart';
import 'package:akuCommunity/pages/things_page/widget/finish_fixed_submit_page.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/widget/bee_divider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/extensions/widget_list_ext.dart';
import 'package:akuCommunity/extensions/page_router.dart';

class AddFixedSubmitPage extends StatefulWidget {
  AddFixedSubmitPage({Key key}) : super(key: key);

  @override
  _AddFixedSubmitPageState createState() => _AddFixedSubmitPageState();
}

class _AddFixedSubmitPageState extends State<AddFixedSubmitPage> {
  TextEditingController _textEditingController;
  String reportText;
  List<String> _buttons = ['公区保修', '家庭维修'];
  int _selectType;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  Widget _buildHouseCard(
    String title,
    String detail,
  ) {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '报修房屋'.text.black.size(28.sp).make(),
          32.w.heightBox,
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Image.asset(
                  R.ASSETS_ICONS_HOUSE_PNG,
                  width: 60.w,
                  height: 60.w,
                ),
                40.w.widthBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title.text.black.size(32.sp).bold.make(),
                      10.w.heightBox,
                      detail.text.black.size(32.sp).bold.make()
                    ],
                  ),
                ),
                // Icon(
                //   CupertinoIcons.chevron_forward,
                //   size: 40.w,
                // ),
              ],
            ),
          ),
          24.w.heightBox,
          BeeDivider.horizontal(),
        ],
      ),
    );
  }

  Widget _selectButton(
    String title,
    int value,
  ) {
    return FlatButton(
      minWidth: 200.w,
      height: 72.w,
      onPressed: () {
        setState(() {
          _selectType = value;
        });
      },
      child: title.text
          .color(_selectType == value ? ktextPrimary : Color(0xFF979797))
          .size(32.sp)
          .make(),
      padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 14.w),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: _selectType == value ? kPrimaryColor : ktextSubColor,
              width: 3.w),
          borderRadius: BorderRadius.circular(36.w)),
    );
  }

  Widget _getType() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '请选择服务类型'.text.black.size(28.sp).make(),
          24.w.heightBox,
          Row(
            children: <Widget>[
              ...List.generate(_buttons.length,
                  (index) => _selectButton(_buttons[index], index)),
            ].sepWidget(separate: 20.w.widthBox),
          ),
          16.w.heightBox,
        ],
      ),
    );
  }

  Widget _buildReportCard() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '请输入报修内容'.text.black.size(28.sp).make(),
          24.w.heightBox,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                border: Border.all(color: Color(0xFFD4CFBE), width: 1.w)),
            constraints: BoxConstraints(
              minHeight: 304.w,
            ),
            width: 686.w,
            child: TextField(
              controller: _textEditingController,
              onEditingComplete: () {},
              maxLines: 10,
              minLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '请简要描述一下你要告知我的事情，以便于我们更好的处理……',
                hintStyle: TextStyle(color: ktextSubColor, fontSize: 28.sp),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addImages() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '添加图片信息(${0}/9)'.text.black.size(28.sp).make(),
          24.w.heightBox,
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                    alignment: Alignment.center,
                    width: 218.w,
                    height: 218.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                      border: Border.all(color: Color(0xFF979797), width: 1.w),
                    ),
                    child: Icon(
                      CupertinoIcons.plus,
                      size: 80.w,
                      color:Color(0xFFD8D8D8) ,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return BeeScaffold(
      title: '报事报修',
      body: Column(
        children: [
          ListView(
            children: [
              _buildHouseCard(
                  kEstateName,
                  userProvider.userDetailModel.estateNames.isEmpty
                      ? ''
                      : userProvider.userDetailModel.estateNames[0]),
              _getType(),
              _buildReportCard(),
              _addImages(),
            ],
          ).expand(),
          MaterialButton(
            minWidth: double.infinity,
            height: 98.w,
            onPressed: () {
              ManagerFunc.reportRepairInsert(
                  _selectType + 1, _textEditingController.text, []);
              FinishFixedSubmitPage().to();
            },
            child: '确认提交'.text.black.bold.size(32.sp).make(),
            color: kPrimaryColor,
            elevation: 0,
          )
              .box
              .padding(EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom))
              .make()
        ],
      ),
    );
  }
}
