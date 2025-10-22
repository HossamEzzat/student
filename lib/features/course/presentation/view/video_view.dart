import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student/main.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:student/core/app/globals.dart';
import 'package:student/core/services/storage_service.dart';
import 'package:student/core/widgets/custom_appbar.dart';
import 'package:student/features/home/model/home_model.dart';

class VideoView extends StatefulWidget {
  const VideoView(this.video, this.courseId, {super.key});
  final ModuleVideo video;
  final String courseId;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController? _controller;
  bool _hasCompletedVideo = false;
  bool _progressSaved = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      final url = widget.video.videoUrl;
      final cacheManager = DefaultCacheManager();

      FileInfo? fileInfo = await cacheManager.getFileFromCache(url);
      File file;

      if (fileInfo != null && await fileInfo.file.exists()) {
        logger.d(' Loaded video from cache: ${fileInfo.file.path}');
        file = fileInfo.file;
      } else {
        logger.d('⬇ Downloading and caching video...');
        file = await cacheManager.getSingleFile(url);
      }

      await _initializeController(file);
      await _saveCachedVideo(file);
    } catch (e) {
      debugPrint(' Error initializing video: $e');
    }
  }

  Future<void> _initializeController(File file) async {
    _controller = VideoPlayerController.file(file);
    await _controller!.initialize();
    _controller!.play();
    _controller!.addListener(_videoListener);

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _videoListener() {
    if (!_controller!.value.isInitialized) return;

    final position = _controller!.value.position;
    final duration = _controller!.value.duration;

    if (duration.inMilliseconds > 0 &&
        position.inMilliseconds >= (duration.inMilliseconds * 0.9) &&
        !_hasCompletedVideo) {
      _hasCompletedVideo = true;
      _saveProgress();
    }
  }

  Future<void> _saveProgress() async {
    if (_progressSaved) return;
    _progressSaved = true;

    try {
      await storageService.saveVideoProgress(widget.courseId, widget.video.id);
    } catch (e) {
      debugPrint('Error saving video progress: $e');
    }
  }

  Future<void> _saveCachedVideo(File file) async {
    try {
      await storageService.saveDownloadedVideo({
        'id': widget.video.id,
        'title': widget.video.title,
        'url': widget.video.videoUrl,
        'cachedPath': file.path,
        'course': widget.courseId,
        'duration': widget.video.duration,
      });
      logger.d('✅ Cached video saved: ${file.path}');
    } catch (e) {
      debugPrint('❌ Error saving cached video: $e');
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = userData?.fullName ?? '';
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _hasCompletedVideo) {
          Navigator.of(context).pop(true);
        }
      },
      child: Scaffold(
        appBar: CustomAppbar(onBack: Navigator.of(context).maybePop),
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator.adaptive()
              : AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: Stack(
                    children: [
                      VideoPlayer(_controller!),

                      // Overlay watermark
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Center(
                            child: Text(
                              name,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.15),
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 10,
                        right: 10,
                        child: Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
