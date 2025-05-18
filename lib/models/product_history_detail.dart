import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';
import 'locker_info.dart';

part 'product_history_detail.g.dart';

@JsonSerializable()
class ProductHistoryDetail {
  final int id;
  @JsonKey(name: 'order_id')
  final String orderId;
  final UserModel user;
  final String status;
  @JsonKey(name: 'locker_info')
  final LockerInfo lockerInfo;
  @JsonKey(name: 'video_path')
  final String? videoPath;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  ProductHistoryDetail({
    required this.id,
    required this.orderId,
    required this.user,
    required this.status,
    required this.lockerInfo,
    this.videoPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductHistoryDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductHistoryDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ProductHistoryDetailToJson(this);
}
