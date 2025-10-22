import 'package:flutter/material.dart';
import 'package:student/core/app/globals.dart';
import 'package:student/core/services/storage_service.dart';
import 'package:student/core/shared/widgets/default_appbar.dart';
import 'package:student/features/offline_videos/presentation/widgets/offline_video_card_widget.dart';
import 'package:student/features/offline_videos/presentation/widgets/subscribe_download_widget.dart';


class OfflineVideosView extends StatelessWidget {
  const OfflineVideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppbar(),
body: FutureBuilder<List<Map<String, dynamic>>>(
  future: storageService.getDownloadedVideos(),
  builder: (context, snapshot) {
    if (!userData!.isPaid) {
      return const SubscribeDownloadWidget();
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    final videos = snapshot.data ?? [];

    if (videos.isEmpty) {
      return const Center(child: Text('No downloaded videos found.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(15),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: videos.length,
      itemBuilder: (context, i) {
        final video = videos[i];
        return OfflineVideoCardWidget(video: video,index:i);
      },
    );
  },
),
    );
  }
}
