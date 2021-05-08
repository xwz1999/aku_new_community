import 'package:aku_community/models/market/display_category_model.dart';
import 'package:aku_community/models/market/market_category_model.dart';
import 'package:aku_community/ui/market/category/category_sub_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CategorySubView extends StatefulWidget {
  final int id;
  CategorySubView({Key? key, required this.id}) : super(key: key);

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
        _models = await DisplayCategoryModel.fetchCategory(widget.id);
        setState(() {});
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          final model = _models[index];
          return CategorySubCard(model: model);
        },
        itemCount: _models.length,
      ),
    );
  }
}
