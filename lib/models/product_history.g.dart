// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductHistory _$ProductHistoryFromJson(Map<String, dynamic> json) =>
    ProductHistory(
      id: (json['id'] as num).toInt(),
      orderId: json['order_id'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ProductHistoryToJson(ProductHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
