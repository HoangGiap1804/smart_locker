import 'package:smart_locker/models/locker.dart';
import 'package:smart_locker/models/product_history.dart';
import 'package:smart_locker/models/product_history_detail.dart';
import 'package:smart_locker/services/storage_service.dart';
import '../services/api_service.dart';

class LockerRepository {
  final ApiService apiService;

  LockerRepository(this.apiService);

  Future<List<Locker>> fetchLockers() async {
    String? accessToken = await StorageService().getAccessToken();
    if (accessToken != null) {
      final response = await apiService.get(
        'api/admin/lockers/',
        token: accessToken,
      );
      if (response.statusCode == 200) {
        final List<dynamic> data =
            response.data['data']; // JSON bạn gửi có "data"
        return data.map((json) => Locker.fromJson(json)).toList();
      } else {
        // throw Exception('Failed to fetch users');
      }
    }
    return [];
  }

  Future<List<ProductHistory>> fetchHistory(int id) async {
    String? accessToken = await StorageService().getAccessToken();
    if (accessToken != null) {
      final response = await apiService.get(
        'api/admin/lockers/$id/history/',
        token: accessToken,
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'];
        return data.map((e) => ProductHistory.fromJson(e)).toList();
      } else {
        // throw Exception('Failed to fetch users');
      }
    }
    return [];
  }

  Future<ProductHistoryDetail?> fetchProductHistoryDetail(int idProduct) async {
    String? accessToken = await StorageService().getAccessToken();
    if (accessToken != null) {
      final response = await apiService.get(
        'api/products/$idProduct/',
        token: accessToken,
      );
      if (response.statusCode == 200) {
        return ProductHistoryDetail.fromJson(response.data['data']);
      } else {
        // throw Exception('Failed to fetch users');
      }
    }
    return null;
  }
}
