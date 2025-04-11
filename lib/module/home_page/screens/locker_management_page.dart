import 'package:flutter/material.dart';
import 'package:smart_locker/models/locker_history_model.dart';
import 'package:smart_locker/models/locker_model.dart';
import 'package:smart_locker/module/home_page/screens/locker_history_page.dart';

class LockerManagementPage extends StatefulWidget {
  const LockerManagementPage({super.key});

  @override
  State<LockerManagementPage> createState() => _LockerManagementPageState();
}

class _LockerManagementPageState extends State<LockerManagementPage> {
  @override
  Widget build(BuildContext context) {
    List<LockerModel> listLocker = LockerModel.listLocker(30);
    return Center(
      child: GridView.count(
        crossAxisCount: 3, // Số cột
        children: List.generate(listLocker.length, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LockerHistoryPage()),
              );
            },
            child: Card(
              color:
                  (listLocker[index].deliveryDay < 30)
                      ? Colors.green
                      : (listLocker[index].deliveryDay < 60)
                      ? Colors.amber
                      : Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    listLocker[index].nameLocker,
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "${listLocker[index].deliveryDay.toString()} days",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
