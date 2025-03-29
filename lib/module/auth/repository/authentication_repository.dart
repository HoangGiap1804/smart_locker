import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthenticationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  int lengthUserNameValid = 3;
  int lengthPasswordValid = 3;

  Future<String> signUpUser({
    required String userName,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String gender,
    required String password,
    required String confirmPassword,
  }) async {

    String res = " Some error occurred";
    try {
      if(userName.isEmpty || password.isEmpty || confirmPassword.isEmpty){
        return "Please enter all the field";
      }
      if(userName.length < lengthUserNameValid){
        return "Username is too short";
      }
      if(password.length < lengthPasswordValid){
        return "Password is too short";
      }
      if(confirmPassword.length < lengthPasswordValid){
        return "Confirm password is too short";
      }
      if(password != confirmPassword){
        return "Password does not match";
      }

      final url = Uri.parse('http://192.168.1.55:8000/api/auth/signup/');

      try {
        final response = await http.post(
          url,
          headers: {
          'Content-Type': 'application/json',
        },
          body: jsonEncode({
            'username': userName,
            'full_name': fullName,
            'email': email,
            'phone_number': phoneNumber,
            'gender': gender,
            'password': password,
            'confirm_password': password,
          }),
        );

        if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
          print("Đăng nhập thành công: $data");
        } else {
          print("Lỗi: ${response.statusCode} - ${response.body}");
        }
      } catch (error) {
        print("Lỗi kết nối: $error");
      }

      res = "success";
    } catch (e) {
      return e.toString();
    }

    return res;
  }

  Future<String> loginUser({
    required String userName,
    required String password,
  }) async {

    String res = " Some error occurred";
    try {
      if(userName.isEmpty || password.isEmpty){
        return "Please enter all the field";
      }
      if(userName.length < lengthUserNameValid){
        return "Username is too short";
      }
      if(password.length < lengthPasswordValid){
        return "Password is too short";
      }

      final url = Uri.parse('http://192.168.1.55:8000/api/auth/signin/');

      try {
        final response = await http.post(
          url,
          headers: {
          'Content-Type': 'application/json',
        },
          body: jsonEncode({
            'username_email': userName,
            'password': password,
          }),
        );

        if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
          print("Đăng nhập thành công: $data");
          res = "success";
        } else {
          print("Lỗi: ${response.statusCode} - ${response.body}");
          final data = jsonDecode(response.body);
          res = data['error'];
        }
      } catch (error) {
        print("Lỗi kết nối: $error");
      }

    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> forgotPassword({
    required String username,
  }) async {

    String res = " Some error occurred";
    try {

      if(username.isEmpty){
        return res = "Please enter the email";
      }
      if(username.length < lengthUserNameValid){
        return "Username is too short";
      }

      await _auth.sendPasswordResetEmail(email: username).then((value){
        res = "success";
      }).onError((error, stackTrace){
        res = error.toString();
      });
    } catch (e) {
      return e.toString();
    }

    return res;
  }

  Future<void> signOut() async{
    await _auth.signOut();
  }

}
