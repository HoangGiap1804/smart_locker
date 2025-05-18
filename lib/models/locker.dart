import 'package:json_annotation/json_annotation.dart';
import 'product.dart';

part 'locker.g.dart';

@JsonSerializable()
class Locker {
  final int id;

  @JsonKey(name: 'locker_code')
  final String lockerCode;

  final String status;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  final Product? product;
  final int? days;

  Locker({
    required this.id,
    required this.lockerCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.days,
  });

  factory Locker.fromJson(Map<String, dynamic> json) => _$LockerFromJson(json);
  Map<String, dynamic> toJson() => _$LockerToJson(this);
}
