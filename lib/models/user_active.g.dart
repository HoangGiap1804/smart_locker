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
    );

Map<String, dynamic> _$UserActiveToJson(UserActive instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'is_active': instance.isActive,
    };
