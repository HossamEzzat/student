import 'package:flutter/material.dart';
import 'package:student/core/services/storage_service.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/course/presentation/view/video_view.dart';
import 'package:student/features/home/model/home_model.dart';
import 'package:zapx/zapx.dart';

class ContentTabSection extends StatefulWidget {
  const ContentTabSection(
    this.videos,
    this.courseId, {
    super.key,
  });

  final List<ModuleVideo> videos;
  final String courseId;

  @override
  State<ContentTabSection> createState() => _ContentTabSectionState();
}

class _ContentTabSectionState extends State<ContentTabSection> {
  Map<String, bool> videoCompletionStatus = {};

  @override
  void initState() {
    super.initState();
    _loadVideoProgress();
  }

  Future<void> _loadVideoProgress() async {
    final progress = await storageService.getCourseProgress(widget.courseId);
    setState(() {
      for (var video in widget.videos) {
        videoCompletionStatus[video.id] = progress.isVideoCompleted(video.id);
      }
    });
  }

  Future<void> _navigateToVideo(ModuleVideo video) async {
    final result = await Zap.to(VideoView(video, widget.courseId));

    if (result == true || mounted) {
      await _loadVideoProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: widget.videos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final video = widget.videos[index];
        final isCompleted = videoCompletionStatus[video.id] ?? false;

        return InkWell(
          onTap: () => _navigateToVideo(video),
          child: _buildLectureItem(
            title: video.title,
            duration: video.duration,
            isCompleted: isCompleted,
          ),
        );
      },
    );
  }

  Widget _buildLectureItem({
    required String title,
    required String duration,
    required bool isCompleted,
  }) {
    return CustomContainer(
      color: Colors.white,
      padding: 16,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
      child: Row(
        children: [
          CustomContainer(
            color: isCompleted
                ? Colors.green.withValues(alpha: 0.1)
                : ColorsUtils.main.withValues(alpha: 0.1),
            padding: 12,
            borderRadius: 12,
            child: Icon(
              isCompleted ? Icons.check_circle_rounded : Icons.play_arrow_rounded,
              color: isCompleted ? Colors.green : ColorsUtils.main,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorsUtils.primary,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: ColorsUtils.grey,
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      duration,
                      fontSize: 12,
                      color: ColorsUtils.grey,
                    ),
                    if (isCompleted) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.check_circle,
                        size: 14,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 4),
                      const CustomText(
                        'Completed',
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
