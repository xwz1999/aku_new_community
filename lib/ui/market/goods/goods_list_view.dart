import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/models/market/market_category_model.dart';
import 'package:aku_community/ui/market/search/search_goods_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class GoodsListView extends StatefulWidget {
  final MarketCategoryModel model;
  final MarketCategoryModel? selectSubModel;
  final List<MarketCategoryModel> subModels;
  GoodsListView({
    Key? key,
    required this.model,
    required this.subModels,
    this.selectSubModel,
  }) : super(key: key);

  @override
  _GoodsListViewState createState() => _GoodsListViewState();
}

class _GoodsListViewState extends State<GoodsListView>
    with TickerProviderStateMixin {
  late MarketCategoryModel? _selectModel;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    int initIndex = 0;
    //初始化已选项目
    if (widget.subModels.isNotEmpty) {
      _selectModel = widget.subModels.first;
      if (widget.selectSubModel != null) {
        _selectModel = widget.selectSubModel;
        initIndex = widget.subModels.indexOf(widget.selectSubModel!);
      }
    }

    _tabController = TabController(
      length: widget.subModels.length,
      vsync: this,
      initialIndex: initIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: widget.model.name,
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.search),
          onPressed: () {
            Get.to(() => SearchGoodsPage());
          },
        )
      ],
      appBarBottom: PreferredSize(
        child: SizedBox(
          height: 220.w,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GoodsSubTypeButton(
                model: widget.subModels[index],
                groupValue: _selectModel,
                onTap: () {
                  _selectModel = widget.subModels[index];
                  _tabController.animateTo(index);
                  setState(() {});
                },
              );
            },
            itemCount: widget.subModels.length,
          ),
        ),
        preferredSize: Size.fromHeight(220.w),
      ),
      body: TabBarView(
        children: widget.subModels.map((e) => Text(e.name)).toList(),
        controller: _tabController,
      ),
    );
  }
}

class GoodsSubTypeButton extends StatelessWidget {
  final MarketCategoryModel model;
  final MarketCategoryModel? groupValue;
  final VoidCallback onTap;
  const GoodsSubTypeButton({
    Key? key,
    required this.model,
    required this.groupValue,
    required this.onTap,
  }) : super(key: key);

  bool get same => model == groupValue;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 136.w,
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInImage.assetNetwork(
            image: API.image(ImgModel.first(model.imgList)),
            placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            width: 100.w,
            height: 100.w,
          ),
          20.hb,
          Text(
            model.name,
            style: TextStyle(
              fontSize: 24.sp,
              color: same ? kPrimaryColor : ktextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
