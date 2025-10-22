import 'package:student/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:student/features/auth/data/datasources/level_remote_datasource.dart';
import 'package:student/features/auth/data/datasources/university_remote_datasource.dart';
import 'package:student/features/auth/domain/models/level_model.dart';
import 'package:student/features/auth/domain/models/login_request_model.dart';
import 'package:student/features/auth/domain/models/register_request_model.dart';
import 'package:student/features/auth/domain/models/university_model.dart';
import 'package:student/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final UniversityRemoteDataSource universityRemoteDataSource;
  final LevelRemoteDataSource levelRemoteDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.universityRemoteDataSource,
    required this.levelRemoteDataSource,
  });

  @override
  Future<List<UniversityModel>> getUniversities() async {
    return await universityRemoteDataSource.getUniversities();
  }

  @override
  Future<List<FacultyModel>> getFacultiesByUniversityId(String universityId) async {
    return await universityRemoteDataSource.getFacultiesByUniversityId(universityId);
  }

  @override
  Future<List<LevelModel>> getLevels() async {
    return await levelRemoteDataSource.getLevels();
  }

  @override
  Future<String> registerStudent(RegisterRequestModel request) async {
    final validationError = request.validate();
    if (validationError != null) {
      throw Exception(validationError);
    }
    return await authRemoteDataSource.registerStudent(request);
  }

  @override
  Future<Map<String, dynamic>> loginStudent(LoginRequestModel request) async {
    final validationError = request.validate();
    if (validationError != null) {
      throw Exception(validationError);
    }
    return await authRemoteDataSource.loginStudent(request);
  }
}
