import 'package:flutter/material.dart';
import 'package:smart_locker/models/product_history.dart';
import 'package:smart_locker/module/home_page/screens/video_history_page.dart';
import 'package:smart_locker/repositories/locker_repository.dart';
import 'package:smart_locker/services/api_service.dart';

class LockerHistoryPage extends StatefulWidget {
  final int lockerId;

  const LockerHistoryPage({super.key, required this.lockerId});

  @override
  State<LockerHistoryPage> createState() => _LockerHistoryPageState();
}

class _LockerHistoryPageState extends State<LockerHistoryPage> {
  late Future<List<ProductHistory>> futureHistory;

  @override
  void initState() {
    super.initState();
    futureHistory = LockerRepository(
      ApiService(),
    ).fetchHistory(widget.lockerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locker History')),
      body: FutureBuilder<List<ProductHistory>>(
        future: futureHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final listHistory = snapshot.data ?? [];

          if (listHistory.isEmpty) {
            return const Center(child: Text("No history found."));
          }

          return ListView.builder(
            itemCount: listHistory.length,
            itemBuilder: (context, index) {
              final history = listHistory[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => VideoHistoryPage(
                            productId: listHistory[index].id,
                          ),
                    ),
                  );
                },
                title: Text('Order ID: ${history.orderId}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Created at: ${history.createdAt.toLocal()}'),
                    Text('Updated at: ${history.updatedAt.toLocal()}'),
                  ],
                ),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}
