// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locker _$LockerFromJson(Map<String, dynamic> json) => Locker(
      id: (json['id'] as num).toInt(),
      lockerCode: json['locker_code'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$LockerToJson(Locker instance) => <String, dynamic>{
      'id': instance.id,
      'locker_code': instance.lockerCode,
      'status': instance.status,
    };
