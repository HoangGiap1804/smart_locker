class LockerHistoryModel {
  final String idOrder;
  final String dateDelivery;
  final String dateReceive;

  LockerHistoryModel({
    required this.idOrder,
    required this.dateDelivery,
    required this.dateReceive,
  });

  static List<LockerHistoryModel> listLockerHistory(int n) {
    List<LockerHistoryModel> list = [];
    for (int i = 0; i < n; ++i) {
      list.add(
        LockerHistoryModel(
          idOrder: "aoio23823rq98faeyf2",
          dateDelivery: "12/10/2025",
          dateReceive: "10/11/2025",
        ),
      );
    }
    return list;
  }
}
