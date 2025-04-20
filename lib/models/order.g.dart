// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num).toInt(),
      orderId: json['order_id'] as String,
      status: json['status'] as String,
      createAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      user_id: (json['user'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'status': instance.status,
      'created_at': instance.createAt,
      'updated_at': instance.updatedAt,
      'user': instance.user_id,
    };
