import 'package:student/core/network/api_service.dart';
import 'package:student/features/my_courses/model/my_courses_model.dart';

class MyCoursesRepo {
  final ApiService _apiService = ApiService.instance;

  Future<MyCoursesResponse> getStudentCourses() async {
    try {
      final response = await _apiService.get('/studentCourses');
      return MyCoursesResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch student courses: ${e.toString()}');
    }
  }
}
