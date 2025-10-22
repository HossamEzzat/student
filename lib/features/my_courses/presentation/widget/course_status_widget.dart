import 'package:flutter/material.dart';
import 'package:student/core/network/api_service.dart';
import 'package:student/core/services/storage_service.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_progress_bar.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/home/model/home_model.dart';

class CourseStatusWidget extends StatefulWidget {
  final ModuleItem course;

  const CourseStatusWidget({
    super.key,
    required this.course,
  });

  @override
  State<CourseStatusWidget> createState() => _CourseStatusWidgetState();
}

class _CourseStatusWidgetState extends State<CourseStatusWidget> {
  double _progress = 0.0;
  int _completedVideos = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  /// Public method to refresh progress from external calls
  void refreshProgress() {
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final courseProgress = await storageService.getCourseProgress(widget.course.id);

      if (!mounted) return;

      final totalVideos = widget.course.videos.length;
      final completedCount = courseProgress.completedVideosCount;

      setState(() {
        _completedVideos = completedCount;
        _progress = totalVideos > 0 ? completedCount / totalVideos : 0.0;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _progress = 0.0;
        _completedVideos = 0;
        _isLoading = false;
      });
      debugPrint('Error loading course progress: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.course.coverImageUrl.startsWith('http')
        ? widget.course.coverImageUrl
        : widget.course.coverImageUrl.isEmpty
            ? null
            : '${ApiService.baseUrl.replaceAll('/api', '')}${widget.course.coverImageUrl}';

    final totalVideos = widget.course.videos.length;

    return CustomContainer(
      border: Border.all(color: ColorsUtils.grey),
      borderRadius: 10,
      child: Column(
        spacing: 5,
        children: [
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImage(
                imageUrl ?? AssetUtils.logo,
                size: 34,
                radius: 8,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      widget.course.name,
                      fontWeight: FontWeight.w700,
                      color: ColorsUtils.primary,
                      fontSize: 15,
                    ),
                    CustomText(
                      widget.course.doctorName,
                      color: ColorsUtils.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isLoading)
            const SizedBox(
              height: 10,
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(ColorsUtils.main),
              ),
            )
          else
            CustomProgressBar(value: _progress),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomImage(
                AssetUtils.openBookIcon,
                color: ColorsUtils.grey,
                size: 18,
              ),
              if (_isLoading)
                const CustomText(
                  'Loading...',
                  color: ColorsUtils.grey,
                )
              else
                CustomText(
                  '$_completedVideos/$totalVideos Videos',
                  color: ColorsUtils.grey,
                ),
              const Spacer(),
              CustomText(
                '${widget.course.studentsCount} Students',
                color: ColorsUtils.grey,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 5,
            children: [
              if (!_isLoading && _progress > 0 && _progress < 1)
                const CustomText(
                  'Resume Course',
                  fontSize: 14,
                  color: ColorsUtils.main,
                )
              else if (!_isLoading && _progress >= 1)
                const CustomText(
                  'Course Completed',
                  fontSize: 14,
                  color: Colors.green,
                )
              else
                const CustomText(
                  'Start Course',
                  fontSize: 14,
                  color: ColorsUtils.main,
                ),
              Icon(
                _progress >= 1 ? Icons.check_circle : Icons.play_circle_outline,
                color: _progress >= 1 ? Colors.green : ColorsUtils.main,
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
