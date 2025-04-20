import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_locker/models/shared/app_theme.dart';

class Package extends StatelessWidget {
  final String idOrder;
  final String status;
  final DateTime timeDelevery;
  const Package({
    super.key,
    required this.idOrder,
    required this.status,
    required this.timeDelevery,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.lock, size: 40,),
      isThreeLine: true,
      title: Text(
        "ID: ${idOrder}",
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Delevery: ${DateFormat('yyyy/MM/dd - kk:mm').format(timeDelevery)}"),
          Text("Status: ${status}")
        ],
      )
    );
  }
}
