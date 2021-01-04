import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/widget/common_input.dart';
import 'package:akuCommunity/widget/single_image_up.dart';
import 'house_info.dart';
import 'decorator_info.dart';

class DirectorManage extends StatefulWidget {
  DirectorManage({Key key}) : super(key: key);

  @override
  _DirectorManageState createState() => _DirectorManageState();
}

class _DirectorManageState extends State<DirectorManage> {

  TextEditingController _companyName = new TextEditingController();

  int memberNum = 1;

  List<Map<String, dynamic>> _uploadImageList = [
    {
      'imagePath': AssetsImage.LICENSE,
      'title': '上传营业执照',
    },
    {
      'imagePath': AssetsImage.LICENSEBACK,
      'title': '上传资质证书',
    },
    {'imagePath': AssetsImage.DRAWINGS, 'title': '上传装修图纸'},
    {'imagePath': AssetsImage.APPLICATION, 'title': '上传装修申请表'},
    {'imagePath': AssetsImage.COMMITMENT, 'title': '上传装修承诺书'}
  ];

  List<Map<String, dynamic>> _listHouse = [
    {'title': '宁波华茂悦峰', 'subtitle': '1幢-1单元-702室'},
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget _doorIdCard() {
    return Container(
      width: 686.w,
      child: RichText(
        text: TextSpan(children: <InlineSpan>[
          TextSpan(
            text: '2',
            style: TextStyle(
              fontSize: BaseStyle.fontSize36,
              color: BaseStyle.color333333,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: '张',
            style: TextStyle(
              fontSize: BaseStyle.fontSize28,
              color: BaseStyle.color333333,
              fontWeight: FontWeight.w600,
            ),
          ),
        ]),
      ),
    );
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
            style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
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
            '上传凭证',
            style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
          ),
          SizedBox(height: 25.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              2,
              (index) => SingleImageUp(
                title: _uploadImageList[index]['title'],
                imagePath: _uploadImageList[index]['imagePath'],
              ),
            ),
          ),
          SizedBox(height: 25.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              2,
              (index) => SingleImageUp(
                title: _uploadImageList.take(4).skip(2).toList()[index]
                    ['title'],
                imagePath: _uploadImageList.take(4).skip(2).toList()[index]
                    ['imagePath'],
              ),
            ),
          ),
          SizedBox(height: 25.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              1,
              (index) => SingleImageUp(
                title: _uploadImageList.take(5).skip(4).toList()[index]
                    ['title'],
                imagePath: _uploadImageList.take(5).skip(4).toList()[index]
                    ['imagePath'],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inkWellSubmit() {
    return InkWell(
      child: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 64.w),
          decoration: BoxDecoration(
            color: BaseStyle.colorffc40c,
            borderRadius: BorderRadius.all(Radius.circular(36)),
          ),
          width: 426.w,
          height: 82.w,
          padding: EdgeInsets.only(
            top: 19.w,
            bottom: 18.w,
          ),
          alignment: Alignment.center,
          child: Text(
            '确认提交',
            style: TextStyle(
              fontSize: BaseStyle.fontSize32,
              color: BaseStyle.color333333,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 32.w,
                  left: 32.w,
                  right: 32.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: _listHouse
                          .map((item) => HouseInfo(
                                title: item['title'],
                                subtitle: item['subtitle'],
                              ))
                          .toList(),
                    ),
                    _cardList(
                        '装修公司',
                        CommonInput(
                            inputController: _companyName,
                            hintText: '请输入公司名称')),
                    _cardList('门禁卡数量', _doorIdCard()),
                    _upLoadImage(),
                    SizedBox(height: 78.w),
                    Text(
                      '装修人员',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: BaseStyle.fontSize32,
                          color: BaseStyle.color333333),
                    ),
                    Column(
                      children:
                          List.generate(memberNum, (index) => DecoratorInfo()),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          memberNum++;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 54.w),
                        padding: EdgeInsets.only(
                          top: 16.w,
                          bottom: 16.w,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '继续添加装修工人',
                          style: TextStyle(
                              fontSize: BaseStyle.fontSize24,
                              color: BaseStyle.color999999),
                        ),
                      ),
                    ),
                    _inkWellSubmit(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
