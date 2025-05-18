// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_history_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductHistoryDetail _$ProductHistoryDetailFromJson(
        Map<String, dynamic> json) =>
    ProductHistoryDetail(
      id: (json['id'] as num).toInt(),
      orderId: json['order_id'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      status: json['status'] as String,
      lockerInfo:
          LockerInfo.fromJson(json['locker_info'] as Map<String, dynamic>),
      videoPath: json['video_path'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ProductHistoryDetailToJson(
        ProductHistoryDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'user': instance.user,
      'status': instance.status,
      'locker_info': instance.lockerInfo,
      'video_path': instance.videoPath,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
