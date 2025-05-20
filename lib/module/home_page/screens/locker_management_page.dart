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

  Color getLockerColor(int? days) {
    if (days == null) return Colors.grey;
    if (days < 30) return Colors.green;
    if (days < 60) return Colors.amber;
    return Colors.red;
  }

  IconData getLockerIcon(int? days) {
    if (days == null) return Icons.lock_open;
    return Icons.lock;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: FutureBuilder<List<Locker>>(
        future: futureLockers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No lockers found."));
          }

          final listLocker = snapshot.data!;

          return GridView.builder(
            itemCount: listLocker.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final locker = listLocker[index];
              final days = locker.days;
              final color = getLockerColor(days);
              final icon = getLockerIcon(days);

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LockerHistoryPage(lockerId: locker.id),
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 32, color: Colors.white),
                      const SizedBox(height: 5),
                      Text(
                        locker.lockerCode,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        days == null ? "Empty" : "$days days",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
