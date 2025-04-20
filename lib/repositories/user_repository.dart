import 'package:dio/dio.dart';
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

  Future<User> signUpUser(User user) async {
    try {
      final response = await apiService.post('api/auth/signup/', {
        'username': user.userName,
        'full_name': user.fullName,
        'email': user.email,
        'phone_number': user.phoneNumber,
        'gender': user.gender,
        'password': user.password,
      });

      if (response.statusCode == 201) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Something is wrong');
      }
    } catch (e) {
      throw Exception('Sign up is fail' + e.toString()); // ✅ Không return null
    }
  }
}
