import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  bool showConfirmed = true;
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
    final confirmedOrders =
    listOrder.where((order) => order.status == "confirmed").toList();
    final unconfirmedOrders =
    listOrder.where((order) => order.status != "confirmed").toList();
    final displayedList = showConfirmed ? confirmedOrders : unconfirmedOrders;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showConfirmed = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      showConfirmed
                      ? Colors.blue
                      : Colors.grey[300],
                      foregroundColor:
                      showConfirmed ? Colors.white : Colors.black87,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: showConfirmed ? 4 : 0,
                    ),
                    child: const Text(
                      "Confirmed",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showConfirmed = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      !showConfirmed
                      ? Colors.blue
                      : Colors.grey[300],
                      foregroundColor:
                      !showConfirmed
                      ? Colors.white
                      : Colors.black87,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: !showConfirmed ? 4 : 0,
                    ),
                    child: const Text(
                      "Picked up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (displayedList.isEmpty)
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
                itemCount: displayedList.length,
                separatorBuilder:
              (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final order = displayedList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Package(
                          idOrder: order.orderId,
                          status: order.status,
                          timeDelevery: DateTime.parse(order.createAt),
                        ),
                        const SizedBox(height: 8),
                        if(showConfirmed)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                // Thay thế bằng chức năng tương ứng
                              },
                              icon: const Icon(Icons.window),
                              label: const Text("Window"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                NotificationMessage().showConfirmDialog(
                                  context,
                                  "Open Locker Confirmation",
                                  "Press OK to scan your face and open the locker.",
                                  (){},
                                  ()async{
                                    if (order.status != "confirmed") return;

                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );

                                    bool verify = await LockerRepository(ApiService()).getVerify();

                                    // Đóng dialog loading
                                    if (context.mounted) Navigator.of(context).pop();

                                    if (!context.mounted) return;

                                    if (verify) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FaceScan(
                                            idPackage: order.orderId,
                                          ),
                                        ),
                                    );
                                    } else {
                                      NotificationMessage().notify(context, "False");
                                    }
                                  } 
                                );
                              },
                              icon: const Icon(Icons.camera_alt),
                              label: const Text("Scan Face"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
