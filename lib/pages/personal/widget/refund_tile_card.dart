import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';

class RefundTileCard extends StatefulWidget {
  final List<Map<String, dynamic>> listTile;
  RefundTileCard({Key key, this.listTile}) : super(key: key);

  @override
  _RefundTileCardState createState() => _RefundTileCardState();
}

class _RefundTileCardState extends State<RefundTileCard> {
  Container _refundTile(String title, subtitle) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 26.w),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: BaseStyle.fontSize34,
              color: ktextPrimary,
            ),
          ),
          SizedBox(height: 24.w),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: BaseStyle.fontSize28,
              color: BaseStyle.color999999,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: widget.listTile
            .map(
              (item) => InkWell(
                onTap: item['fun'],
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 22.w,
                    left: 32.w,
                    right: 32.w,
                  ),
                  color: Colors.white,
                  child: Stack(
                    children: [
                      _refundTile(
                        item['title'],
                        item['subtitle'],
                      ),
                      item['isRight']
                          ? Positioned(
                              top: 45.w,
                              right: 0,
                              child: Icon(
                                AntDesign.right,
                                size: 40.sp,
                                color: BaseStyle.colord8d8d8,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
