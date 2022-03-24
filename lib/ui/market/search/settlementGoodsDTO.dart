class SettlementGoodsDTO {
  int? appGoodsPushId;
  int? num;

  SettlementGoodsDTO({
    this.appGoodsPushId,
    this.num,
  });

  SettlementGoodsDTO.fromJson(Map<String, dynamic> json) {
    appGoodsPushId = json['appGoodsPushId'];
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appGoodsPushId'] = this.appGoodsPushId;
    data['num'] = this.num;

    return data;
  }
}
