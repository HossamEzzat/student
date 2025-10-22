import 'package:student/features/reset_password/data/datasources/reset_password_remote_datasource.dart';
import 'package:student/features/reset_password/domain/models/send_reset_code_request_model.dart';
import 'package:student/features/reset_password/domain/models/verify_code_request_model.dart';
import 'package:student/features/reset_password/domain/models/set_new_password_request_model.dart';
import 'package:student/features/reset_password/domain/repositories/reset_password_repository.dart';

class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ResetPasswordRemoteDataSource remoteDataSource;

  ResetPasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> sendResetCode(SendResetCodeRequestModel request) async {
    final validationError = request.validate();
    if (validationError != null) {
      throw Exception(validationError);
    }
    return await remoteDataSource.sendResetCode(request);
  }

  @override
  Future<String> verifyCode(VerifyCodeRequestModel request) async {
    final validationError = request.validate();
    if (validationError != null) {
      throw Exception(validationError);
    }
    return await remoteDataSource.verifyCode(request);
  }

  @override
  Future<String> setNewPassword(SetNewPasswordRequestModel request) async {
    final validationError = request.validate();
    if (validationError != null) {
      throw Exception(validationError);
    }
    return await remoteDataSource.setNewPassword(request);
  }
}
