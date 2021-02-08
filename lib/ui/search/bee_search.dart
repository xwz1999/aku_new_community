// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:akuCommunity/constants/application_objects.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_back_button.dart';

class BeeSearch extends StatefulWidget {
  BeeSearch({Key key}) : super(key: key);

  @override
  _BeeSearchState createState() => _BeeSearchState();
}

class _BeeSearchState extends State<BeeSearch> {
  TextEditingController _textEditingController = TextEditingController();
  List<AO> get _searchAppObjects {
    if (_textEditingController.text.isEmpty) return [];
    return appObjects
        .where((element) => element.title.contains(_textEditingController.text))
        .toList();
  }

  _renderSearchResultBox(String title, {Widget child, bool visible = true}) {
    if (!visible) return SizedBox().sliverBoxAdapter();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.text.size(28.sp).make(),
        Divider(),
        child,
      ],
    ).p(32.w).material(color: Colors.white).sliverBoxAdapter();
  }

  Widget _buildColumnIcon(AO e) {
    return MaterialButton(
      onPressed: () => Get.to(e.page),
      shape: StadiumBorder(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            e.path,
            height: 75.w,
            width: 75.w,
          ),
          8.hb,
          e.title.text.size(24.sp).make(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BeeBackButton(),
        elevation: 0,
        title: Row(
          children: [
            40.wb,
            Icon(
              Icons.search,
              size: 32.w,
              color: Color(0xFF666666),
            ),
            TextField(
              controller: _textEditingController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                border: InputBorder.none,
                hintText: '搜索商品、活动、帖子、应用',
                hintStyle: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 28.sp,
                ),
              ),
            ).expand(),
          ],
        )
            .box
            .color(Color(0xFFF3F3F3))
            .withRounded(value: 36.w)
            .height(72.w)
            .alignment(Alignment.center)
            .make(),
      ),
      body: EasyRefresh(
        child: CustomScrollView(
          slivers: [
            32.hb.sliverBoxAdapter(),
            _renderSearchResultBox(
              '应用',
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children:
                    _searchAppObjects.map((e) => _buildColumnIcon(e)).toList(),
              ),
              visible: _searchAppObjects.isNotEmpty,
            ),
          ],
        ),
      ),
    );
  }
}
