part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class UniversitiesLoaded extends AuthState {
  final List<UniversityModel> universities;
  UniversitiesLoaded(this.universities);
}

class FacultiesLoaded extends AuthState {
  final List<FacultyModel> faculties;
  FacultiesLoaded(this.faculties);
}

class LevelsLoaded extends AuthState {
  final List<LevelModel> levels;
  LevelsLoaded(this.levels);
}

class RegisterSuccess extends AuthState {
  final String message;
  RegisterSuccess({this.message = 'Registration successful'});
}

class LoginSuccess extends AuthState {
  final LoginResponseModel loginResponse;
  final String message;
  LoginSuccess({required this.loginResponse, this.message = 'Login successful'});
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
