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
            height: Screenutil.length(60),
            width: Screenutil.length(60),
          ),
          SizedBox(width: Screenutil.length(40)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '深证华茂悦峰',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Screenutil.size(34),
                    color: Color(0xff333333)),
              ),
              SizedBox(width: Screenutil.length(10)),
              Text(
                '1幢-1单元-702室',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Screenutil.size(34),
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
        height: Screenutil.length(72),
        width: Screenutil.length(176),
        padding: EdgeInsets.symmetric(
          vertical: Screenutil.length(10),
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
                    height: Screenutil.length(30),
                    width: Screenutil.length(30),
                    color: isCheck ? Color(0xff333333) : Color(0xff979797),
                  )
                : SizedBox(),
            SizedBox(width: Screenutil.length(9)),
            Text(
              title,
              style: TextStyle(
                  fontSize: Screenutil.size(28),
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
          top: Screenutil.length(32),
          left: Screenutil.length(22),
          right: Screenutil.length(35)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Color(0xffd4cfbe), width: 1.0),
      ),
      child: TextFormField(
        cursorColor: Color(0xffffc40c),
        style: TextStyle(
          fontSize: Screenutil.size(28),
          fontWeight: FontWeight.w600,
        ),
        controller: _thingsContent,
        onChanged: (String value) {},
        maxLines: 8,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: Screenutil.length(0),
            bottom: Screenutil.length(0),
          ),
          hintText: hintText,
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

  Widget _positionedButton() {
    return Positioned(
      bottom: 0,
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          height: Screenutil.length(98),
          width: Screenutil.length(750),
          padding: EdgeInsets.symmetric(vertical: Screenutil.length(26.5)),
          color: Color(0xffffc40c),
          child: Text(
            '确认提交',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Screenutil.size(32),
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
        left: Screenutil.length(36),
        right: Screenutil.length(36),
        top: Screenutil.length(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: Screenutil.size(28), color: Color(0xff333333)),
          ),
          SizedBox(height: Screenutil.length(32)),
          widget,
          SizedBox(height: Screenutil.length(26)),
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
          SizedBox(width: Screenutil.length(80)),
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
    //               left: Screenutil.length(36),
    //               right: Screenutil.length(36),
    //               top: Screenutil.length(32),
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   _listWidget[index]['title'],
    //                   style: TextStyle(
    //                       fontSize: Screenutil.size(28),
    //                       color: Color(0xff333333)),
    //                 ),
    //                 SizedBox(height: Screenutil.length(32)),
    //                 _listWidget[index]['widget'],
    //                 SizedBox(height: Screenutil.length(26)),
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
