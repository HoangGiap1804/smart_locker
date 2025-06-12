import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_locker/models/order.dart';
import 'package:smart_locker/module/home_page/screens/home_screen.dart';
import 'package:smart_locker/module/home_page/widgets/notification_message.dart';
import 'package:smart_locker/module/profile/profile/widgets/profile_button.dart';
import 'package:smart_locker/repositories/order_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:smart_locker/services/storage_service.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;
  const OrderDetailPage({super.key, required this.order});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  String text = "";
  bool isLoading = false;
  bool set = false;

  void confirmOrder() async {
    NotificationMessage().showConfirmDialog(
      context,
      "Confirm Order",
      "Please review your order details. If everything looks correct, tap OK to confirm.",
      () {},
      () async {
        setState(() => isLoading = true);

        String? accessToken = await StorageService().getAccessToken();
        if (accessToken != null) {
          set = await OrderRepository(
            ApiService(),
          ).confirmOrder(widget.order.orderId, accessToken);
        }
        setState(() {
          isLoading = false;
          text = set ? "SUCCESS" : "FAIL";
          if (set) {
            NotificationMessage().notify(context, "Success");
            Future.delayed(Duration(milliseconds: 2000), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            });
          } else {
            NotificationMessage().notify(context, "False");
            Future.delayed(Duration(milliseconds: 2000), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            });
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(widget.order.createAt).toLocal();
    final formattedTime = DateFormat('HH:mm dd/MM/yyyy').format(dateTime);

    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'pending':
          return Colors.orangeAccent;
        case 'delivered':
          return Colors.green;
        case 'canceled':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Order Detail"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order ID: ${widget.order.orderId}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("Status: ", style: TextStyle(fontSize: 18)),
                        Chip(
                          label: Text(widget.order.status),
                          backgroundColor: getStatusColor(widget.order.status),
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Delivery Time: $formattedTime",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (text.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color:
                      (text == "SUCCESS")
                          ? Colors.greenAccent
                          : Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(text, style: const TextStyle(fontSize: 16)),
              ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : (text.isEmpty)
                ? ProfileButton(onTab: confirmOrder, text: "CONFIRM")
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
