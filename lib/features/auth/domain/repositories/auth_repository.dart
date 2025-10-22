import 'package:student/features/auth/domain/models/level_model.dart';
import 'package:student/features/auth/domain/models/login_request_model.dart';
import 'package:student/features/auth/domain/models/register_request_model.dart';
import 'package:student/features/auth/domain/models/university_model.dart';

abstract class AuthRepository {
  Future<List<UniversityModel>> getUniversities();
  Future<List<FacultyModel>> getFacultiesByUniversityId(String universityId);
  Future<List<LevelModel>> getLevels();
  Future<String> registerStudent(RegisterRequestModel request);
  Future<Map<String, dynamic>> loginStudent(LoginRequestModel request);
}
