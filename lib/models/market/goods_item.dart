import 'package:aku_new_community/model/common/img_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

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

  factory GoodsItem.example() => GoodsItem(
      id: 0,
      title: '华为mate30',
      recommend: '九成新，无磨损',
      sellingPrice: 1000,
      markingPrice: 2000,
      subscribeNum: 0,
      imgList: []);

  @override
  List<Object?> get props => throw UnimplementedError();

  factory GoodsItem.fromJson(Map<String, dynamic> json) =>
      _$GoodsItemFromJson(json);
}
