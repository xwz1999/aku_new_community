import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:extended_text/extended_text.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class AddressItem extends StatelessWidget {
  final String name, phone, address;
  final bool isDefualt;
  AddressItem({Key key, this.name, this.phone, this.address, this.isDefualt})
      : super(key: key);

  Widget _containerImage() {
    return Container(
      alignment: Alignment.center,
      width: 76.w,
      height: 76.w,
      margin: EdgeInsets.only(
        right: 20.w,
      ),
      padding: EdgeInsets.symmetric(vertical: 12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: isDefualt
              ? [Color(0xffffd000), Color(0xffff8500)]
              : [Color(0xffd8d8d8), Color(0xffd8d8d8)],
        ),
        borderRadius: BorderRadius.all(Radius.circular(76.w)),
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
                  fontSize: 28.sp,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(width: 20.w),
              Text(
                phone,
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Color(0xff999999),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.w),
          Container(
            width: 432.w,
            child: ExtendedText.rich(
              TextSpan(
                children: [
                  isDefualt
                      ? ExtendedWidgetSpan(
                          child: Container(
                            margin:
                                EdgeInsets.only(right: 16.w),
                            decoration: BoxDecoration(
                                color: Color(0xfffff7d2),
                                border: Border.all(
                                    color: Color(0xffffd000), width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 4.w,
                            ),
                            child: Text(
                              '默认',
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        )
                      : ExtendedWidgetSpan(child: SizedBox()),
                  TextSpan(
                    text: address,
                    style: TextStyle(
                        fontSize: 24.sp,
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
      top: 55.w,
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
            SizedBox(width: 13.w),
            SizedBox(
              width: 1,
              height: 30.w,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xffd8d8d8)),
              ),
            ),
            SizedBox(width: 13.w),
            Text(
              '编辑',
              style: TextStyle(
                fontSize: 24.sp,
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
        left: 32.w,
        right: 32.w,
        top: 20.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 32.w,
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
