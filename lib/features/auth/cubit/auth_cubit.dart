import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/services/storage_service.dart';
import 'package:student/features/auth/domain/models/level_model.dart';
import 'package:student/features/auth/domain/models/login_request_model.dart';
import 'package:student/features/auth/domain/models/login_response_model.dart';
import 'package:student/features/auth/domain/models/register_request_model.dart';
import 'package:student/features/auth/domain/models/university_model.dart';
import 'package:student/features/auth/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  String fullName = '';
  String userName = '';
  String email = '';
  String password = '';
  int? selectedUserType;
  String? selectedUniversityId;
  String? selectedFacultyId;
  String? selectedLevelId;

  List<UniversityModel> universities = [];
  List<FacultyModel> faculties = [];
  List<LevelModel> levels = [];

  Future<void> getUniversities() async {
    emit(AuthLoading());
    try {
      universities = await authRepository.getUniversities();
      emit(UniversitiesLoaded(universities));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getFacultiesByUniversityId(String universityId) async {
    emit(AuthLoading());
    try {
      faculties = await authRepository.getFacultiesByUniversityId(universityId);
      emit(FacultiesLoaded(faculties));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getLevels() async {
    emit(AuthLoading());
    try {
      levels = await authRepository.getLevels();
      emit(LevelsLoaded(levels));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> registerStudent() async {
    emit(AuthLoading());
    try {
      final request = RegisterRequestModel(
        fullName: fullName,
        email: email,
        userName: userName,
        password: password,
        isUniversityStudent: selectedUserType == 1,
        universityId: selectedUserType == 1 ? selectedUniversityId : null,
        facultyId: selectedUserType == 1 ? selectedFacultyId : null,
        levelId: selectedUserType == 1 ? selectedLevelId : null,
      );

      final message = await authRepository.registerStudent(request);
      emit(RegisterSuccess(message: message));
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
    }
  }

  Future<void> loginStudent(String userName, String password) async {
    emit(AuthLoading());
    try {
      final request = LoginRequestModel(
        userName: userName,
        password: password,
      );

      final result = await authRepository.loginStudent(request);
      final loginResponse = result['loginResponse'] as LoginResponseModel;
      final message = result['message'] as String;

      await storageService.saveLoginData(
        loginResponse.token,
        loginResponse.user,
      );

      emit(LoginSuccess(loginResponse: loginResponse, message: message));
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
    }
  }

  Future<void> logout() async {
    await storageService.clearAll();
    emit(AuthInitial());
  }

  String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required';
    return null;
  }

  String? validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Username is required';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return 'Invalid email format';
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

}
