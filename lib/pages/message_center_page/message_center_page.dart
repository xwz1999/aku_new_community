import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

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
      fontSize: Screenutil.size(32),
      color: Color(0xff333333),
    );
  }

  TextStyle _textStyleSubtitle() {
    return TextStyle(
      fontSize: Screenutil.size(28),
      color: Color(0xff333333),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '消息中心',
          subtitle: '全部已读',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: List.generate(
              _messageList.length,
              (index) => InkWell(
                    onTap: () {
                      switch (_messageList[index]['title']) {
                        case '系统通知':
                          Navigator.pushNamed(context, PageName.system_message_page.toString());
                          break;
                        case '评论通知':
                          Navigator.pushNamed(context, PageName.comment_message_page.toString());
                          break;
                        case '商城通知':
                          Navigator.pushNamed(context, PageName.shop_message_page.toString());
                          break;
                        default:
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: Screenutil.length(36),
                        bottom: Screenutil.length(19),
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: Screenutil.length(32)),
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
                            height: Screenutil.length(90),
                            width: Screenutil.length(90),
                          ),
                          SizedBox(width: Screenutil.length(14)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _messageList[index]['title'],
                                style: _textStyleTitle(),
                              ),
                              SizedBox(height: Screenutil.length(5)),
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
