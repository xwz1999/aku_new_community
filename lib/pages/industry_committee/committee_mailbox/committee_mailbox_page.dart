import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class CommitteeMailboxPage extends StatefulWidget {
  CommitteeMailboxPage({Key key}) : super(key: key);

  @override
  _CommitteeMailboxPageState createState() => _CommitteeMailboxPageState();
}

class _CommitteeMailboxPageState extends State<CommitteeMailboxPage> {
  TextEditingController _thingsContent = new TextEditingController();
  Widget _input() {
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
          hintText: '',
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

  Widget _create() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: Screenutil.length(96),
        width: Screenutil.length(686),
        padding: EdgeInsets.symmetric(
          vertical: Screenutil.length(26),
        ),
        margin: EdgeInsets.only(top: Screenutil.length(40)),
        decoration: BoxDecoration(
            color: Color(0xffffc40c),
            borderRadius:
                BorderRadius.all(Radius.circular(Screenutil.length(48)))),
        child: Text(
          '确认提交',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Screenutil.size(32),
              color: Color(0xff333333)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '业委会信箱',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: Screenutil.length(32)),
          children: [
            SingleChildScrollView(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: Screenutil.length(48),
                      ),
                      child: Text(
                        '您对园区的规约、管理、环境、活动等各方面有何宝贵建议，请写在下方为园区建设贡献一份力量。',
                        style: TextStyle(
                          fontSize: Screenutil.size(28),
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                    _input(),
                    _create(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
