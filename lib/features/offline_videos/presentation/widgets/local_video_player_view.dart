import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student/core/widgets/custom_appbar.dart';
import 'package:video_player/video_player.dart';

class LocalVideoPlayerView extends StatefulWidget {
  final String filePath;
  const LocalVideoPlayerView({super.key, required this.filePath});

  @override
  State<LocalVideoPlayerView> createState() => _LocalVideoPlayerViewState();
}

class _LocalVideoPlayerViewState extends State<LocalVideoPlayerView> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      _controller = VideoPlayerController.file(File(widget.filePath));
      await _controller.initialize();
      _controller.play();
      setState(() => _isInitialized = true);
    } catch (e) {
      debugPrint(' Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: Center(
        child: _isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator.adaptive(),
      ),
      floatingActionButton: _isInitialized
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}
