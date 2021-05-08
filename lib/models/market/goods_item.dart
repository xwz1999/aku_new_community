import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_community/model/common/img_model.dart';

part 'goods_item.g.dart';

@JsonSerializable()
class GoodsItem extends Equatable {
  final int id;
  final String title;
  final String recommend;
  final num sellingPrice;
  final num markingPrice;
  final int subscribeNum;
  final List<ImgModel> imgList;
  GoodsItem({
    required this.id,
    required this.title,
    required this.recommend,
    required this.sellingPrice,
    required this.markingPrice,
    required this.subscribeNum,
    required this.imgList,
  });
  @override
  List<Object?> get props => throw UnimplementedError();

  factory GoodsItem.fromJson(Map<String, dynamic> json) =>
      _$GoodsItemFromJson(json);
}
