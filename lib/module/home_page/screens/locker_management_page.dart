import 'package:flutter/material.dart';
import 'package:smart_locker/models/locker.dart';
import 'package:smart_locker/module/home_page/screens/locker_history_page.dart';
import 'package:smart_locker/repositories/locker_repository.dart';
import 'package:smart_locker/services/api_service.dart';

class LockerManagementPage extends StatefulWidget {
  const LockerManagementPage({super.key});

  @override
  State<LockerManagementPage> createState() => _LockerManagementPageState();
}

class _LockerManagementPageState extends State<LockerManagementPage> {
  late Future<List<Locker>> futureLockers;

  @override
  void initState() {
    super.initState();
    futureLockers = LockerRepository(ApiService()).fetchLockers();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Locker>>(
        future: futureLockers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text("No lockers found.");
          }

          final listLocker = snapshot.data!;

          return GridView.count(
            crossAxisCount: 3,
            children: List.generate(listLocker.length, (index) {
              final locker = listLocker[index];
              final days = locker.days;

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LockerHistoryPage(lockerId: listLocker[index].id),
                    ),
                  );
                },
                child: Card(
                  color:
                      (days == null)
                          ? Colors.grey
                          : (days < 30)
                          ? Colors.green
                          : (days < 60)
                          ? Colors.amber
                          : Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        locker.lockerCode,
                        style: const TextStyle(fontSize: 17),
                      ),
                      Text(
                        (days == null) ? "Empty" : "$days days",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
