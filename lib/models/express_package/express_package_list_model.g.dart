// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'express_package_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpressPackageListModel _$ExpressPackageListModelFromJson(
        Map<String, dynamic> json) =>
    ExpressPackageListModel(
      id: json['id'] as int,
      code: json['code'] as String,
      addresseeName: json['addresseeName'] as String,
      addresseeTel: json['addresseeTel'] as String,
      address: json['address'] as String,
      status: json['status'] as int,
      receiveDate: json['receiveDate'] as String?,
      createDate: json['createDate'] as String,
      placePosition: json['placePosition'] as String,
    );
