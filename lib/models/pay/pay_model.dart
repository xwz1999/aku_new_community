import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_model.g.dart';

@JsonSerializable()
class PayModel extends Equatable {
  @JsonKey(name: 'alipay_trade_app_pay_response')
  final AliPayTradeAppPayResponse aliPayTradeAppPayResponse;
  final String sign;
  @JsonKey(name: 'sign_type')
  final String signType;
  PayModel({
    required this.aliPayTradeAppPayResponse,
    required this.sign,
    required this.signType,
  });
  factory PayModel.fromJson(Map<String, dynamic> json) =>
      _$PayModelFromJson(json);
  @override
  List<Object> get props => [aliPayTradeAppPayResponse, sign, signType];
}

@JsonSerializable()
class AliPayTradeAppPayResponse extends Equatable {
  final String code;
  final String msg;
  @JsonKey(name: 'app_id')
  final String appId;
  @JsonKey(name: 'out_trade_no')
  final String outTradeNo;
  @JsonKey(name: 'trade_no')
  final String tradeNo;
  @JsonKey(name: 'total_amount')
  final String totalAmount;
  @JsonKey(name: 'seller_id')
  final String sellerId;
  final String charset;
  final String timestamp;
  AliPayTradeAppPayResponse({
    required this.code,
    required this.msg,
    required this.appId,
    required this.outTradeNo,
    required this.tradeNo,
    required this.totalAmount,
    required this.sellerId,
    required this.charset,
   required  this.timestamp,
  });

  factory AliPayTradeAppPayResponse.fromJson(Map<String, dynamic> json) =>
      _$AliPayTradeAppPayResponseFromJson(json);

  @override
  List<Object> get props {
    return [
      code,
      msg,
      appId,
      outTradeNo,
      tradeNo,
      totalAmount,
      sellerId,
      charset,
      timestamp,
    ];
  }
}
