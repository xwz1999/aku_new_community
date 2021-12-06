import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/market/display_category_model.dart';
import 'package:aku_new_community/models/market/market_category_model.dart';
import 'package:aku_new_community/ui/market/goods/goods_list_view.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  final MarketCategoryModel model;

  const CategoryCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Column(
        children: [
          Spacer(),
          FadeInImage.assetNetwork(
            image: API.image(ImgModel.first(model.imgList)),
            placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            height: 75.w,
            width: 75.w,
          ),
          12.hb,
          Text(
            model.name,
            style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xFF4A4B51),
            ),
          ),
          Spacer(),
        ],
      ),
      onPressed: () async {
        final cancel = BotToast.showLoading();
        List<MarketCategoryModel> models =
            await DisplayCategoryModel.fetchCategory(model.id);
        cancel();
        Get.to(() => GoodsListView(
              model: model,
              subModels: models,
            ));
      },
    );
  }
}
