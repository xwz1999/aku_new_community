import 'package:flutter/material.dart';

import 'package:aku_new_community/models/market/market_all_category_model.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'new_category_sub_card.dart';

class NewCategorySubView extends StatefulWidget {
  final MarketAllCategoryModel model;

  NewCategorySubView({Key? key, required this.model}) : super(key: key);

  @override
  _NewCategorySubViewState createState() => _NewCategorySubViewState();
}

class _NewCategorySubViewState extends State<NewCategorySubView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        return _SecondCard(widget.model.categoryList[index]);
      },
      itemCount: widget.model.categoryList.length,
    );
  }

  _SecondCard(MarketAllCategoryModel item) {
    return Container(
      padding: EdgeInsets.only(top: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.w)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              20.wb,
              Text(
                item.name ?? '',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(0xFF333333),
                ),
              ),
              Spacer()
            ],
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return NewCategorySubCard(
                subModels: item.categoryList[index],
              );
            },
            itemCount: item.categoryList.length,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
