class VideoProgressModel {
  final String videoId;
  final bool isCompleted;
  final DateTime lastWatchedAt;

  VideoProgressModel({
    required this.videoId,
    required this.isCompleted,
    required this.lastWatchedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'videoId': videoId,
      'isCompleted': isCompleted,
      'lastWatchedAt': lastWatchedAt.toIso8601String(),
    };
  }

  factory VideoProgressModel.fromJson(Map<String, dynamic> json) {
    return VideoProgressModel(
      videoId: json['videoId'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      lastWatchedAt: json['lastWatchedAt'] != null
          ? DateTime.parse(json['lastWatchedAt'])
          : DateTime.now(),
    );
  }
}

class CourseProgressModel {
  final String courseId;
  final List<VideoProgressModel> videoProgress;

  CourseProgressModel({
    required this.courseId,
    required this.videoProgress,
  });

  double get completionPercentage {
    if (videoProgress.isEmpty) return 0.0;
    final completedCount = videoProgress.where((v) => v.isCompleted).length;
    return (completedCount / videoProgress.length) * 100;
  }

  int get completedVideosCount {
    return videoProgress.where((v) => v.isCompleted).length;
  }

  int get totalVideosCount {
    return videoProgress.length;
  }

  bool isVideoCompleted(String videoId) {
    final video = videoProgress.firstWhere(
      (v) => v.videoId == videoId,
      orElse: () => VideoProgressModel(
        videoId: videoId,
        isCompleted: false,
        lastWatchedAt: DateTime.now(),
      ),
    );
    return video.isCompleted;
  }

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'videoProgress': videoProgress.map((v) => v.toJson()).toList(),
    };
  }

  factory CourseProgressModel.fromJson(Map<String, dynamic> json) {
    final progressList = json['videoProgress'] as List<dynamic>? ?? [];
    return CourseProgressModel(
      courseId: json['courseId'] ?? '',
      videoProgress: progressList
          .map((v) => VideoProgressModel.fromJson(v as Map<String, dynamic>))
          .toList(),
    );
  }
}
