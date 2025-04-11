import 'dart:math';

class LockerModel {
  final String nameLocker;
  final int deliveryDay;

  LockerModel({required this.nameLocker, required this.deliveryDay});

  static List<LockerModel> listLocker(int n) {
    List<LockerModel> list = [];
    Random random = Random();
    for (int i = 0; i < n; ++i) {
      list.add(
        LockerModel(nameLocker: "Locker $i", deliveryDay: random.nextInt(100)),
      );
    }

    return list;
  }
}
