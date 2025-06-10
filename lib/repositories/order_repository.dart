import 'dart:math';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_locker/models/order.dart';
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
    } on DioException {
      return null;
    }
  }

  Future<Order?> searchOrderByID(String idOrder, String accessToken) async {
    try {
      final response = await apiService.get(
        'api/orders/$idOrder/detail',
        token: accessToken,
      );
      return Order.fromJson(response.data);
    } on DioException {
      return null;
    }
  }

  Future<List<Order>?> getListOrder(String accessToken) async {
    try {
      final response = await apiService.get(
        'api/orders/list-products/',
        token: accessToken,
      );
      if (response.statusCode == 404) {
        return [];
      }
      final List<dynamic> data = response.data;
      return data.map((json) => Order.fromJson(json)).toList();
    } catch (e) {
      print("error get list product");
    }
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

  Future<bool?> scanFace(
    String orderId,
    XFile image,
    String accessToken,
  ) async {
    Random ran = Random();
    try {
      final formData = FormData.fromMap({
        'order_id': orderId,
        'face_image': await MultipartFile.fromFile(
          image.path,
          filename: '$ran.jpg',
        ),
      });
      final response = await apiService.post(
        'api/face/recognize/',
        formData,
        accessToken,
      );

      if (response.statusCode == 401) {
        return false;
      }
      if (response.data is Map) {
        return response.data["success"];
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool?> scanFaceLocker(String orderId, String accessToken) async {
    try {
      final formData = FormData.fromMap({'order_id': orderId});
      final response = await apiService.post(
        'api/face/recognize-at-locker/',
        formData,
        accessToken,
      );

      if (response.statusCode == 401) {
        return false;
      }
      if (response.data is Map) {
        return response.data["success"];
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool?> openLocker(String accessToken) async {
    final response = await apiService.post('api/verify/', accessToken);

    if (response.data is Map && response.data.containsKey('error')) {
      return response.data["success"];
    }
    return false;
  }
}
