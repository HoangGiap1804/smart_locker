import 'package:flutter/material.dart';
import 'package:smart_locker/models/order.dart';
import 'package:smart_locker/module/profile/profile/widgets/profile_button.dart';
import 'package:smart_locker/repositories/order_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:smart_locker/services/storage_service.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;
  const OrderDetailPage({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  String text = "";
  bool isLoading = false;
  bool set = false;

  void confirmOrder() async {
    setState(() {
      isLoading = true;
    });
    String? accessToken = await StorageService().getAccessToken();

    if (accessToken != null) {
      set = await OrderRepository(
        ApiService(),
      ).confirmOrder(widget.order.orderId, accessToken);
    }
    setState(() {
      isLoading = false;
      if (set) {
        text = "Success";
      } else {
        text = "Fail";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Detail")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ID Order: ${widget.order.orderId}"),
              Text("Status: ${widget.order.status}"),
              Text("Time delevely: ${widget.order.createAt}"),
              (text.isEmpty) ? SizedBox() : Text(text),
              (isLoading)
              ? CircularProgressIndicator()
              : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ProfileButton(
                  onTab: () {
                    confirmOrder();
                  },
                  text: "CONFIRM",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


