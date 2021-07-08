// class LifePayModel {
//   int? years;
//   int? paymentNum;
//   List<DailyPaymentTypeVos>? dailyPaymentTypeVos;

//   LifePayModel({this.years, this.paymentNum, this.dailyPaymentTypeVos});

//   LifePayModel.fromJson(Map<String, dynamic> json) {
//     years = json['years'];
//     paymentNum = json['paymentNum'];
//     if (json['dailyPaymentTypeVos'] != null) {
//       dailyPaymentTypeVos = [];
//       json['dailyPaymentTypeVos'].forEach((v) {
//         dailyPaymentTypeVos!.add(new DailyPaymentTypeVos.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['years'] = this.years;
//     data['paymentNum'] = this.paymentNum;
//     if (this.dailyPaymentTypeVos != null) {
//       data['dailyPaymentTypeVos'] =
//           this.dailyPaymentTypeVos!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }

// }

// class DailyPaymentTypeVos {
//   int? id;
//   String? name;
//   List<DetailedVoList>? detailedVoList;

//   DailyPaymentTypeVos({this.id, this.name, this.detailedVoList});

//   DailyPaymentTypeVos.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     if (json['detailedVoList'] != null) {
//       detailedVoList = [];
//       json['detailedVoList'].forEach((v) {
//         detailedVoList!.add(new DetailedVoList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     if (this.detailedVoList != null) {
//       data['detailedVoList'] =
//           this.detailedVoList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class DetailedVoList {
//   int? groupId;
//   double? paymentPrice;
//   List<DetailsVoList>? detailsVoList;

//   DetailedVoList({this.groupId, this.paymentPrice, this.detailsVoList});

//   DetailedVoList.fromJson(Map<String, dynamic> json) {
//     groupId = json['groupId'];
//     paymentPrice = json['paymentPrice'];
//     if (json['detailsVoList'] != null) {
//       detailsVoList = [];
//       json['detailsVoList'].forEach((v) {
//         detailsVoList!.add(new DetailsVoList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['groupId'] = this.groupId;
//     data['paymentPrice'] = this.paymentPrice;
//     if (this.detailsVoList != null) {
//       data['detailsVoList'] =
//           this.detailsVoList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class DetailsVoList {
//   int? id;
//   String? month;
//   double? costPrice;
//   double? paidPrice;
//   double? totalPrice;
//   String? beginDate;
//   String? endDate;
//   String? unitPriceType;
//   int? num;

//   DetailsVoList(
//       {this.id,
//       this.month,
//       this.costPrice,
//       this.paidPrice,
//       this.totalPrice,
//       this.beginDate,
//       this.endDate,
//       this.unitPriceType,
//       this.num});

//   DetailsVoList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     month = json['month'];
//     costPrice = json['costPrice'];
//     paidPrice = json['paidPrice'];
//     totalPrice = json['totalPrice'];
//     beginDate = json['beginDate'];
//     endDate = json['endDate'];
//     unitPriceType = json['unitPriceType'];
//     num = json['num'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['month'] = this.month;
//     data['costPrice'] = this.costPrice;
//     data['paidPrice'] = this.paidPrice;
//     data['totalPrice'] = this.totalPrice;
//     data['beginDate'] = this.beginDate;
//     data['endDate'] = this.endDate;
//     data['unitPriceType'] = this.unitPriceType;
//     data['num'] = this.num;
//     return data;
//   }
// }
