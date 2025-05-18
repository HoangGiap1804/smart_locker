import 'package:json_annotation/json_annotation.dart';

part 'locker_info.g.dart';

@JsonSerializable()
class LockerInfo {
  final int id;
  @JsonKey(name: 'locker_code')
  final String lockerCode;
  final String status;

  LockerInfo({
    required this.id,
    required this.lockerCode,
    required this.status,
  });

  factory LockerInfo.fromJson(Map<String, dynamic> json) =>
      _$LockerInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LockerInfoToJson(this);
}
