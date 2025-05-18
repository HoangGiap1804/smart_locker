// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locker_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LockerInfo _$LockerInfoFromJson(Map<String, dynamic> json) => LockerInfo(
      id: (json['id'] as num).toInt(),
      lockerCode: json['locker_code'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$LockerInfoToJson(LockerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'locker_code': instance.lockerCode,
      'status': instance.status,
    };
