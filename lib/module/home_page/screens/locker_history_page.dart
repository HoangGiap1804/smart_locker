import 'package:flutter/material.dart';
import 'package:smart_locker/models/locker_history_model.dart';
import 'package:smart_locker/module/home_page/screens/video_history_page.dart';

class LockerHistoryPage extends StatefulWidget {
  const LockerHistoryPage({super.key});

  @override
  State<LockerHistoryPage> createState() => _LockerHistoryPageState();
}

class _LockerHistoryPageState extends State<LockerHistoryPage> {
  @override
  Widget build(BuildContext context) {
    List<LockerHistoryModel> listHistory = LockerHistoryModel.listLockerHistory(
      20,
    );
    return Scaffold(
      body: ListView.builder(
        itemCount: listHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideoHistoryPage()),
              );
            },
            title: Text('ID order: ${listHistory[index].idOrder}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date delivery: ${listHistory[index].dateDelivery}'),
                Text('Date receive: ${listHistory[index].dateReceive}'),
              ],
            ),
            isThreeLine: true,
          );
        },
      )
    );
  }
}
