class ImgModel {
  String url;
  String size;
  double longs;
  double paragraph;
  int sort;
  double get aspect => paragraph / longs;

  ImgModel({this.url, this.size, this.longs, this.paragraph, this.sort});

  ImgModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    size = json['size'];
    longs = json['longs'] + .0;
    paragraph = json['paragraph'] + .0;
    sort = json['sort'];
  }

  static String first(List<ImgModel> models) {
    if (models == null) return '';
    if (models.isEmpty) return '';
    return models.first.url ?? '';
  }

  static ImgModel firstModel(List<ImgModel> models) {
    if (models == null) return null;
    if (models.isEmpty) return null;
    return models.first;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['size'] = this.size;
    data['longs'] = this.longs;
    data['paragraph'] = this.paragraph;
    data['sort'] = this.sort;
    return data;
  }
}
