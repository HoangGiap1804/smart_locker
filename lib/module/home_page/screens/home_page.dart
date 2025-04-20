import 'package:smart_locker/models/order.dart';
import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:smart_locker/module/home_page/widgets/package.dart';
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

  void loadOrder() async {
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
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Your Packages", style: AppTheme.textTheme.headlineMedium),
            Column(
              children:[
                ...List.generate(listOrder.length, (index) => Package(
                  idOrder: listOrder[index].orderId,
                  status: listOrder[index].status,
                  timeDelevery: DateTime.parse(listOrder[index].createAt)
                )),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
