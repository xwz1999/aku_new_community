// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/common_input.dart';
import 'package:akuCommunity/widget/single_image_up.dart';

class CertificationPage extends StatefulWidget {
  CertificationPage({Key key}) : super(key: key);

  @override
  _CertificationPageState createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> {
  TextEditingController _userName = new TextEditingController();
  TextEditingController _userIDCard = new TextEditingController();

  List<Map<String, dynamic>> _uploadImageList = [
    {
      'imagePath': AssetsImage.LICENSE,
      'title': '上传身份证正面照',
    },
    {
      'imagePath': AssetsImage.LICENSEBACK,
      'title': '上传身份证背面照',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget _idCardType() {
    return Container(
      padding: EdgeInsets.only(
        top: 23.w,
        bottom: 24.w,
      ),
      margin: EdgeInsets.only(bottom: 60.w),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '证件类型',
            style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
          ),
          SizedBox(height: 25.w),
          Container(
            width: 686.w,
            child: Text(
              '身份证',
              style: TextStyle(
                fontSize: 36.sp,
                color: Color(0xff333333),
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _upLoadImage() {
    return Container(
      padding: EdgeInsets.only(
        top: 23.w,
        bottom: 24.w,
      ),
      margin: EdgeInsets.only(bottom: 60.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '上传证件照片',
            style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
          ),
          SizedBox(height: 25.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              _uploadImageList.length,
              (index) => SingleImageUp(
                title: _uploadImageList[index]['title'],
                imagePath: _uploadImageList[index]['imagePath'],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(String title, hintText, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(
        top: 23.w,
        bottom: 24.w,
      ),
      margin: EdgeInsets.only(bottom: 60.w),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
          ),
          SizedBox(height: 25.w),
          CommonInput(inputController: controller, hintText: hintText)
        ],
      ),
    );
  }

  InkWell _submit() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 96.w,
        width: 686.w,
        padding: EdgeInsets.symmetric(
          vertical: 26.w,
        ),
        decoration: BoxDecoration(
            color: Color(0xffffc40c),
            borderRadius: BorderRadius.all(Radius.circular(48))),
        child: Text(
          '确认提交',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.sp,
              color: Color(0xff333333)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '实名认证',
      body: Container(
        padding: EdgeInsets.only(
          top: 32.w,
          left: 32.w,
          right: 32.w,
        ),
        color: Colors.white,
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Container(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            _idCardType(),
                            _upLoadImage(),
                            _input('证件号', '请输入证件号', _userName),
                            _input('姓名', '姓名需与证件上相同', _userIDCard),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _submit(),
          ],
        ),
      ),
    );
  }
}
