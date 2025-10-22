part of 'reset_password_cubit.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class SendResetCodeSuccess extends ResetPasswordState {
  final String message;
  SendResetCodeSuccess({required this.message});
}

class VerifyCodeSuccess extends ResetPasswordState {
  final String message;
  VerifyCodeSuccess({required this.message});
}

class SetNewPasswordSuccess extends ResetPasswordState {
  final String message;
  SetNewPasswordSuccess({required this.message});
}

class ResetPasswordError extends ResetPasswordState {
  final String message;
  ResetPasswordError({required this.message});
}
