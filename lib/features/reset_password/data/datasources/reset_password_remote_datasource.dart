import 'package:student/core/network/api_service.dart';
import 'package:student/features/reset_password/domain/models/send_reset_code_request_model.dart';
import 'package:student/features/reset_password/domain/models/verify_code_request_model.dart';
import 'package:student/features/reset_password/domain/models/set_new_password_request_model.dart';

class ResetPasswordRemoteDataSource {
  final ApiService apiService;

  ResetPasswordRemoteDataSource(this.apiService);

  Future<String> sendResetCode(SendResetCodeRequestModel request) async {
    try {
      final response = await apiService.post(
        '/send-reset-code',
        data: request.toJson(),
      );

      if (response.data['success'] == true) {
        return response.data['message'] ?? 'Reset code sent check Your Email ...';
      } else {
        throw Exception(response.data['message'] ?? 'Failed to send reset code');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyCode(VerifyCodeRequestModel request) async {
    try {
      final response = await apiService.post(
        '/verify-code',
        data: request.toJson(),
      );

      if (response.data['success'] == true) {
        return response.data['message'] ?? 'Code verified.';
      } else {
        throw Exception(response.data['message'] ?? 'Failed to verify code');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> setNewPassword(SetNewPasswordRequestModel request) async {
    try {
      final response = await apiService.post(
        '/set-new-password',
        data: request.toJson(),
      );

      if (response.data['success'] == true) {
        return response.data['message'] ?? 'Password reset successful.';
      } else {
        throw Exception(response.data['message'] ?? 'Failed to reset password');
      }
    } catch (e) {
      rethrow;
    }
  }
}
