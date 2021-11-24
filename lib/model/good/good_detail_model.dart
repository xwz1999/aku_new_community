class GoodDetailModel {
  List<GoodsDetailImageVos>? goodsDetailImageVos;
  double? sellPrice;
  double? discountPrice;
  String? skuName;
  int? sellNum;
  int? kind;
  String? defaultLocation;
  String? defaultAddressDetail;
  int? stockStatus;
  List<GoodsDetailSpecificationVoList>? goodsDetailSpecificationVoList;
  int? isCollection;

  GoodDetailModel(
      {this.goodsDetailImageVos,
        this.sellPrice,
        this.discountPrice,
        this.skuName,
        this.sellNum,
        this.kind,
        this.defaultLocation,
        this.defaultAddressDetail,
        this.stockStatus,
        this.goodsDetailSpecificationVoList,
        this.isCollection});

  factory GoodDetailModel.fail() => GoodDetailModel(goodsDetailImageVos: [],sellPrice: 0,discountPrice: 0,skuName: '',
  sellNum: 0,kind: 0,defaultLocation: '',defaultAddressDetail: '',stockStatus: 0,goodsDetailSpecificationVoList: [],isCollection: 0
  );

  GoodDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['goodsDetailImageVos'] != null) {
      goodsDetailImageVos = [];
      json['goodsDetailImageVos'].forEach((v) {
        goodsDetailImageVos!.add(new GoodsDetailImageVos.fromJson(v));
      });
    } else
      goodsDetailImageVos = [];

    sellPrice = json['sellPrice'];
    discountPrice = json['discountPrice'];
    skuName = json['skuName'];
    sellNum = json['sellNum'];
    kind = json['kind'];
    defaultLocation = json['defaultLocation'];
    defaultAddressDetail = json['defaultAddressDetail'];
    stockStatus = json['stockStatus'];

    if (json['goodsDetailSpecificationVoList'] != null) {
      goodsDetailSpecificationVoList = [];
      json['goodsDetailSpecificationVoList'].forEach((v) {
        goodsDetailSpecificationVoList!.add(new GoodsDetailSpecificationVoList.fromJson(v));
      });
    } else
      goodsDetailSpecificationVoList = [];

    isCollection = json['isCollection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goodsDetailImageVos != null) {
      data['goodsDetailImageVos'] =
          this.goodsDetailImageVos!.map((v) => v.toJson()).toList();
    }
    data['sellPrice'] = this.sellPrice;
    data['discountPrice'] = this.discountPrice;
    data['skuName'] = this.skuName;
    data['sellNum'] = this.sellNum;
    data['kind'] = this.kind;
    data['defaultLocation'] = this.defaultLocation;
    data['defaultAddressDetail'] = this.defaultAddressDetail;
    data['stockStatus'] = this.stockStatus;
    if (this.goodsDetailSpecificationVoList != null) {
      data['goodsDetailSpecificationVoList'] =
          this.goodsDetailSpecificationVoList!.map((v) => v.toJson()).toList();
    }
    data['isCollection'] = this.isCollection;
    return data;
  }
}

class GoodsDetailImageVos {
  int? id;
  int? jcookGoodsId;
  String? url;
  int? isPrimer;
  int? orderSort;

  GoodsDetailImageVos(
      {this.id, this.jcookGoodsId, this.url, this.isPrimer, this.orderSort});

  GoodsDetailImageVos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jcookGoodsId = json['jcookGoodsId'];
    url = json['url'];
    isPrimer = json['isPrimer'];
    orderSort = json['orderSort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jcookGoodsId'] = this.jcookGoodsId;
    data['url'] = this.url;
    data['isPrimer'] = this.isPrimer;
    data['orderSort'] = this.orderSort;
    return data;
  }
}

class GoodsDetailSpecificationVoList {
  String? groupName;
  List<Attribute>? attribute;

  GoodsDetailSpecificationVoList({this.groupName, this.attribute});

  GoodsDetailSpecificationVoList.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];

    if (json['attribute'] != null) {
      attribute = [];
      json['attribute'].forEach((v) {
        attribute!.add(new Attribute.fromJson(v));
      });
    } else
      attribute = [];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attribute {
  String? name;
  String? value;

  Attribute({this.name, this.value});

  Attribute.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}