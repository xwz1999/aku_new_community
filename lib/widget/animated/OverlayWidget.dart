import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_new_community/pages/opening_code_page/opening_code_page.dart';
import 'package:aku_new_community/utils/headers.dart';

class OverlayLivingBtnWidget extends StatefulWidget {
  OverlayLivingBtnWidget({
    Key? key,
  }) : super(key: key);

  @override
  _OverlayLivingBtnWidgetState createState() => _OverlayLivingBtnWidgetState();
}

class _OverlayLivingBtnWidgetState extends State<OverlayLivingBtnWidget>
    with TickerProviderStateMixin {
  double _topPos = 0;
  double _leftPos = 0;
  bool _isMoving = false;
  double _width = 65;

  double get _subWidth => _width / 2;
  double _height = 65;

  double get _subHeight => _height / 2;
  bool _isHide = false;

  @override
  void initState() {
    super.initState();

    _topPos = ScreenUtil().screenHeight - 20 - _height - 50;
    _leftPos = _leftPos = ScreenUtil().screenWidth - 20 - _width;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: _isHide ? -_width : _leftPos,
      top: _topPos,
      child: Container(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 65.w,
                height: 65.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(R.ASSETS_ICONS_ICON_MAIN_OPEN_PNG),
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => OpeningCodePage());
              },
              onPanUpdate: (detail) {
                setState(() {
                  _topPos = detail.globalPosition.dy - _subHeight;
                  _leftPos = detail.globalPosition.dx - _subWidth;
                });
              },
              onPanStart: (detail) {
                setState(() {
                  _isMoving = true;
                });
              },
              onPanEnd: (detail) {
                _isMoving = false;
                if (_leftPos < 20) _leftPos = 20;
                if (_topPos < ScreenUtil().statusBarHeight + 20)
                  _topPos = (20 + ScreenUtil().statusBarHeight);
                if ((_leftPos + _width + 20) > ScreenUtil().screenWidth)
                  _leftPos = ScreenUtil().screenWidth - 20 - _width;
                if ((_topPos + _height + 55 + 20) > ScreenUtil().screenHeight)
                  _topPos = ScreenUtil().screenHeight - 20 - _height - 55;
                setState(() {});
              },
              child: Container(
                height: _height,
                width: _width,
                color: Colors.transparent,
              ),
            ),
            // Positioned(
            //   right: 5,
            //   top: 5,
            //   child: GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         _isHide = true;
            //       });
            //     },
            //     child: Container(
            //       height: 20,
            //       width: 20,
            //       child: Icon(
            //         Icons.clear,
            //         size: 16,
            //         color: Colors.black,
            //       ),
            //       decoration: BoxDecoration(
            //         color: Colors.white.withOpacity(0.3),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      curve: Curves.easeInOutCubic,
      duration: _isMoving ? Duration.zero : Duration(milliseconds: 300),
    );
  }
}
