import 'package:aku_community/model/common/img_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'goods_detail_model.g.dart';

@JsonSerializable()
class GoodsDetailModel extends Equatable {
  final int id;
  final String recommend;
  final String title;
  final double sellingPrice;
  final double markingPrice;
  final String categoryName;
  final int subscribeNum;
  final String detail;
  final String arrivalTime;
  final List<ImgModel> goodsImgList;
  final int supplierId;
  final String supplierName;
  final String supplierTel;
  final String? supplierAddress;
  final List<ImgModel> supplierImgList;
  final int isSubscribe;

  GoodsDetailModel(
      this.id,
      this.recommend,
      this.title,
      this.sellingPrice,
      this.markingPrice,
      this.categoryName,
      this.subscribeNum,
      this.detail,
      this.arrivalTime,
      this.goodsImgList,
      this.supplierId,
      this.supplierName,
      this.supplierTel,
      this.supplierAddress,
      this.supplierImgList,
      this.isSubscribe);

  @override
  List<Object?> get props => throw UnimplementedError();

  factory GoodsDetailModel.fromJson(Map<String, dynamic> json) =>
      _$GoodsDetailModelFromJson(json);
}
