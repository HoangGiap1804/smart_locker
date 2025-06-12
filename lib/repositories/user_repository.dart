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

  Future<User?> signInUser(String username, String password) async {
    try {
      final response = await apiService.post('api/auth/signin/', {
        'username_email': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        String refresh = response.data['refresh'];
        String access = response.data['access'];
        StorageService().saveTokens(access, refresh);
        return User.fromJson(response.data); // ✅ Trả về User
      } else if (response.statusCode == 403) {
        throw Exception(response.data['error'] ?? 'Unauthorized or Forbidden');
      } else if (response.statusCode == 401) {
        throw Exception('Incorrect username or password.');
      } else {
        throw Exception(response.data['error'] ?? 'Login failed');
      }
    } catch (e) {
      // Log hoặc xử lý lỗi kết nối mạng, parsing, v.v.
      throw Exception(e.toString());
    }
  }

  Future<bool> signUpUser(User user) async {
    Random ran = Random();
    final formData = FormData.fromMap({
      'username': user.userName,
      'full_name': user.fullName,
      'email': user.email,
      'phone_number': user.phoneNumber,
      'gender': user.gender,
      'password': user.password,
      'face_images': await Future.wait(
        user.pictures!.map(
          (file) async => await MultipartFile.fromFile(
            file.path,
            filename: "${ran.nextInt(10000000)}.jpg",
          ),
        ),
      ),
    });

    print("username: ${user.userName}");
    print("full_name: ${user.fullName}");
    print("email: ${user.email}");
    print("phone_number: ${user.phoneNumber}");
    print("gender: ${user.gender}");
    print("password: ${user.password}");
    for (var file in formData.files) {
      print("Field: ${file.key}, File: ${file.value.filename}");
    }

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
      final response = await apiService.get(
        'api/admin/users/',
        token: accessToken,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((e) => UserActive.fromJson(e)).toList();
      } else {
        // throw Exception('Failed to fetch users');
      }
    }
    return [];
  }

  Future<bool> forgotPassword(email) async {
    final response = await apiService.post1('api/auth/forgot-password/', {
      'email': email,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      // throw Exception('Failed to fetch users');
    }
    return false;
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    String? accessToken = await StorageService().getAccessToken();
    if (accessToken != null) {
      print("access token ${accessToken!}");
      final response = await apiService.post1('api/auth/change-password/', {
        'old_password': oldPassword,
        'new_password': newPassword,
      }, accessToken);

      if (response.statusCode == 200) {
        return true;
      } else {
        // throw Exception('Failed to fetch users');
      }
    }
    return false;
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
