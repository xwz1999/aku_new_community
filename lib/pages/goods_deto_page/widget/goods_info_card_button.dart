import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class GoodsInfoCardButton extends StatelessWidget {
  GoodsInfoCardButton({Key key}) : super(key: key);

  List<Map<String, dynamic>> _listButton = [
    {'title': '查看二维码', 'icon': MaterialCommunityIcons.qrcode},
    {'title': '搬家公司', 'icon': SimpleLineIcons.phone}
  ];
  Future<void> _phoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showDialog(BuildContext context, String url) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            url,
            style: TextStyle(
              fontSize: Screenutil.size(34),
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: Screenutil.size(34),
                  color: Color(0xff333333),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '呼叫',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Screenutil.size(34),
                  color: Color(0xffff8200),
                ),
              ),
              onPressed: () {
                _phoneCall('tel:${url}');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(6),
          bottomRight: Radius.circular(6),
        ),
      ),
      height: Screenutil.length(96),
      child: Row(
        children: _listButton
            .asMap()
            .keys
            .map((index) => Expanded(
                  child: InkWell(
                    onTap: () {
                      switch (_listButton[index]['title']) {
                        case '查看二维码':
                          Navigator.pushNamed(
                              context, PageName.deto_code_page.toString());
                          break;
                        case '搬家公司':
                          _showDialog(context, '0574-88467897');
                          break;
                        default:
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: Screenutil.length(26.5),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                              color: Color(0xffeeeeee),
                              width: index == _listButton.length - 1 ? 0 : 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            _listButton[index]['icon'],
                            size: Screenutil.size(36),
                            color: Color(0xff333333),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: Screenutil.length(14)),
                            child: Text(
                              _listButton[index]['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Screenutil.size(32),
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
