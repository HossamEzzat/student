import 'package:student/core/network/api_service.dart';
import 'package:student/features/home/model/home_model.dart';

class HomeRepo {
  final ApiService _apiService = ApiService();

  Future<ModulesResponse> getModulesWithCourses() async {
    try {
      final response = await _apiService.get('/modulesWithCourses');
      return ModulesResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch modules: ${e.toString()}');
    }
  }
}
