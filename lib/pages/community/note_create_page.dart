import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class NoteCreatePage extends StatefulWidget {
  NoteCreatePage({Key key}) : super(key: key);

  @override
  _NoteCreatePageState createState() => _NoteCreatePageState();
}

class _NoteCreatePageState extends State<NoteCreatePage> {
  TextEditingController _noteContent = new TextEditingController();

  String hintText = '这一刻的想法...';

  bool _isSelect = false;

  List<Map<String, dynamic>> _themeList = [
    {'title': '选择话题:', 'isSelect': false},
    {'title': "#教师节", 'isSelect': false},
    {'title': "#快乐植树节", 'isSelect': false},
    {'title': "#关爱老人", 'isSelect': false},
    {'title': "#运动会", 'isSelect': false},
  ];

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      centerTitle: true,
      title: Text(
        '社区',
        style: TextStyle(
          fontSize: 36.sp,
          color: Color(0xff333333),
        ),
      ),
      leading: InkWell(
        onTap: () => Get.back(),
        child: Container(
          padding: EdgeInsets.only(left: 32.w),
          alignment: Alignment.center,
          child: Text(
            '取消',
            style: TextStyle(
              fontSize: 34.sp,
              color: Color(0xff030303),
            ),
          ),
        ),
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 32.w),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 64.w,
              width: 116.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffffd000),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Text(
                '发表',
                style: TextStyle(
                  fontSize: 34.sp,
                  color: Color(0xff030303),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _containerTextField() {
    return Container(
      child: TextFormField(
        cursorColor: Color(0xffffc40c),
        style: TextStyle(
          fontSize: 34.sp,
        ),
        controller: _noteContent,
        onChanged: (String value) {},
        maxLines: 6,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: 0.w,
            bottom: 0.w,
          ),
          hintText: hintText,
          border: InputBorder.none, //去掉输入框的下滑线
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: 34.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  InkWell _containerAddImage() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 196.w,
        height: 196.w,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(AssetsImage.IMAGEADD), fit: BoxFit.fill),
        ),
        // child: ,
      ),
    );
  }

  InkWell _inkWellSelect() {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelect = !_isSelect;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xffd8d8d8), width: 1),
            bottom: BorderSide(color: Color(0xffd8d8d8), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  AntDesign.message1,
                  color: Color(0xff333333),
                  size: 28.sp,
                ),
                SizedBox(width: 10.w),
                Text(
                  '不可评论',
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: Color(0xff333333),
                  ),
                ),
              ],
            ),
            _isSelect
                ? Icon(
                    AntDesign.check,
                    color: Color(0xffffd003),
                    size: 40.sp,
                  )
                : SizedBox(height: 40.sp),
          ],
        ),
      ),
    );
  }

  Wrap _wrapThemeList() {
    return Wrap(
        spacing: 15.w,
        runSpacing: 20.w,
        children: _themeList
            .asMap()
            .keys
            .map((index) => index == 0
                ? Container(
                  padding: EdgeInsets.only(top: 10.w),
                  width: 156.w,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _themeList[index]['title'],
                    style: TextStyle(
                      fontSize: 34.sp,
                      color: Color(0xff333333),
                    ),
                  ),
                )
                : InkWell(
                    onTap: () {
                      _themeList.forEach((item) {
                        item['isSelect'] = false;
                      });
                      setState(() {
                        _themeList[index]['isSelect'] = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: _themeList[index]['isSelect']
                              ? Color(0xfffff8e4)
                              : Color(0xffffffff),
                          border: Border.all(
                              color: _themeList[index]['isSelect']
                                  ? Color(0xffffc40c)
                                  : Color(0xff979797),
                              width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(36))),
                      padding: EdgeInsets.symmetric(
                        horizontal: 29.w,
                        vertical: 13.w,
                      ),
                      child: Text(
                        _themeList[index]['title'],
                        style: TextStyle(
                          fontSize: 34.sp,
                          color: _themeList[index]['isSelect']
                              ? Color(0xff333333)
                              : Color(0xff999999),
                        ),
                      ),
                    ),
                  ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    double _statusHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              _statusHeight,
          color: Colors.white,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              padding: EdgeInsets.only(
                top: 49.w,
                left: 62.w,
                right: 62.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _containerTextField(),
                  _containerAddImage(),
                  SizedBox(height: 202.w),
                  _inkWellSelect(),
                  SizedBox(height: 28.w),
                  _wrapThemeList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
