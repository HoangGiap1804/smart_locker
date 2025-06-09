import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locker History')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<ProductHistory>>(
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

            return ListView.separated(
              itemCount: listHistory.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final history = listHistory[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoHistoryPage(productId: history.id),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.inventory_2,
                            size: 36,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order ID: ${history.orderId}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Deliver: ${formatDateTime(history.createdAt)}',
                                ),
                                Text(
                                  'Receive: ${formatDateTime(history.updatedAt)}',
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
