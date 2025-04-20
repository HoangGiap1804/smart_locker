import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "order_id")
  final String orderId;
  @JsonKey(name: "status")
  final String status;
  // @JsonKey(name: "video_path")
  // final String videoPath;
  @JsonKey(name: "created_at")
  final String createAt;
  @JsonKey(name: "updated_at")
  final String updatedAt;
  @JsonKey(name: "user")
  final int? user_id;

  Order({
    required this.id,
    required this.orderId,
    required this.status,
    // required this.videoPath,
    required this.createAt,
    required this.updatedAt,
    required this.user_id,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
