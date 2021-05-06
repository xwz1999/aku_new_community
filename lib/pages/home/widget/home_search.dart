import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/ui/search/bee_search.dart';
import 'package:aku_community/utils/headers.dart';

class HomeSearch extends StatefulWidget {
  HomeSearch({Key? key}) : super(key: key);

  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xffffd000), Color(0xffffbd00)],
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 32.w,
        right: 32.w,
        bottom: 16.w,
      ),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        height: 72.w,
        shape: StadiumBorder(),
        elevation: 0,
        minWidth: double.infinity,
        color: Color(0xFFF3F3F3),
        onPressed: () {
          Get.to(() => BeeSearch());
        },
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 32.w,
              color: Color(0xFF666666),
            ),
            10.wb,
            '搜索应用'
                .text
                .size(28.sp)
                .color(ktextSubColor)
                .make()
                .expand(),
          ],
        ),
      ),
    );
  }
}
