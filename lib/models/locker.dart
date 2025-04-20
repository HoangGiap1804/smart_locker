import 'package:json_annotation/json_annotation.dart';
part 'locker.g.dart';

@JsonSerializable()
class Locker {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "locker_code")
  final String lockerCode;
  @JsonKey(name: "status")
  final String status;

  Locker({required this.id, required this.lockerCode, required this.status});

  factory Locker.fromJson(Map<String, dynamic> json) => _$LockerFromJson(json);
  Map<String, dynamic> toJson() => _$LockerToJson(this);
}
