import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/services/old_age/submit_equipment_code_page.dart';
import 'package:aku_new_community/widget/bee_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddEquipmentPage extends StatefulWidget {
  const AddEquipmentPage({Key? key}) : super(key: key);

  @override
  _AddEquipmentPageState createState() => _AddEquipmentPageState();
}

class _AddEquipmentPageState extends State<AddEquipmentPage> {
  List<String> _tabs = ['手环手表', '睡眠仪', '居家报警器', '血压计'];
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BeeBackButton(),
        backgroundColor: Colors.white,
        leadingWidth: 104.w,
        title: Container(
          width: 614.w,
          height: 64.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: Colors.black.withOpacity(0.06),
          ),
          child: TextField(
            decoration: InputDecoration(
                hintText: '请输入设备，品牌名称',
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    EdgeInsets.only(left: 32.w, bottom: 12.w, top: 12.w),
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.25),
                  fontSize: 28.sp,
                )),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            8.w.heightBox,
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(32.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 154.w,
                      child: ListView(
                        children: [
                          ..._tabs
                              .mapIndexed((e, index) => _tabWidget(e, index))
                              .toList()
                        ],
                      ),
                    ),
                    Expanded(
                        child: PageView(
                      controller: _pageController,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _braceletGid(),
                        Center(),
                        Center(),
                        Center(),
                      ],
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _braceletGid() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40.w,
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      color: Colors.black.withOpacity(0.06),
                      height: 1.w,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: '爱牵挂'
                        .text
                        .size(24.sp)
                        .color(Colors.black.withOpacity(0.45))
                        .make(),
                  ),
                  Flexible(
                    child: Container(
                      color: Colors.black.withOpacity(0.06),
                      height: 1.w,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => SubmitEquipmentCodePage());
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Assets.bracelet.x5.image(width: 120.w, height: 120.w),
                        8.w.heightBox,
                        'x5手环'.text.size(24.sp).color(Colors.black).make(),
                      ],
                    ),
                  ),
                )
              ],
              crossAxisCount: 3,
            )
          ],
        )
      ],
    );
  }

  Widget _tabWidget(String title, int index) {
    return GestureDetector(
      onTap: () {
        _currentIndex = index;
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        setState(() {});
      },
      child: index == _currentIndex
          ? Container(
              width: double.infinity,
              height: 56.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFF5096F1),
                  borderRadius: BorderRadius.circular(40.w)),
              child: title.text.size(24.sp).color(Colors.white).make(),
            )
          : Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24.w),
              alignment: Alignment.center,
              child: title.text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.85))
                  .make(),
            ),
    );
  }
}
