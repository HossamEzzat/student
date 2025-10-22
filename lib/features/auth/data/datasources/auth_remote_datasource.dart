import 'package:student/core/network/api_service.dart';
import 'package:student/features/auth/domain/models/login_request_model.dart';
import 'package:student/features/auth/domain/models/login_response_model.dart';
import 'package:student/features/auth/domain/models/register_request_model.dart';

class AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSource(this._apiService);

  Future<String> registerStudent(RegisterRequestModel request) async {
    final response = await _apiService.post(
      '/registerStudent',
      data: request.toJson(),
    );
    final Map<String, dynamic> data = response.data;
    if (data['success'] != true) {
      throw Exception(data['message'] ?? 'Registration failed');
    }
    return data['message'] ?? 'Registration successful';
  }

  Future<Map<String, dynamic>> loginStudent(LoginRequestModel request) async {
    final response = await _apiService.post(
      '/login',
      data: request.toJson(),
    );
    final Map<String, dynamic> data = response.data;
    if (data['success'] != true) {
      throw Exception(data['message'] ?? 'Login failed');
    }
    return {
      'loginResponse': LoginResponseModel.fromJson(data['result']),
      'message': data['message'] ?? 'Login successful',
    };
  }
}
