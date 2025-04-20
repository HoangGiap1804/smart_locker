import 'package:flutter/material.dart';
import 'package:smart_locker/models/order.dart';
import 'package:smart_locker/module/home_page/screens/order_detail_page.dart';
import 'package:smart_locker/module/home_page/widgets/search_field.dart';
import 'package:smart_locker/module/profile/profile/widgets/profile_button.dart';
import 'package:smart_locker/repositories/order_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:smart_locker/services/storage_service.dart';

class SearchPackagePage extends StatefulWidget {
  const SearchPackagePage({super.key});

  @override
  State<SearchPackagePage> createState() => _SearchPackagePageState();
}

class _SearchPackagePageState extends State<SearchPackagePage> {
  TextEditingController controller = TextEditingController();
  String text = "";
  bool isLoading = false;

  void searchOrder() async {
    setState(() {
      isLoading = true;
    });
    String? accessToken = await StorageService().getAccessToken();

    Order? order;
    if (accessToken != null) {
      order = await OrderRepository(
        ApiService(),
      ).searchOrder(controller.text, accessToken);
    }
    setState(() {
      isLoading = false;
      if (order != null) {
        text = "Success";
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailPage(order: order!),
          ),
        );
      } else {
        text = "Fail";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SearchField(controller: controller),
          (text.isEmpty) ? SizedBox() : Text(text),
          (isLoading)
              ? CircularProgressIndicator()
              : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ProfileButton(
                  onTab: () {
                    searchOrder();
                  },
                  text: "FIND",
                ),
              ),
        ],
      ),
    );
  }
}
