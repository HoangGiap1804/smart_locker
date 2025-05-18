import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;

  @JsonKey(name: 'order_id')
  final String orderId;

  @JsonKey(name: 'user')
  final int? userId;
  final String status;

  @JsonKey(name: 'video_path')
  final String? videoPath;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  Product({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.status,
    this.videoPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
