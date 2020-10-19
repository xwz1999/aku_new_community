import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:extended_text/extended_text.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class AddressItem extends StatelessWidget {
  final String name, phone, address;
  final bool isDefualt;
  AddressItem({Key key, this.name, this.phone, this.address, this.isDefualt})
      : super(key: key);

  Widget _containerImage() {
    return Container(
      alignment: Alignment.center,
      width: Screenutil.length(76),
      height: Screenutil.length(76),
      margin: EdgeInsets.only(
        right: Screenutil.length(20),
      ),
      padding: EdgeInsets.symmetric(vertical: Screenutil.length(12)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: isDefualt
              ? [Color(0xffffd000), Color(0xffff8500)]
              : [Color(0xffd8d8d8), Color(0xffd8d8d8)],
        ),
        borderRadius: BorderRadius.all(Radius.circular(Screenutil.length(76))),
      ),
      child: Icon(SimpleLineIcons.location_pin, color: Colors.white),
    );
  }

  Widget _containerColumn() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: Screenutil.size(28),
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(width: Screenutil.length(20)),
              Text(
                phone,
                style: TextStyle(
                  fontSize: Screenutil.size(24),
                  color: Color(0xff999999),
                ),
              ),
            ],
          ),
          SizedBox(height: Screenutil.length(12)),
          Container(
            width: Screenutil.length(432),
            child: ExtendedText.rich(
              TextSpan(
                children: [
                  isDefualt
                      ? ExtendedWidgetSpan(
                          child: Container(
                            margin:
                                EdgeInsets.only(right: Screenutil.length(16)),
                            decoration: BoxDecoration(
                                color: Color(0xfffff7d2),
                                border: Border.all(
                                    color: Color(0xffffd000), width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            padding: EdgeInsets.symmetric(
                              horizontal: Screenutil.length(20),
                              vertical: Screenutil.length(4),
                            ),
                            child: Text(
                              '默认',
                              style: TextStyle(
                                fontSize: Screenutil.size(24),
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        )
                      : ExtendedWidgetSpan(child: SizedBox()),
                  TextSpan(
                    text: address,
                    style: TextStyle(
                        fontSize: Screenutil.size(24),
                        color: Color(0xff999999),
                        height: 1.5),
                  )
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _positionedEdit(BuildContext context) {
    return Positioned(
      right: 0,
      top: Screenutil.length(55),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, PageName.address_edit_page.toString(),
              arguments: Bundle()
                ..putMap('details', {
                  'title': '编辑地址',
                  'name': name,
                  'phone': phone,
                  'address': address,
                  'isDelete': true
                }));
        },
        child: Row(
          children: [
            SizedBox(width: Screenutil.length(13)),
            SizedBox(
              width: 1,
              height: Screenutil.length(30),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xffd8d8d8)),
              ),
            ),
            SizedBox(width: Screenutil.length(13)),
            Text(
              '编辑',
              style: TextStyle(
                fontSize: Screenutil.size(24),
                color: Color(0xff999999),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: EdgeInsets.only(
        left: Screenutil.length(32),
        right: Screenutil.length(32),
        top: Screenutil.length(20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Screenutil.length(20),
        vertical: Screenutil.length(32),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              _containerImage(),
              _containerColumn(),
            ],
          ),
          _positionedEdit(context),
        ],
      ),
    );
  }
}
