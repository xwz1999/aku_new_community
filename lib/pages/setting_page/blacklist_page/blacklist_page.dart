import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/model/user/blacklist_model.dart';
import 'package:aku_new_community/pages/setting_page/blacklist_page/blacklist_func.dart';
import 'package:aku_new_community/widget/bee_avatar_widget.dart';

import 'package:aku_new_community/widget/dialog/bee_custom_dialog.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';

import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class blackListPage extends StatefulWidget {
  blackListPage({Key? key}) : super(key: key);

  @override
  _blackListPageState createState() => _blackListPageState();
}

class _blackListPageState extends State<blackListPage> {
  List<BlacklistModel> blackList = [];

  // List blackList2 = [
  //   {
  //     'id': 1,
  //     'name': '天天',
  //     'img': [
  //       Assets.images.vegetableBanner.path,
  //       Assets.images.vegetableBanner.path
  //     ]
  //   },
  //   {
  //     'id': 1,
  //     'name': '天天',
  //     'img': [
  //       Assets.images.vegetableBanner.path,
  //       Assets.images.vegetableBanner.path
  //     ]
  //   },
  //   {
  //     'id': 1,
  //     'name': '天天',
  //     'img': [
  //       Assets.images.vegetableBanner.path,
  //       Assets.images.vegetableBanner.path
  //     ]
  //   }
  // ];
  final EasyRefreshController _refreshController = EasyRefreshController();
  late LoadState _loadState;

  @override
  void initState() {
    super.initState();

    ///动态appbar导致 refresh组件刷新判出现问题 首次刷新手动触发
    Future.delayed(Duration(milliseconds: 0), () async {
      await _refresh();
      //setState(() {});
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future _refresh() async {
    blackList = await BlackListFunc.getBlackList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
        title: '黑名单列表',
        body: Column(
          children: [
            Container(
              color: Color(0xF000000).withOpacity(0.06),
              width: MediaQuery.of(context).size.width,
              height: 75.w,
              alignment: Alignment.center,
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: '点击',
                    style:
                        TextStyle(fontSize: 24.sp, color: Color(0xA6000000))),
                TextSpan(
                    text: ' 移出黑名单 ',
                    style: TextStyle(fontSize: 24.sp, color: Colors.blue)),
                TextSpan(
                    text: '即可在社区中显示对方的动态',
                    style:
                        TextStyle(fontSize: 24.sp, color: Color(0xA6000000))),
              ])),
            ),
            20.hb,
            Expanded(
                child:
                    //     ListView.builder(
                    //   itemBuilder: (context, index) {
                    //     //return Text('这是一个开始');
                    //     return _blackList(blackList[index]);
                    //   },
                    //   //itemCount: 6,
                    //   itemCount: blackList.length,
                    // )
                    EasyRefresh(
                        firstRefresh: true,
                        header: MaterialHeader(),
                        //footer: MaterialFooter(),
                        controller: _refreshController,
                        onRefresh: () async {
                          blackList = await BlackListFunc.getBlackList();

                          // blackList = [
                          //   BlacklistModel(
                          //       id: 0,
                          //       imgList: [Assets.images.vegetableBanner.path],
                          //       name: '张天天')
                          // ];
                          setState(() {});
                          // _page
                        },
                        onLoad: () async {
                          _refreshController.finishLoad(noMore: true);
                          // await Future.delayed(const Duration(seconds: 2), () {
                          //   setState(() {
                          //     if (_refreshController.finishLoadCallBack !=
                          //         null) {
                          //       return _End();
                          //     }
                          //   });
                          // });
                          // if (_loadState == LoadState.completed)
                          //   return _End();
                        },
                        child: blackList.isEmpty
                            ? SizedBox()
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  //return Text('这是一个开始');
                                  return _blackList(blackList[index]);
                                },
                                //itemCount: 6,
                                itemCount: blackList.length,
                              ))),
            //if()
          ],
        ));
  }

  _End() {
    return Container(
      color: Color(0xF000000).withOpacity(0.06),
      width: MediaQuery.of(context).size.width,
      height: 75.w,
      alignment: Alignment.center,
      child: Text(
        '后面已经没有其他内容了',
        style:
            TextStyle(fontSize: 24.sp, color: Colors.black.withOpacity(0.25)),
      ),
    );
  }

  _blackList(BlacklistModel model) {
    return Column(
      children: [
        ListTile(
          leading: BeeAvatarWidget(
            imgs: model.imgList,
          )

          // Container(
          //   width: 88.w,
          //   height: 88.w,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(40),
          //       image: DecorationImage(
          //           image: ExactAssetImage(R.ASSETS_IMAGES_PLACEHOLDER_WEBP
          //               //?? model.imgList.first,
          //               ),
          //           fit: BoxFit.cover)),
          // )
          ,
          title: Text(
            model.nickName ?? '',
            style: TextStyle(fontSize: 28.sp, color: ktextSubColor),
          ),
          trailing: GestureDetector(
              onTap: () async {
                await Get.dialog(
                  BeeCustomDialog(
                    height: 247.w,
                    content: Padding(
                        padding: EdgeInsets.only(top: 64.w),
                        child: Text(
                          '确认将该用户移出黑名单列表吗',
                          style: UserTool.myAppStyle.dialogContentText,
                        )),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('考虑一下',
                            style: TextStyle(
                                fontSize: 28.w,
                                color: Colors.black.withOpacity(0.45))),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          var cancelBlock =
                              await BlackListFunc.cancelBlock(model.id);
                          if (cancelBlock) {
                            Get.back();
                            _refreshController.callRefresh();
                          }
                        },
                        child: Text('确认移出',
                            style: UserTool.myAppStyle.dialogActionButtonText),
                      ),
                    ],
                  ),
                  // barrierDismissible: false,
                );
              },
              child: '移出黑名单'.text.size(24.sp).color(Colors.blue).make()),
        ),
        Divider()
      ],
    );
  }

// _getText(String name) {
//   String name2 = name.substring(0, 1);
//   for (var i = 0; i < name.length - 1; i++) {
//     name2 += '*';
//   }
//   return name2;
// }
// _blackList(BlacklistModel model) {
//   return ListTile(
//     leading: Container(
//       width: 88.w,
//       height: 88.w,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(40),
//           image: DecorationImage(
//               image: ExactAssetImage(model.imgList.first),
//               fit: BoxFit.cover)),
//     ),
//     title: model.name.text.size(20.sp).color(ktextSubColor).make(),
//     subtitle: GestureDetector(
//         onTap: () {},
//         child: '移出黑名单'.text.size(24.sp).color(Colors.blue).make()),
//   );
// }
}
