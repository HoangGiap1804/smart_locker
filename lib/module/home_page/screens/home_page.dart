import 'package:flutter/material.dart';
import 'package:smart_locker/models/order.dart';
import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:smart_locker/module/home_page/screens/face_scan.dart';
import 'package:smart_locker/module/home_page/screens/locker_history_page.dart';
import 'package:smart_locker/module/home_page/widgets/notification_message.dart';
import 'package:smart_locker/module/home_page/widgets/package.dart';
import 'package:smart_locker/repositories/locker_repository.dart';
import 'package:smart_locker/repositories/order_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:smart_locker/services/storage_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Order> listOrder = [];

  @override
  void initState() {
    super.initState();
    loadOrder();
  }

  Future<void> loadOrder() async {
    String? accessToken = await StorageService().getAccessToken();

    if (accessToken != null) {
      List<Order> orders =
          await OrderRepository(ApiService()).getListOrder(accessToken) ?? [];

      setState(() {
        listOrder = orders;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                child: RefreshIndicator(
                  onRefresh: loadOrder,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    children: [
                      Text(
                        "Your Packages",
                        style: AppTheme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (listOrder.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Text(
                              "No orders available at the moment.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listOrder.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final order = listOrder[index];
                            return Package(
                              idOrder: order.orderId,
                              status: order.status,
                              timeDelevery: DateTime.parse(order.createAt),
                              onTap: () async {
                                if (order.status != "confirmed") return;
                                bool verify =
                                    await LockerRepository(
                                      ApiService(),
                                    ).getVerify();
                                if (!mounted) return;
                                if (verify) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => FaceScan(
                                            idPackage: order.orderId,
                                          ),
                                    ),
                                  );
                                } else {
                                  NotificationMessage().notify(
                                    context,
                                    "False",
                                  );
                                }
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
    );
  }
}
