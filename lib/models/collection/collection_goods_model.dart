class CollectionGoodsModel {
  int? id;
  String? skuName;
  String? mainPhoto;
  int? status;
  int? shopStatus;
  double? sellPrice;
  double? discountPrice;
  int? kind;

  CollectionGoodsModel(
      {this.id,
      this.skuName,
      this.mainPhoto,
      this.status,
      this.shopStatus,
      this.sellPrice,
      this.discountPrice,
      this.kind});

  CollectionGoodsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuName = json['skuName'];
    mainPhoto = json['mainPhoto'];
    status = json['status'];
    shopStatus = json['shopStatus'];
    sellPrice = json['sellPrice'];
    discountPrice = json['discountPrice'];
    kind = json['kind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['skuName'] = this.skuName;
    data['mainPhoto'] = this.mainPhoto;
    data['status'] = this.status;
    data['shopStatus'] = this.shopStatus;
    data['sellPrice'] = this.sellPrice;
    data['discountPrice'] = this.discountPrice;
    data['kind'] = this.kind;
    return data;
  }
}
