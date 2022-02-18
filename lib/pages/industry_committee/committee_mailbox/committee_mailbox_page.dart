import 'package:flutter/material.dart';

import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class CommitteeMailboxPage extends StatefulWidget {
  CommitteeMailboxPage({Key? key}) : super(key: key);

  @override
  _CommitteeMailboxPageState createState() => _CommitteeMailboxPageState();
}

class _CommitteeMailboxPageState extends State<CommitteeMailboxPage> {
  TextEditingController _thingsContent = new TextEditingController();

  Widget _input() {
    return Container(
      padding: EdgeInsets.only(top: 32.w, left: 22.w, right: 35.w),
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
          hintText: '',
          border: InputBorder.none,
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

  Widget _create() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 96.w,
        width: 686.w,
        padding: EdgeInsets.symmetric(
          vertical: 26.w,
        ),
        margin: EdgeInsets.only(top: 40.w),
        decoration: BoxDecoration(
            color: Color(0xffffc40c),
            borderRadius: BorderRadius.all(Radius.circular(48.w))),
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
      title: '业委会信箱',
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
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
                        vertical: 48.w,
                      ),
                      child: Text(
                        '您对园区的规约、管理、环境、活动等各方面有何宝贵建议，请写在下方为园区建设贡献一份力量。',
                        style: TextStyle(
                          fontSize: 28.sp,
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
