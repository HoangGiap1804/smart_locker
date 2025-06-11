import 'package:json_annotation/json_annotation.dart';

part 'user_active.g.dart';

@JsonSerializable()
class UserActive {
  final int id;
  final String username;
  final String email;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String phone;
  @JsonKey(name: 'is_active')
  final bool isActive;

  UserActive({
    required this.id,
    required this.username,
    required this.email,
    required this.isActive,
    required this.fullName,
    required this.phone,
  });

  factory UserActive.fromJson(Map<String, dynamic> json) =>
      _$UserActiveFromJson(json);
  Map<String, dynamic> toJson() => _$UserActiveToJson(this);
}
