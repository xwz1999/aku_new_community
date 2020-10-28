import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_image_picker.dart';

class ThingsCreatePage extends StatefulWidget {
  final Bundle bundle;
  ThingsCreatePage({Key key, this.bundle}) : super(key: key);

  @override
  _ThingsCreatePageState createState() => _ThingsCreatePageState();
}

class _ThingsCreatePageState extends State<ThingsCreatePage> {
  TextEditingController _thingsContent = new TextEditingController();

  String hintText = '您对我们的工作有什么建议吗？欢迎您提供给我们宝贵的建议，谢谢';

  List<Map<String, dynamic>> _typeList = [];

  @override
  void initState() {
    super.initState();
    if (widget.bundle.getMap('create')['isIdea'] != null) {
      _typeList = [
        {
          'title': widget.bundle.getMap('create')['isIdea'] ? '建议' : '投诉',
          'image': widget.bundle.getMap('create')['isIdea']
              ? AssetsImage.PROPOSAL
              : AssetsImage.COMPLAINT,
          'isCheck': true
        },
        {
          'title': widget.bundle.getMap('create')['isIdea'] ? '咨询' : '表扬',
          'image': widget.bundle.getMap('create')['isIdea']
              ? AssetsImage.CONSULT
              : AssetsImage.LIKE,
          'isCheck': false
        },
      ];
    } else {
      _typeList = [
        {'title': '公区报修', 'isCheck': true},
        {'title': '家庭维修', 'isCheck': false},
      ];
    }
  }

  Widget _containerHouse() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AssetsImage.HOUSE,
            height: 60.w,
            width: 60.w,
          ),
          SizedBox(width: 40.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '深证华茂悦峰',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 34.sp,
                    color: Color(0xff333333)),
              ),
              SizedBox(width: 10.w),
              Text(
                '1幢-1单元-702室',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 34.sp,
                    color: Color(0xff333333)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _inkWellType(String title, image, bool isCheck, int index) {
    return InkWell(
      onTap: () {
        _typeList.forEach((item) {
          item['isCheck'] = false;
        });
        _typeList[index]['isCheck'] = true;
        setState(() {});
      },
      child: Container(
        height: 72.w,
        width: 176.w,
        padding: EdgeInsets.symmetric(
          vertical: 10.w,
        ),
        decoration: BoxDecoration(
            color: isCheck ? Color(0xfffff4d3) : Color(0xffffffff),
            borderRadius: BorderRadius.all(Radius.circular(36)),
            border: Border.all(
                color: isCheck ? Color(0xffffc40c) : Color(0xff979797),
                width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null
                ? Image.asset(
                    image,
                    height: 30.w,
                    width: 30.w,
                    color: isCheck ? Color(0xff333333) : Color(0xff979797),
                  )
                : SizedBox(),
            SizedBox(width: 9.w),
            Text(
              title,
              style: TextStyle(
                  fontSize: 28.sp,
                  color: isCheck ? Color(0xff333333) : Color(0xff979797)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerTextField() {
    return Container(
      padding: EdgeInsets.only(
          top: 32.w,
          left: 22.w,
          right: 35.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Color(0xffd4cfbe), width: 1.0),
      ),
      child: TextFormField(
        cursorColor: Color(0xffffc40c),
        style: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w600,
        ),
        controller: _thingsContent,
        onChanged: (String value) {},
        maxLines: 8,
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
            fontSize: 28.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _positionedButton() {
    return Positioned(
      bottom: 0,
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          height: 98.w,
          width: 750.w,
          padding: EdgeInsets.symmetric(vertical: Screenutil.length(26.5)),
          color: Color(0xffffc40c),
          child: Text(
            '确认提交',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.sp,
              color: Color(0xff333333),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardList(String title, Widget widget) {
    return Container(
      padding: EdgeInsets.only(
        left: 36.w,
        right: 36.w,
        top: 32.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 28.sp, color: Color(0xff333333)),
          ),
          SizedBox(height: 32.w),
          widget,
          SizedBox(height: 26.w),
          // index == 0 ? Divider() : SizedBox(),
        ],
      ),
    );
  }

  Widget _containerType() {
    return Container(
      child: Row(
        children: [
          _inkWellType(_typeList[0]['title'], _typeList[0]['image'],
              _typeList[0]['isCheck'], 0),
          SizedBox(width: 80.w),
          _inkWellType(_typeList[1]['title'], _typeList[1]['image'],
              _typeList[1]['isCheck'], 1),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> _listWidget = [
    //   {'title': '业主/租客房屋', 'widget': _containerHouse()},
    //   {'title': '您要选择的类型是?', 'widget': _containerType()},
    //   {'title': '请输入内容', 'widget': _containerTextField()},
    //   {'title': '添加图片信息(0/9)', 'widget': _containerAddImage()},
    // ];

    // List<Widget> _listView() {
    //   return _listWidget
    //       .asMap()
    //       .keys
    //       .map((index) => Container(
    //             padding: EdgeInsets.only(
    //               left: 36.w,
    //               right: 36.w,
    //               top: 32.w,
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   _listWidget[index]['title'],
    //                   style: TextStyle(
    //                       fontSize: 28.sp,
    //                       color: Color(0xff333333)),
    //                 ),
    //                 SizedBox(height: 32.w),
    //                 _listWidget[index]['widget'],
    //                 SizedBox(height: 26.w),
    //                 index == 0 ? Divider() : SizedBox(),
    //               ],
    //             ),
    //           ))
    //       .toList();
    // }

    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '${widget.bundle.getMap('create')['title']}',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            ListView(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Column(
                    children: [
                      _cardList('业主/租客房屋', _containerHouse()),
                      _cardList('您要选择的类型是?', _containerType()),
                      _cardList('请输入内容', _containerTextField()),
                      _cardList('添加图片信息(0/9)', CommonImagePicker()),
                    ],
                  ),
                ),
              ],
            ),
            _positionedButton(),
          ],
        ),
      ),
    );
  }
}
