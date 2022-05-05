import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/personal/wallet/pay_way_dialog.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/num_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class WalletRechargePage extends StatefulWidget {
  final initIndex;

  const WalletRechargePage({Key? key, this.initIndex = 0}) : super(key: key);

  @override
  _WalletRechargePageState createState() => _WalletRechargePageState();
}

class _WalletRechargePageState extends State<WalletRechargePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _currentSelect = 0;
  late TabController _tabController;
  List<String> _tabs = ['余额充值', '积分充值'];

  List<int> _balanceValue = [10, 20, 30, 50, 00, 200, 300, 500];
  List<int> _pointValue = [10, 200, 300, 500, 1000, 2000, 5000, 10000];

  int _rechargeValue = 0;

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.initIndex);
    _currentIndex = widget.initIndex;
    _rechargeValue = widget.initIndex == 0 ? _balanceValue[0] : _pointValue[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '钱包充值',
      actions: [
        TextButton(
          onPressed: () {},
          child: '账单'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.85))
              .make(),
        ),
      ],
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
            child: Row(
              children: [
                '余额:${UserTool.userProvider.userInfoModel!.balance ?? 0}'
                    .text
                    .size(32.sp)
                    .color(Colors.black.withOpacity(0.85))
                    .make(),
                64.wb,
                '积分:'
                    .text
                    .size(32.sp)
                    .color(Colors.black.withOpacity(0.85))
                    .make(),
                '${UserTool.userProvider.userInfoModel!.points ?? 0}'
                    .text
                    .size(32.sp)
                    .color(Colors.black.withOpacity(0.85))
                    .make(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    children: _tabs
                        .mapIndexed((index, element) => GestureDetector(
                              onTap: () {
                                _currentIndex = index;
                                _tabController.animateTo(_currentIndex);
                                setState(() {});
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  element.text
                                      .size(28.sp)
                                      .fontWeight(_currentIndex == index
                                          ? FontWeight.bold
                                          : FontWeight.normal)
                                      .color(Colors.black.withOpacity(
                                          _currentIndex == index ? 0.85 : 0.65))
                                      .make(),
                                  8.hb,
                                  AnimatedOpacity(
                                    duration: Duration(microseconds: 500),
                                    opacity: _currentIndex == index ? 1 : 0,
                                    child: Container(
                                      width: 40.w,
                                      height: 8.w,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(4.w),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList()
                        .sepWidget(separate: 48.wb),
                  ),
                  48.hb,
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      _balanceView(),
                      _pointView(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavi: Padding(
        padding: EdgeInsets.only(
            left: 32.w,
            right: 32.w,
            bottom: 32.w + MediaQuery.of(context).padding.bottom),
        child: BeeLongButton(
            onPressed: () async {
              if (_currentSelect == 9) {
                _rechargeValue = 0;
                Get.bottomSheet(_customValueDialog(_currentIndex == 0));
              } else {
                Get.bottomSheet(PayWayDialog(
                    isBalance: _currentIndex == 0,
                    amount: _rechargeValue,
                    insufficientBalance: _rechargeValue >
                        (UserTool.userProvider.userInfoModel!.balance ?? 0)));
              }
            },
            text: '下一步'),
      ),
    );
  }

  Widget _balanceView() {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 20.w,
      crossAxisSpacing: 20.w,
      children: [
        ..._balanceValue
            .mapIndexed((index, e) => _card(index, e, true))
            .toList(),
        _customValueCard(9, true)
      ],
    );
  }

  Widget _pointView() {
    return GridView.count(
      mainAxisSpacing: 20.w,
      crossAxisSpacing: 20.w,
      crossAxisCount: 3,
      children: [
        ..._pointValue
            .mapIndexed((index, element) => _card(index, element, false))
            .toList(),
        _customValueCard(9, false)
      ],
    );
  }

  Widget _card(int index, int value, bool isBalance) {
    return GestureDetector(
      onTap: () {
        _currentSelect = index;
        _rechargeValue = isBalance ? _balanceValue[index] : (_pointValue[index]~/10);
        setState(() {});
      },
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.w),
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          fit: StackFit.passthrough,
          children: [
            Container(
              width: 214.w,
              height: 202.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                color:
                    _currentSelect != index ? Color(0xFFF9F9F9) : Colors.black,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Offstage(
                      offstage: isBalance,
                      child: Assets.icons.intergral
                          .image(width: 48.w, height: 48.w)),
                  8.hb,
                  '$value '
                      .richText
                      .withTextSpanChildren([
                        '${isBalance ? '元' : '积分'} '
                            .textSpan
                            .size(26.sp)
                            .color(_currentSelect == index
                                ? Color(0xFFFBE541)
                                : Colors.black.withOpacity(0.85))
                            .make(),
                      ])
                      .color(_currentSelect == index
                          ? Color(0xFFFBE541)
                          : Colors.black.withOpacity(0.85))
                      .size(40.w)
                      .make(),
                  16.hb,
                  Offstage(
                    offstage: isBalance,
                    child: '${value ~/ 10}元'
                        .text
                        .size(26.sp)
                        .color(_currentSelect == index
                            ? Color(0xFFFBE541)
                            : Colors.black.withOpacity(0.85))
                        .make(),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
                bottom: 0,
                right: 0,
                child: Offstage(
                  offstage: _currentSelect != index,
                  child: ClipPath(
                    clipper: _TriangleClipPath(),
                    child: Container(
                      width: 40.w,
                      height: 48.w,
                      color: Color(0xFFFBE541),
                      child: Transform.translate(
                        offset: Offset(10.w, 12.w),
                        child: Icon(
                          CupertinoIcons.checkmark_alt,
                          size: 24.w,
                        ),
                      ),
                    ),
                  ),
                ),
                duration: Duration(microseconds: 500))
          ],
        ),
      ),
    );
  }

  Widget _customValueCard(int index, bool isBalance) {
    return GestureDetector(
      onTap: () {
        _currentSelect = index;
        setState(() {});
      },
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.w),
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          fit: StackFit.passthrough,
          children: [
            Container(
              width: 214.w,
              height: 202.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                color:
                    _currentSelect != index ? Color(0xFFF9F9F9) : Colors.black,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Offstage(
                      offstage: isBalance,
                      child: Assets.icons.intergral
                          .image(width: 48.w, height: 48.w)),
                  8.hb,
                  ''
                      .richText
                      .withTextSpanChildren([
                        '${isBalance ? '其他金额' : '其他积分'} '
                            .textSpan
                            .size(26.sp)
                            .color(_currentSelect == index
                                ? Color(0xFFFBE541)
                                : Colors.black.withOpacity(0.85))
                            .make(),
                      ])
                      .color(_currentSelect == index
                          ? Color(0xFFFBE541)
                          : Colors.black.withOpacity(0.85))
                      .size(40.w)
                      .make(),
                  16.hb,
                  Offstage(
                    offstage: isBalance,
                    child: '自定义'
                        .text
                        .size(26.sp)
                        .color(_currentSelect == index
                            ? Color(0xFFFBE541)
                            : Colors.black.withOpacity(0.85))
                        .make(),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
                bottom: 0,
                right: 0,
                child: Offstage(
                  offstage: _currentSelect != index,
                  child: ClipPath(
                    clipper: _TriangleClipPath(),
                    child: Container(
                      width: 40.w,
                      height: 48.w,
                      color: Color(0xFFFBE541),
                      child: Transform.translate(
                        offset: Offset(10.w, 12.w),
                        child: Icon(
                          CupertinoIcons.checkmark_alt,
                          size: 24.w,
                        ),
                      ),
                    ),
                  ),
                ),
                duration: Duration(microseconds: 500))
          ],
        ),
      ),
    );
  }

  Widget _customValueDialog(bool isBalance) {
    return StatefulBuilder(
      builder: (context, reSet) {
        return Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                '${isBalance ? '充值金额' : '充值积分'}'
                    .text
                    .size(32.sp)
                    .bold
                    .isIntrinsic
                    .color(Colors.black.withOpacity(0.85))
                    .make(),
                48.hb,
                Container(
                  height: 88.w,
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(16.w)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      24.wb,
                      '¥'
                          .text
                          .size(24.sp)
                          .color(Colors.black.withOpacity(0.45))
                          .make(),
                      12.wb,
                      Expanded(
                          child: TextField(
                        autofocus: true,
                        onChanged: (text) {
                          if (text.trim().isNotEmpty) {
                            _rechargeValue = int.parse(text);
                            reSet(() {});
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(border: InputBorder.none),
                      )),
                      Offstage(
                        offstage: isBalance,
                        child: Row(
                          children: [
                            Assets.icons.intergral
                                .image(width: 32.w, height: 32.w),
                            16.wb,
                            (_rechargeValue * 10)
                                .text
                                .size(32.sp)
                                .color(Colors.black.withOpacity(0.855))
                                .make(),
                            12.wb,
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_rechargeValue == 0) {
                            BotToast.showText(text: '金额不能为0');
                            return;
                          }
                          Get.back();
                          Get.bottomSheet(PayWayDialog(
                              insufficientBalance: (UserTool.userProvider
                                          .userInfoModel!.balance ??
                                      0) <
                                  _rechargeValue,
                              isBalance: isBalance,
                              amount: _rechargeValue));
                        },
                        child: Material(
                          child: Container(
                            width: 132.w,
                            color: Color(0xFFFBE541),
                            child: Center(
                              child: '去支付'
                                  .text
                                  .size(28.sp)
                                  .color(Colors.black.withOpacity(0.85))
                                  .make(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TriangleClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0 + 5.w);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
