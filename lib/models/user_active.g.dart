// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_active.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActive _$UserActiveFromJson(Map<String, dynamic> json) => UserActive(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      isActive: json['is_active'] as bool,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$UserActiveToJson(UserActive instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'full_name': instance.fullName,
      'phone': instance.phone,
      'is_active': instance.isActive,
    };
