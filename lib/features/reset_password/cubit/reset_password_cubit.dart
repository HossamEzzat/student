import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/features/reset_password/domain/models/send_reset_code_request_model.dart';
import 'package:student/features/reset_password/domain/models/verify_code_request_model.dart';
import 'package:student/features/reset_password/domain/models/set_new_password_request_model.dart';
import 'package:student/features/reset_password/domain/repositories/reset_password_repository.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepository repository;

  ResetPasswordCubit(this.repository) : super(ResetPasswordInitial());

  String email = '';
  String verificationCode = '';
  String newPassword = '';

  Future<void> sendResetCode(String email) async {
    emit(ResetPasswordLoading());
    try {
      this.email = email;
      final request = SendResetCodeRequestModel(email: email);
      final message = await repository.sendResetCode(request);
      emit(SendResetCodeSuccess(message: message));
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(ResetPasswordError(message: errorMessage));
    }
  }

  Future<void> verifyCode(String code) async {
    emit(ResetPasswordLoading());
    try {
      verificationCode = code;
      final request = VerifyCodeRequestModel(
        email: email,
        code: code,
      );
      final message = await repository.verifyCode(request);
      emit(VerifyCodeSuccess(message: message));
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(ResetPasswordError(message: errorMessage));
    }
  }

  Future<void> setNewPassword(String password) async {
    emit(ResetPasswordLoading());
    try {
      newPassword = password;
      final request = SetNewPasswordRequestModel(
        email: email,
        newpassword: password,
      );
      final message = await repository.setNewPassword(request);
      emit(SetNewPasswordSuccess(message: message));
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(ResetPasswordError(message: errorMessage));
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validateCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Verification code is required';
    }
    if (value.length != 6) {
      return 'Verification code must be 6 digits';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Verification code must contain only numbers';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must include at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must include at least one lowercase letter';
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must include at least one digit';
    }

    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(value)) {
      return 'Password must include at least one special character';
    }

    return null;
  }

  void reset() {
    email = '';
    verificationCode = '';
    newPassword = '';
    emit(ResetPasswordInitial());
  }
}
