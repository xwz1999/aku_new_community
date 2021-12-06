class SearchGoodsModel {
  int? id;
  String? skuName;
  String? mainPhoto;
  double? sellPrice;
  double? discountPrice;
  int? kind;
  int? isCollection;

  SearchGoodsModel(
      {this.id,
      this.skuName,
      this.mainPhoto,
      this.sellPrice,
      this.discountPrice,
      this.kind,
      this.isCollection});

  SearchGoodsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuName = json['skuName'];
    mainPhoto = json['mainPhoto'];
    sellPrice = json['sellPrice'];
    discountPrice = json['discountPrice'];
    kind = json['kind'];
    isCollection = json['isCollection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['skuName'] = this.skuName;
    data['mainPhoto'] = this.mainPhoto;
    data['sellPrice'] = this.sellPrice;
    data['discountPrice'] = this.discountPrice;
    data['kind'] = this.kind;
    data['isCollection'] = this.isCollection;
    return data;
  }
}
