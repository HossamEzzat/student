import 'package:student/core/network/api_service.dart';
import 'package:student/features/auth/domain/models/level_model.dart';

class LevelRemoteDataSource {
  final ApiService _apiService;

  LevelRemoteDataSource(this._apiService);

  Future<List<LevelModel>> getLevels() async {
    try {
      final response = await _apiService.get('/levels');

      if (response.data['success'] == true) {
        final data = response.data['result']['data'] as List<dynamic>;
        return data.map((e) => LevelModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch levels');
      }
    } catch (e) {
      throw Exception('Failed to fetch levels: $e');
    }
  }
}
