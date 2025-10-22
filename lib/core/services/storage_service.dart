import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:student/features/auth/domain/models/login_response_model.dart';
import 'package:student/features/course/domain/models/video_progress_model.dart';

class StorageService {
  static final StorageService instance = StorageService._internal();

  factory StorageService() => instance;
  StorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static const String _keyToken = 'auth_token';
  static const String _keyUser = 'user_data';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyCourseProgress = 'course_progress_';
  static const String _keyDownloadedVideos = 'downloaded_videos';

  Future<void> saveToken(String token) async =>
      _storage.write(key: _keyToken, value: token);

  Future<String?> getToken() async => _storage.read(key: _keyToken);

  Future<void> saveUser(UserModel user) async =>
      _storage.write(key: _keyUser, value: jsonEncode(user.toJson()));

  Future<UserModel?> getUser() async {
    final userJson = await _storage.read(key: _keyUser);
    if (userJson == null) return null;
    return UserModel.fromJson(jsonDecode(userJson));
  }

  Future<void> saveLoginData(String token, UserModel user) async {
    await Future.wait([
      saveToken(token),
      saveUser(user),
      _storage.write(key: _keyIsLoggedIn, value: 'true'),
    ]);
  }

  Future<bool> isLoggedIn() async =>
      (await _storage.read(key: _keyIsLoggedIn)) == 'true';

  Future<void> clearAll() async => _storage.deleteAll();

  // ------------------- GENERIC -------------------
  Future<void> write(String key, String value) async =>
      _storage.write(key: key, value: value);

  Future<String?> read(String key) async => _storage.read(key: key);

  Future<void> delete(String key) async => _storage.delete(key: key);

  Future<Map<String, String>> readAll() async => _storage.readAll();

  // ------------------- VIDEO PROGRESS -------------------
  Future<void> saveVideoProgress(String courseId, String videoId) async {
    final courseProgress = await getCourseProgress(courseId);

    final index = courseProgress.videoProgress
        .indexWhere((v) => v.videoId == videoId);

    final video = VideoProgressModel(
      videoId: videoId,
      isCompleted: true,
      lastWatchedAt: DateTime.now(),
    );

    if (index != -1) {
      courseProgress.videoProgress[index] = video;
    } else {
      courseProgress.videoProgress.add(video);
    }

    await _storage.write(
      key: '$_keyCourseProgress$courseId',
      value: jsonEncode(courseProgress.toJson()),
    );
  }

  Future<CourseProgressModel> getCourseProgress(String courseId) async {
    final progressJson =
        await _storage.read(key: '$_keyCourseProgress$courseId');
    if (progressJson == null) {
      return CourseProgressModel(courseId: courseId, videoProgress: []);
    }
    return CourseProgressModel.fromJson(jsonDecode(progressJson));
  }

  Future<bool> isVideoCompleted(String courseId, String videoId) async {
    final courseProgress = await getCourseProgress(courseId);
    return courseProgress.isVideoCompleted(videoId);
  }

  Future<void> clearCourseProgress(String courseId) async =>
      _storage.delete(key: '$_keyCourseProgress$courseId');

  // ------------------- DOWNLOADED VIDEOS -------------------
  Future<void> saveDownloadedVideo(Map<String, dynamic> video) async {
    final dataJson = await _storage.read(key: _keyDownloadedVideos);
    final List<Map<String, dynamic>> videos = dataJson == null
        ? []
        : (jsonDecode(dataJson) as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

    videos.removeWhere((v) => v['id'] == video['id']);
    videos.add(video);

    await _storage.write(
      key: _keyDownloadedVideos,
      value: jsonEncode(videos),
    );
  }

  Future<List<Map<String, dynamic>>> getDownloadedVideos() async {
    final dataJson = await _storage.read(key: _keyDownloadedVideos);
    if (dataJson == null) return [];
    final List decoded = jsonDecode(dataJson);
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<void> clearDownloadedVideos() async =>
      _storage.delete(key: _keyDownloadedVideos);
}

final storageService = StorageService();
