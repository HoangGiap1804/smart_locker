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
  final TextEditingController controller = TextEditingController();
  String resultMessage = "";
  bool isLoading = false;

  Future<void> searchOrder() async {
    FocusScope.of(context).unfocus(); // Dismiss keyboard

    setState(() {
      isLoading = true;
      resultMessage = "";
    });

    String? accessToken = await StorageService().getAccessToken();

    if (accessToken != null) {
      final order = await OrderRepository(
        ApiService(),
      ).searchOrder(controller.text.trim(), accessToken);

      setState(() {
        isLoading = false;
        if (order != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailPage(order: order),
            ),
          );
        } else {
          resultMessage = "No order found with that ID.";
        }
      });
    } else {
      setState(() {
        isLoading = false;
        resultMessage = "Authentication failed. Please log in again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter your order ID to search:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          SearchField(controller: controller),
          const SizedBox(height: 12),
          if (resultMessage.isNotEmpty)
            Text(
              resultMessage,
              style: TextStyle(
                color:
                    resultMessage.contains("No order") ||
                            resultMessage.contains("Authentication")
                        ? Colors.red
                        : Colors.green,
                fontSize: 14,
              ),
            ),
          const SizedBox(height: 24),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                width: double.infinity,
                child: ProfileButton(text: "SEARCH", onTab: searchOrder),
              ),
        ],
      ),
    );
  }
}
