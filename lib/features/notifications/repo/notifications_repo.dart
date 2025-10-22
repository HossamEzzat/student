import 'package:student/core/network/api_service.dart';
import 'package:student/features/notifications/model/notifications_model.dart';

class NotificationsRepo {
  final ApiService _apiService = ApiService();

  Future<NotificationsResponse> getNotifications() async {
    try {
      final response = await _apiService.get('/notifications');
      return NotificationsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch notifications: ${e.toString()}');
    }
  }
}
