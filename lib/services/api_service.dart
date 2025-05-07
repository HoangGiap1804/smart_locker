import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.55:8000/'));

  // Hàm GET
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? data,
    String? token,
  }) async {
    if (data == null) {
      return await _dio.get(
        endpoint,
        options: Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : {},
        ),
      );
    }
    return await _dio.get(
      endpoint,
      queryParameters: data,
      options: Options(
        headers: token != null ? {'Authorization': 'Bearer $token'} : {},
      ),
    );
  }

  // ✅ Hàm POST
  // Future<Response> post(String endpoint, Map<String, dynamic> data) async {
  //   try {
  //     final response = await _dio.post(endpoint, data: data);
  //     return response;
  //   } on DioException catch (e) {
  //     throw Exception('POST request failed: ${e.message}');
  //   }
  // }

  Future<Response> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('POST request failed: ${e.message}');
    }
  }

  Future<Response> put(String endpoint, {String? token}) async {
    return await _dio.put(
      endpoint,
      options: Options(
        headers: token != null ? {'Authorization': 'Bearer $token'} : {},
      ),
    );
  }
}
