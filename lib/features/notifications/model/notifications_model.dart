class NotificationItem {
  final String title;
  final String content;
  final String timestamp;

  NotificationItem({
    required this.title,
    required this.content,
    required this.timestamp,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'timestamp': timestamp,
    };
  }
}

class NotificationsResponse {
  final bool success;
  final NotificationsResult result;
  final String message;

  NotificationsResponse({
    required this.success,
    required this.result,
    required this.message,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      success: json['success'] ?? false,
      result: NotificationsResult.fromJson(json['result'] ?? {}),
      message: json['message'] ?? '',
    );
  }
}

class NotificationsResult {
  final List<NotificationItem> notifications;

  NotificationsResult({required this.notifications});

  factory NotificationsResult.fromJson(Map<String, dynamic> json) {
    final notificationsList = json['notifications'] as List<dynamic>? ?? [];
    return NotificationsResult(
      notifications: notificationsList
          .map((item) => NotificationItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
