import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_locker/models/user.dart';

class StorageService {
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', user.email);
    await prefs.setString('user_name', user.userName);
    await prefs.setString('full_name', user.fullName);
    await prefs.setString('phone_number', user.phoneNumber);
    await prefs.setString('gender', user.gender);
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = await prefs.getString('email');
    String? userName = await prefs.getString('user_name');
    String? fullName = await prefs.getString('full_name');
    String? phoneNumber = await prefs.getString('phone_number');
    String? gender = await prefs.getString('gender');
    return User(
      email: email!,
      userName: userName!,
      fullName: fullName!,
      phoneNumber: phoneNumber!,
      gender: gender!,
    );
  }

  // Lưu token
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  // Lưu user info (giả sử là dạng JSON string)
  Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_info', userInfo.toString());
  }

  // Lấy token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('access_token')){
      return prefs.getString('access_token');
    }
    else{
      return "";
    }

  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  // Xoá tất cả
  Future<void> clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
