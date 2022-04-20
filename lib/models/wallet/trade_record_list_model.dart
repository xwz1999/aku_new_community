import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'trade_record_list_model.g.dart';

@JsonSerializable()
class TradeRecordListModel extends Equatable {
  final int id;
  final int type;
  final String content;
  final double payAmount;
  final String createName;
  final String createDate;

  factory TradeRecordListModel.fromJson(Map<String, dynamic> json) =>
      _$TradeRecordListModelFromJson(json);


  const TradeRecordListModel({
    required this.id,
    required this.type,
    required this.content,
    required this.payAmount,
    required this.createName,
    required this.createDate,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        content,
        payAmount,
        createName,
        createDate,
      ];
}
