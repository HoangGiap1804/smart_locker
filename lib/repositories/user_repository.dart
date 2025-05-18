import 'dart:math';

import 'package:dio/dio.dart';
import 'package:smart_locker/models/user_active.dart';
import 'package:smart_locker/services/storage_service.dart';

import '../models/user.dart';
import '../services/api_service.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository(this.apiService);

  Future<List<User>> fetchUsers() async {
    final response = await apiService.get('api/orders/list-products/');
    final List<dynamic> data = response.data;
    return data.map((json) => User.fromJson(json)).toList();
  }

  Future<User> signInUser(String username, String password) async {
    final response = await apiService.post('api/auth/signin/', {
      'username_email': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      String refresh = response.data['refresh'];
      String access = response.data['access'];
      StorageService().saveTokens(access, refresh);
      // throw Exception('Ghi nhan thanh cong');
      return User.fromJson(response.data); // ✅ Trả về User
    } else {
      throw Exception('Username or password is wrong');
    }
  }

  Future<bool> signUpUser(User user) async {
    int ran = Random().nextInt(1000000);
    final formData = FormData.fromMap({
      'username': user.userName,
      'full_name': user.fullName,
      'email': user.email,
      'phone_number': user.phoneNumber,
      'gender': user.gender,
      'password': user.password,
      'face_id': await MultipartFile.fromFile(
        user.picture!.path,
        filename: '$ran.jpg',
      ),
    });

    final response = await apiService.post('api/auth/signup/', formData);

    if (response.statusCode == 201) {
      return response.data['success'];
    } else {
      throw Exception(response.data['error']);
    }
  }

  Future<List<UserActive>> getAllUsers() async {
    String? accessToken = await StorageService().getAccessToken();
    if (accessToken != null) {
      print("access token ${accessToken!}");
      final response = await apiService.get('api/admin/users/', token: accessToken);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((e) => UserActive.fromJson(e)).toList();
      } else {
        // throw Exception('Failed to fetch users');
      }
    }
    return [];
  }

  // Optional: Toggle user active status (nếu backend hỗ trợ)
  Future<bool> toggleUserActive(int userId, bool isActive) async {
    try {
      String? accessToken = await StorageService().getAccessToken();
      if (accessToken != null) {
        await apiService.post1('api/admin/users/toggle-status/', {
          'user_id': userId,
          'is_active': isActive ? "True" : "False",
        }, accessToken);
        return true;
      }
    } catch (e) {
      print("toggle user: ${e.toString()}");
    }
    return false;
  }
}
