import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/pages/sign/login/other_login_page.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class AccountManagerPage extends StatefulWidget {
  AccountManagerPage({Key? key}) : super(key: key);

  @override
  _AccountManagerPageState createState() => _AccountManagerPageState();
}

class _AccountManagerPageState extends State<AccountManagerPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '账号管理',
      body: ListView(
        children: [
          ListTile(
            title: '账号注销'.text.red500.make(),
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoActionSheet(
                    message: Text('注销当前账号'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text(
                          '确定',
                          style: TextStyle(
                            color: Colors.red.withOpacity(0.7),
                          ),
                        ),
                        onPressed: () {
                          //暂时隐去一键登录页
                          Get.offAll(() => OtherLoginPage());
                        },
                      ),
                    ],
                    cancelButton: CupertinoDialogAction(
                      child: Text('取消'),
                      onPressed: Get.back,
                    ),
                  );
                },
              );
            },
          ).material(color: Colors.white),
        ],
      ),
    );
  }
}
