// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/pages/message_center_page/comment_message_page/comment_message_page.dart';
import 'package:akuCommunity/pages/message_center_page/shop_message_page/shop_message_page.dart';
import 'package:akuCommunity/pages/message_center_page/system_message_page/system_message_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class MessageCenterPage extends StatefulWidget {
  MessageCenterPage({Key key}) : super(key: key);

  @override
  _MessageCenterPageState createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage> {
  List<Map<String, dynamic>> _messageList = [
    {
      'title': '系统通知',
      'imagePath': AssetsImage.SYSTEMNOTICE,
      'subtitle': '业主信息审核:未通过'
    },
    {
      'title': '评论通知',
      'imagePath': AssetsImage.COMMENTNOTICE,
      'subtitle': '周玲慧评论了你的动态'
    },
    {
      'title': '商城通知',
      'imagePath': AssetsImage.SHOPNOTICE,
      'subtitle': '您的宝贝已经发货'
    }
  ];

  TextStyle _textStyleTitle() {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 32.sp,
      color: Color(0xff333333),
    );
  }

  TextStyle _textStyleSubtitle() {
    return TextStyle(
      fontSize: 28.sp,
      color: Color(0xff333333),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '消息中心',
      actions: [
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.fromLTRB(32.w, 28.w, 32.w, 20.w),
            child: '全部已读'.text.black.size(28.sp).make(),
            alignment: Alignment.center,
          ),
        )
      ],
      body: Container(
        color: Colors.white,
        child: ListView(
          children: List.generate(
              _messageList.length,
              (index) => InkWell(
                    onTap: () {
                      switch (_messageList[index]['title']) {
                        case '系统通知':
                          SystemMessagePage().to;
                          break;
                        case '评论通知':
                          CommentMessagePage().to;
                          break;
                        case '商城通知':
                          ShopMessagePage().to;
                          break;
                        default:
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 36.w,
                        bottom: 19.w,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 32.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: Divider.createBorderSide(context,
                              color: Color(0xffd8d8d8), width: 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            _messageList[index]['imagePath'],
                            height: 90.w,
                            width: 90.w,
                          ),
                          SizedBox(width: 14.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _messageList[index]['title'],
                                style: _textStyleTitle(),
                              ),
                              SizedBox(height: 5.w),
                              Text(
                                _messageList[index]['subtitle'],
                                maxLines: 1,
                                style: _textStyleSubtitle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
