import 'package:student/features/reset_password/domain/models/send_reset_code_request_model.dart';
import 'package:student/features/reset_password/domain/models/verify_code_request_model.dart';
import 'package:student/features/reset_password/domain/models/set_new_password_request_model.dart';

abstract class ResetPasswordRepository {
  Future<String> sendResetCode(SendResetCodeRequestModel request);
  Future<String> verifyCode(VerifyCodeRequestModel request);
  Future<String> setNewPassword(SetNewPasswordRequestModel request);
}
