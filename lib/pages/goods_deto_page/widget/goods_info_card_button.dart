import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:aku_community/model/manager/article_QR_code_model.dart';
import 'package:aku_community/pages/goods_deto_page/deto_code_page/deto_code_page.dart';
import 'package:aku_community/pages/manager_func.dart';
import 'package:aku_community/utils/headers.dart';

class GoodsInfoCardButton extends StatelessWidget {
  final String tel;
  final int id;
  GoodsInfoCardButton({Key key, this.tel, this.id}) : super(key: key);

  final List<Map<String, dynamic>> _listButton = [
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
              fontSize: 34.sp,
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: 34.sp,
                  color: Color(0xff333333),
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '呼叫',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 34.sp,
                  color: Color(0xffff8200),
                ),
              ),
              onPressed: () {
                _phoneCall('tel:$url');
                Get.back();
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
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(6),
          bottomRight: Radius.circular(6),
        ),
      ),
      height: 96.w,
      child: Row(
        children: _listButton
            .asMap()
            .keys
            .map((index) => Expanded(
                  child: InkWell(
                    onTap: () async {
                      switch (_listButton[index]['title']) {
                        case '查看二维码':
                          ArticleQRModel _model =
                              await ManagerFunc.getQRcode(id);
                          if (_model.status) {
                            Get.to(() => DetoCodePage(id: id, model: _model));
                          } else {
                            BotToast.showText(text: _model.message);
                          }
                          break;
                        case '搬家公司':
                          if (tel.isEmptyOrNull) {
                            return null;
                          } else
                            _showDialog(context, tel);
                          break;
                        default:
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 26.5.w,
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
                            size: 36.sp,
                            color: Color(0xff333333),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 14.w),
                            child: Text(
                              _listButton[index]['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 32.sp,
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
