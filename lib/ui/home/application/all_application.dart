// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/application_objects.dart';
import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/ui/search/bee_search.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_back_button.dart';

class AllApplicationPage extends StatefulWidget {
  AllApplicationPage({Key key}) : super(key: key);

  @override
  _AllApplicationPageState createState() => _AllApplicationPageState();
}

class _AllApplicationPageState extends State<AllApplicationPage> {
  bool _editMode = false;

  int _index = 0;

  PageController _pageController = PageController();

  _buildTile(AO object, {bool editMode = false}) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
      padding: EdgeInsets.zero,
      onPressed: editMode ? null : () => Get.to(object.page),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            object.path,
            height: 75.w,
            width: 75.w,
          ),
          8.hb,
          object.title.text.size(24.sp).make(),
        ],
      ),
    );
  }

  _buildEditTile() {
    return Row(
      children: [
        74.hb,
        '我的应用'.text.make(),
        Spacer(),
        MaterialButton(
          padding: EdgeInsets.zero,
          elevation: 0,
          height: 52.w,
          minWidth: 90.w,
          onPressed: () {
            _editMode = !_editMode;
            setState(() {});
          },
          color: kPrimaryColor,
          child: (_editMode ? '完成' : '编辑').text.bold.size(28.sp).make(),
        ),
      ],
    ).pSymmetric(h: 32.w).material(color: Colors.white);
  }

  _buildMyApp() {
    final appProvider = Provider.of<AppProvider>(context);
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            _buildTile(
              appProvider.myApplications[index],
              editMode: _editMode,
            ),
            Positioned(
              right: 0,
              top: 0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                opacity: _editMode ? 1 : 0,
                child: CupertinoButton(
                  minSize: 60.w,
                  padding: EdgeInsets.zero,
                  onPressed: _editMode
                      ? () {
                          appProvider.removeApplication(
                            appProvider.myApplications[index],
                          );
                        }
                      : null,
                  child: Image.asset(
                    R.ASSETS_ICONS_APP_REDUCE_PNG,
                    height: 24.w,
                    width: 24.w,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      itemCount: appProvider.myApplications.length,
    ).material(color: Colors.white);
  }

  _buildListTile(String title, int index) {
    bool sameIndex = _index == index;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          color: sameIndex ? Colors.white : Color(0xFFEFEFEF),
          elevation: 0,
          height: 88.w,
          onPressed: () {
            setState(() {
              _index = index;
            });
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
            );
          },
          child: title.text.size(28.sp).make(),
        ),
        Positioned(
          left: 0,
          top: 24.w,
          bottom: 24.w,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            width: sameIndex ? 3.w : 10.w,
            color: sameIndex ? kPrimaryColor : kPrimaryColor.withOpacity(0),
          ),
        ),
      ],
    );
  }

  Widget _buildView(List<AO> objects) {
    final appProvider = Provider.of<AppProvider>(context);
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            _buildTile(objects[index], editMode: _editMode),
            Positioned(
              right: 0,
              top: 0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                opacity: _editMode ? 1 : 0,
                child: CupertinoButton(
                  minSize: 60.w,
                  padding: EdgeInsets.zero,
                  onPressed: _editMode
                      ? () => appProvider.insertApplication(objects[index])
                      : null,
                  child: Image.asset(
                    R.ASSETS_ICONS_APP_ADD_PNG,
                    height: 24.w,
                    width: 24.w,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      itemCount: objects.length,
    );
  }

  Widget _buildAppList() {
    return Row(
      children: [
        SizedBox(
          width: 172.w,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildListTile('为您推荐', 0),
              _buildListTile('智慧管家', 1),
              // _buildListTile('商城购物', 2),
            ],
          ),
        ).material(color: Color(0xFFEFEFEF)),
        PageView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: _pageController,
          children: [
            _buildView(recommendApp),
            _buildView(smartManagerApp),
          ],
        ).expand(),
      ],
    ).material(color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BeeBackButton(),
        title: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          height: 72.w,
          shape: StadiumBorder(),
          elevation: 0,
          minWidth: double.infinity,
          color: Color(0xFFF3F3F3),
          onPressed: () {
            Get.to(BeeSearch());
          },
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 32.w,
                color: Color(0xFF666666),
              ),
              10.wb,
              '搜索商品、活动、帖子、应用'
                  .text
                  .size(28.sp)
                  .color(ktextSubColor)
                  .make()
                  .expand(),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          _buildEditTile(),
          Divider(
            indent: 32.w,
            endIndent: 32.w,
            height: 1.w,
          ).material(color: Colors.white),
          _buildMyApp(),
          32.hb,
          _buildAppList().expand(),
        ],
      ),
    );
  }
}
