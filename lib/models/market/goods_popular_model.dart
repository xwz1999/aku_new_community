class GoodsPopularModel {
  int? id;
  String? skuName;
  String? mainPhoto;
  int? viewsNum;

  GoodsPopularModel({this.id, this.skuName, this.mainPhoto, this.viewsNum});

  GoodsPopularModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuName = json['skuName'];
    mainPhoto = json['mainPhoto'];
    viewsNum = json['viewsNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['skuName'] = this.skuName;
    data['mainPhoto'] = this.mainPhoto;
    data['viewsNum'] = this.viewsNum;
    return data;
  }
}