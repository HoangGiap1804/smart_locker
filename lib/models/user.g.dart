// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['user_id'] as num?)?.toInt() ?? 0,
      userName: json['username'] as String,
      fullName: json['fullname'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone'] as String,
      gender: json['gender'] as String,
      isAdmin: json['is_admin'] as bool? ?? false,
      password: json['password'] as String? ?? "",
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.id,
      'username': instance.userName,
      'fullname': instance.fullName,
      'email': instance.email,
      'phone': instance.phoneNumber,
      'gender': instance.gender,
      'password': instance.password,
      'is_admin': instance.isAdmin,
    };
