import 'package:akuCommunity/ui/profile/house/house_item.dart';
import 'package:akuCommunity/ui/profile/house/pick_building_page.dart';
import 'package:akuCommunity/ui/profile/house/pick_plot_page.dart';
import 'package:akuCommunity/ui/profile/house/pick_role_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddHousePage extends StatefulWidget {
  AddHousePage({Key key}) : super(key: key);

  @override
  _AddHousePageState createState() => _AddHousePageState();
}

class _AddHousePageState extends State<AddHousePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  HouseItem _item;
  int _roleType;
  TextStyle get _hintStyle => TextStyle(
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
        color: Color(0xFF999999),
      );

  TextStyle get _textStyle => _hintStyle.copyWith(color: Color(0xFF333333));

  bool get _buttonCanTap =>
      _nameController.text.isNotEmpty && _idController.text.isNotEmpty;
  _renderTile({
    String title,
    Widget item,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
          child: Text(title, style: Theme.of(context).textTheme.subtitle1),
        ),
        item ?? SizedBox(),
      ],
    );
  }

  _renderTextField({
    String hintText,
    TextEditingController controller,
    FormFieldValidator validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: _textStyle,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: _hintStyle,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 32.w,
          vertical: 30.w,
        ),
      ),
    );
  }

  _renderPicker({
    @required String text,
    @required String hintText,
    VoidCallback onTap,
  }) {
    bool showText = text?.isNotEmpty ?? false;
    return MaterialButton(
      onPressed: onTap,
      minWidth: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 30.w),
      child: Row(
        children: [
          Text(
            showText ? text : hintText,
            style: showText ? _textStyle : _hintStyle,
          ),
          Spacer(),
          if (onTap != null)
            Icon(
              CupertinoIcons.chevron_forward,
              size: 38.w,
              color: Color(0xFFE8E8E8),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _idController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '添加房屋',
      body: Material(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _renderTile(
                title: '小区名称',
                item: _renderPicker(
                  text: '人才公寓智慧小区',
                  hintText: '请选择小区',
                  // 跳转到选择小区页面
                  // TODO 小区页面
                  // onTap: () {
                  //   Get.to(() => PickPlotPage());
                  // },
                ),
              ),
              _renderTile(
                title: '楼栋、单元、室',
                item: _renderPicker(
                  text: _item?.houseName,
                  hintText: '请选择楼栋、单元、室',
                  onTap: () async {
                    HouseItem tempItem = await Get.to(() => PickBuildingPage());
                    if (tempItem != null) _item = tempItem;
                    setState(() {});
                  },
                ),
              ),
              _renderTile(
                title: '身份',
                item: _renderPicker(
                  text: PickRolePage.getType(_roleType),
                  hintText: '请选择身份',
                  onTap: () async {
                    int role = await Get.to(() => PickRolePage());
                    if (role != null) {
                      _roleType = role;
                      setState(() {});
                    }
                  },
                ),
              ),
              _renderTile(
                title: '姓名',
                item: _renderTextField(
                    hintText: '请输入姓名',
                    controller: _nameController,
                    validator: (text) {
                      if (!RegexUtil.isZh(text)) return '请输入正确的姓名';
                      return null;
                    }),
              ),
              _renderTile(
                title: '身份证号',
                item: _renderTextField(
                  hintText: '请输入身份证号',
                  controller: _idController,
                  validator: (text) {
                    if (!RegexUtil.isIDCard(text)) return '请输入正确的身份证号码';
                    return null;
                  },
                ),
              ),
            ].sepWidget(
                separate: Divider(
              indent: 32.w,
              endIndent: 32.w,
              height: 1.w,
              thickness: 1.w,
            )),
          ),
        ),
      ),
      bottomNavi: ElevatedButton(
        child: Text('提交审核'),
        onPressed: _buttonCanTap
            ? () {
                if (_formKey.currentState.validate()) {}
              }
            : null,
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 26.w)),
        ),
      ),
    );
  }
}
