import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/widget/common_input.dart';
import 'package:akuCommunity/widget/single_image_up.dart';
import 'common_select.dart';

class DecoratorInfo extends StatefulWidget {
  DecoratorInfo({Key key}) : super(key: key);

  @override
  _DecoratorInfoState createState() => _DecoratorInfoState();
}

class _DecoratorInfoState extends State<DecoratorInfo> {
  TextEditingController _userName = new TextEditingController();
  TextEditingController _userIDCard = new TextEditingController();
  TextEditingController _userPhone = new TextEditingController();
  TextEditingController _userAddress = new TextEditingController();

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

  Widget _cardList(String title, Widget widget) {
    return Container(
      padding: EdgeInsets.only(
        top: 23.w,
        bottom: 24.w,
      ),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 28.sp, color: Color(0xff333333)),
          ),
          SizedBox(height: 25.w),
          widget
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
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '上传证件照片',
            style: TextStyle(
                fontSize: 28.sp, color: Color(0xff333333)),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardList(
              '姓名', CommonInput(inputController: _userName, hintText: '请输入姓名')),
          _cardList('证件类型', CommonSelect(title: '证件类型')),
          _cardList('证件号',
              CommonInput(inputController: _userIDCard, hintText: '请输入证件号')),
          _cardList('联系方式',
              CommonInput(inputController: _userPhone, hintText: '请输入电话号码')),
          _cardList('联系地址',
              CommonInput(inputController: _userAddress, hintText: '请输入公司地址')),
          _upLoadImage(),
        ],
      ),
    );
  }
}
