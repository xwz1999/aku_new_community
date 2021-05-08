import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_community/models/market/display_category_model.dart';
import 'package:aku_community/models/market/market_category_model.dart';
import 'package:aku_community/ui/market/category/category_sub_card.dart';

class CategorySubView extends StatefulWidget {
  final MarketCategoryModel model;
  CategorySubView({Key? key, required this.model}) : super(key: key);

  @override
  _CategorySubViewState createState() => _CategorySubViewState();
}

class _CategorySubViewState extends State<CategorySubView> {
  List<MarketCategoryModel> _models = [];
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: MaterialHeader(),
      firstRefresh: true,
      onRefresh: () async {
        _models = await DisplayCategoryModel.fetchCategory(widget.model.id);
        setState(() {});
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          final model = _models[index];
          return CategorySubCard(
            model: widget.model,
            selectModel: model,
            subModels: _models,
          );
        },
        itemCount: _models.length,
      ),
    );
  }
}
