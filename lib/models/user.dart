import 'package:camera/camera.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "user_id")
  final int id;
  @JsonKey(name: "username")
  final String userName;
  @JsonKey(name: "fullname")
  final String fullName;
  final String email;
  @JsonKey(name: "phone")
  final String phoneNumber;
  final String gender;
  final String password;
  final XFile? picture;

  User({
    this.id = 0,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    this.password = "",
    this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
