import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/widget/common_image_picker.dart';

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController _ideaContent = new TextEditingController();

  Widget _containerTextField() {
    return Container(
      padding: EdgeInsets.only(
          top: Screenutil.length(24),
          left: Screenutil.length(24),
          right: Screenutil.length(32)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: Color(0xffd4cfbe), width: 1.0),
      ),
      child: TextFormField(
        cursorColor: Color(0xffffc40c),
        style: TextStyle(
          fontSize: Screenutil.size(28),
          fontWeight: FontWeight.w600,
        ),
        controller: _ideaContent,
        onChanged: (String value) {},
        maxLines: 10,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: Screenutil.length(0),
            bottom: Screenutil.length(0),
          ),
          hintText: '请输入',
          border: InputBorder.none, //去掉输入框的下滑线
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: Screenutil.size(28),
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _containerAddImage() {
    return Container(
      width: Screenutil.length(218),
      height: Screenutil.length(218),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Color(0xffd4cfbe), width: 1.0),
        image: DecorationImage(
            image: AssetImage(AssetsImage.IMAGEADD), fit: BoxFit.fill),
      ),
      // child: ,
    );
  }

  Widget _inkWellSubmit() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: Screenutil.length(85),
        width: Screenutil.length(686),
        padding: EdgeInsets.symmetric(vertical: Screenutil.length(20)),
        decoration: BoxDecoration(
          color: Color(0xffffc40c),
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        child: Text(
          '确认提交',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Screenutil.size(32),
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '意见反馈',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Screenutil.length(32),
              vertical: Screenutil.length(36),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Screenutil.length(76)),
                Text(
                  '意见反馈',
                  style: TextStyle(
                      fontSize: Screenutil.size(28),
                      color: Color(0xff333333)),
                ),
                SizedBox(height: Screenutil.length(24)),
                _containerTextField(),
                SizedBox(height: Screenutil.length(24)),
                Text(
                  '添加图片信息(0/9)',
                  style: TextStyle(
                      fontSize: Screenutil.size(28),
                      color: Color(0xff333333)),
                ),
                SizedBox(height: Screenutil.length(24)),
                CommonImagePicker(),
                SizedBox(height: Screenutil.length(76)),
                _inkWellSubmit(),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
