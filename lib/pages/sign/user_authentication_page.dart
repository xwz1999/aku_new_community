import 'package:akuCommunity/pages/tab_navigator.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:ani_route/ani_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:provider/provider.dart';

class UserAuthenticationPage extends StatefulWidget {
  final BuildContext context;
  UserAuthenticationPage({Key key, this.context}) : super(key: key);

  @override
  _UserAuthenticationPageState createState() => _UserAuthenticationPageState();
}

class _UserAuthenticationPageState extends State<UserAuthenticationPage> {
  TextEditingController _userNickName = new TextEditingController();
  TextEditingController _userName = new TextEditingController();
  TextEditingController _userIDCard = new TextEditingController();

  List<Map<String, dynamic>> _listRadio = [
    {'title': '租客', 'isCheck': false},
    {'title': '业主', 'isCheck': false},
    {'title': '亲属', 'isCheck': false}
  ];

  AppBar _appBar() {
    final userProvider=Provider.of<UserProvider>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(AntDesign.left, size: Screenutil.size(40)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        MaterialButton(
          child: Text('跳过'),
          onPressed: () {
            userProvider.setisSigned(true);
            ARoute.pop(context,root: true);
            ARoute.pushReplace(context, TabNavigator());
          },
        ),
      ],
    );
  }

  Text _textTag(String tag) {
    return Text(
      tag,
      style: TextStyle(
          fontSize: BaseStyle.fontSize28, color: BaseStyle.color999999),
    );
  }

  Column _columnRadio() {
    return Column(
      children: _listRadio
          .map((item) => Container(
                padding: EdgeInsets.only(
                  bottom: Screenutil.length(16),
                  top: Screenutil.length(40),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(color: BaseStyle.colord8d8d8, width: 0.5),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _listRadio.forEach((item) {
                        item['isCheck'] = false;
                      });
                      item['isCheck'] = true;
                    });
                  },
                  child: Row(
                    children: [
                      item['isCheck']
                          ? Icon(Icons.radio_button_checked,
                              color: BaseStyle.colorffc40c)
                          : Icon(
                              Icons.radio_button_unchecked,
                              color: BaseStyle.color999999,
                            ),
                      SizedBox(width: Screenutil.length(17)),
                      Text(
                        item['title'],
                        style: TextStyle(
                            fontWeight: item['isCheck']
                                ? FontWeight.w600
                                : FontWeight.normal,
                            fontSize: BaseStyle.fontSize28,
                            color: item['isCheck']
                                ? BaseStyle.color333333
                                : BaseStyle.color999999),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }

  Container _containerTextField(
      TextEditingController controller, String hintText) {
    return Container(
      child: TextFormField(
        cursorColor: Color(0xffffc40c),
        style: TextStyle(
          color: BaseStyle.color999999,
          fontSize: BaseStyle.fontSize34,
        ),
        controller: controller,
        onChanged: (String value) {},
        maxLines: 1,
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
            color: BaseStyle.color999999,
            fontSize: BaseStyle.fontSize34,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _listWidget = [
      {
        'title': '请输入您的昵称',
        'widget': _containerTextField(_userNickName, '为保护个人隐私，在与邻居交流时将显示昵称')
      },
      {'title': '请输入您的姓名', 'widget': _containerTextField(_userName, '请输入您的姓名')},
      {
        'title': '请输入您的身份证',
        'widget': _containerTextField(_userIDCard, '请输入您的身份证号')
      },
    ];
    List<Widget> _listView() {
      return _listWidget
          .map((item) => Container(
                padding: EdgeInsets.only(
                  top: Screenutil.length(23),
                  bottom: Screenutil.length(24),
                ),
                decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: TextStyle(
                          fontSize: BaseStyle.fontSize28,
                          color: BaseStyle.color333333),
                    ),
                    SizedBox(height: Screenutil.length(25)),
                    item['widget'],
                  ],
                ),
              ))
          .toList();
    }

    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              padding: EdgeInsets.only(
                left: Screenutil.length(32),
                right: Screenutil.length(32),
                top: Screenutil.length(32),
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '欢迎登录小蜜蜂',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: BaseStyle.fontSize38,
                        color: BaseStyle.color333333),
                  ),
                  SizedBox(height: Screenutil.length(8)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textTag('身份选择'),
                      SizedBox(height: Screenutil.length(167)),
                      _columnRadio(),
                      Column(
                        children: _listView(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
