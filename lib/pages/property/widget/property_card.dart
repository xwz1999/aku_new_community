import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/utils/screenutil.dart';

class PropertyCard extends StatelessWidget {
  PropertyCard({Key key}) : super(key: key);

  List<Map<String, dynamic>> _listCard = [
    {
      'title': '语音管家',
      'subtitle': '随时随地帮你下单',
      'image': AssetsImage.PROPERTY,
      'coloList': [Color(0xff33dfe4), Color(0xff00ccf3)],
      'shapeColoList': [Color(0xff04ddf2), Color(0xff339a8f)]
    },
    {
      'title': '电话物业',
      'subtitle': '24小时在线',
      'image': AssetsImage.PROPERTY,
      'coloList': [Color(0xff42ceff), Color(0xff198cfb)],
      'shapeColoList': [Color(0xff42ceff), Color(0xff0b69c4)]
    }
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
      margin: EdgeInsets.symmetric(
        horizontal: Screenutil.length(32),
        vertical: Screenutil.length(20),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _listCard.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              switch (_listCard[index]['title']) {
                case '电话物业':
                  _showDialog(context, '0574-88467897');
                  break;
                case '语音管家':
                  break;
                default:
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Screenutil.length(19),
                vertical: Screenutil.length(36),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: _listCard[index]['coloList'],
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: Screenutil.length(88),
                    width: Screenutil.length(88),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: _listCard[index]['shapeColoList'],
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Image.asset(
                      _listCard[index]['image'],
                      fit: BoxFit.fill,
                      height: Screenutil.length(64),
                      width: Screenutil.length(77),
                    ),
                  ),
                  SizedBox(width: Screenutil.length(24)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Screenutil.length(5)),
                      Text(
                        _listCard[index]['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Screenutil.size(32),
                          color: Color(0xffffffff),
                        ),
                      ),
                      SizedBox(height: Screenutil.length(4)),
                      Text(
                        _listCard[index]['subtitle'],
                        style: TextStyle(
                          fontSize: Screenutil.size(20),
                          color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: Screenutil.length(40),
            childAspectRatio: Screenutil.length(323) / Screenutil.length(160)),
      ),
    );
  }
}
