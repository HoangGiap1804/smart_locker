import 'dart:math';

import 'package:flutter/widgets.dart';

class UserModel {
  final String name;
  final String phoneNumber;
  final Image image;
  final bool paid;

  UserModel({
    required this.name,
    required this.phoneNumber,
    required this.image,
    required this.paid,
  });

  static List<UserModel> listUser(int n) {
    List<UserModel> list = [];
    Random random = Random();

    for (int i = 0; i < n; ++i) {
      list.add(
        UserModel(
          name: "Nguyen Van A",
          phoneNumber: "0923987487",
          image: Image.asset("assets/images/avata.png"),
          paid: random.nextBool(),
        ),
      );
    }
    return list;
  }
}
