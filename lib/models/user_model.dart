import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String username;
  final String email;
  final String fullname;
  final String phone;
  final String gender;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.fullname,
    required this.phone,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
