import 'dart:async';
import 'dart:io';

import 'package:akuCommunity/pages/sign/user_authentication_page.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:ani_route/ani_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:path_provider/path_provider.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _phone = new TextEditingController();
  TextEditingController _code = new TextEditingController();
  String _verifyStr = '获取验证码';
  String pathPDF = "";
  bool _agreementvalue = false;

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      // leading: IconButton(
      //   icon: Icon(AntDesign.left, size: Screenutil.size(40)),
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // ),
    );
  }

  Container _containerTextField(String imagePath,
      TextEditingController controller, String hintText, bool isCode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Screenutil.length(29)),
      margin: EdgeInsets.symmetric(horizontal: Screenutil.length(82)),
      decoration: BoxDecoration(
        color: Color(0xfffff4d7),
        borderRadius: BorderRadius.all(Radius.circular(36)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: Screenutil.length(50),
            width: Screenutil.length(50),
          ),
          SizedBox(width: Screenutil.length(24)),
          Expanded(
            child: TextFormField(
              cursorColor: Color(0xffffc40c),
              style: TextStyle(
                fontSize: BaseStyle.fontSize28,
                fontWeight: FontWeight.w600,
              ),
              controller: controller,
              onChanged: (String value) {},
              maxLines: 1,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: Screenutil.length(25),
                ),
                hintText: hintText,
                border: InputBorder.none, //去掉输入框的下滑线
                fillColor: Color(0xfffff4d7),
                filled: true,
                hintStyle: TextStyle(
                  color: BaseStyle.color999999,
                  fontSize: BaseStyle.fontSize28,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          isCode
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 2,
                      height: Screenutil.length(29),
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xffd8d8d8)),
                      ),
                    ),
                    SizedBox(width: Screenutil.length(16)),
                    InkWell(
                      child: Text(
                        _verifyStr,
                        style: TextStyle(
                          color: BaseStyle.color999999,
                          fontSize: BaseStyle.fontSize28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: null,
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Container _containerImage() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        AssetsImage.LOGO,
        height: Screenutil.length(184),
        width: Screenutil.length(266),
      ),
    );
  }

  InkWell _inkWellLogin() {
    return InkWell(
      onTap: () {
        ARoute.push(context, UserAuthenticationPage());
      },
      child: Container(
        alignment: Alignment.center,
        height: Screenutil.length(89),
        width: Screenutil.length(586),
        padding: EdgeInsets.only(
            top: Screenutil.length(25), bottom: Screenutil.length(24)),
        margin: EdgeInsets.symmetric(horizontal: Screenutil.length(82)),
        decoration: BoxDecoration(
          color: Color(0xffffc40c),
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
        child: Text(
          '登录',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: BaseStyle.fontSize28,
            color: BaseStyle.color333333,
          ),
        ),
      ),
    );
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    fromAsset('assets/agreement.pdf', 'demo.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _statusHeight = MediaQuery.of(context).padding.top;
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Container(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: Screenutil.length(153),
                  ),
                  _containerImage(),
                  SizedBox(height: Screenutil.length(16)),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      '欢迎登录小蜜蜂',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: BaseStyle.fontSize38,
                          color: BaseStyle.color333333),
                    ),
                  ),
                  SizedBox(height: Screenutil.length(89)),
                  _containerTextField(
                      AssetsImage.PHONELOGO, _phone, '请输入手机号码', false),
                  SizedBox(height: Screenutil.length(27)),
                  _containerTextField(
                      AssetsImage.CODELOGO, _code, '请输入验证码', true),
                  SizedBox(height: Screenutil.length(59)),
                  _inkWellLogin(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, PageName.agreement_page.toString(),
                              arguments: Bundle()..putString('path', pathPDF));
                        },
                        child: SizedBox(child: Text('用户协议和隐私政策')),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
