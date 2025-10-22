import 'package:student/features/home/model/home_model.dart';

class MyCoursesResponse {
  final bool success;
  final MyCoursesResult result;
  final String message;

  MyCoursesResponse({
    required this.success,
    required this.result,
    required this.message,
  });

  factory MyCoursesResponse.fromJson(Map<String, dynamic> json) {
    return MyCoursesResponse(
      success: json['success'] ?? false,
      result: MyCoursesResult.fromJson(json['result'] ?? {}),
      message: json['message'] ?? '',
    );
  }
}

class MyCoursesResult {
  final List<ModuleItem> courses;

  MyCoursesResult({required this.courses});

  factory MyCoursesResult.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>? ?? [];
    return MyCoursesResult(
      courses: dataList
          .map((item) => ModuleItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
