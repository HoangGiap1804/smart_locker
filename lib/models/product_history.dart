import 'package:json_annotation/json_annotation.dart';

part 'product_history.g.dart';

@JsonSerializable()
class ProductHistory {
  final int id;

  @JsonKey(name: 'order_id')
  final String orderId;

  final String status;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  ProductHistory({
    required this.id,
    required this.orderId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductHistory.fromJson(Map<String, dynamic> json) =>
      _$ProductHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductHistoryToJson(this);
}
