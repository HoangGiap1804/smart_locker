import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smart_locker/models/order.dart';

import '../models/user.dart';
import '../services/api_service.dart';

class OrderRepository {
  final ApiService apiService;

  OrderRepository(this.apiService);

  Future<Order?> searchOrder(String idOrder, String accessToken) async {
    try {
      final response = await apiService.get(
        'api/orders/search/',
        data: {'order_id': idOrder},
        token: accessToken,
      );
      return Order.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
    }
  }

  Future<List<Order>> getListOrder(String accessToken) async {
    final response = await apiService.get(
      'api/orders/list-products/',
      token: accessToken,
    );
    final List<dynamic> data = response.data;
    return data.map((json) => Order.fromJson(json)).toList();
  }

  Future<bool> confirmOrder(String orderId, String accessToken) async {
    final response = await apiService.put(
      'api/orders/$orderId/confirm/',
      token: accessToken,
    );

    if (response.data is Map && response.data.containsKey('error')) {
      return false;
    }
    return true;
  }
}
