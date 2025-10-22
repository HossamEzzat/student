import 'package:student/core/network/api_service.dart';
import 'package:student/features/auth/domain/models/university_model.dart';

class UniversityRemoteDataSource {
  final ApiService _apiService;

  UniversityRemoteDataSource(this._apiService);

  Future<List<UniversityModel>> getUniversities() async {
    try {
      final response = await _apiService.get('/universities');

      if (response.data['success'] == true) {
        final data = response.data['result']['data'] as List<dynamic>;
        return data.map((e) => UniversityModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch universities');
      }
    } catch (e) {
      throw Exception('Failed to fetch universities: $e');
    }
  }

  Future<List<FacultyModel>> getFacultiesByUniversityId(String universityId) async {
    try {
      final response = await _apiService.post(
        '/faculties',
        data: {'UniversityId': universityId},
      );

      if (response.data['success'] == true) {
        final data = response.data['result']['data'] as List<dynamic>;
        return data.map((e) => FacultyModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch faculties');
      }
    } catch (e) {
      throw Exception('Failed to fetch faculties: $e');
    }
  }
}
