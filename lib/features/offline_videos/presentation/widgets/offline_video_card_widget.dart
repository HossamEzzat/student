import 'package:flutter/material.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/offline_videos/presentation/widgets/local_video_player_view.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class OfflineVideoCardWidget extends StatelessWidget {
  final Map<String, dynamic> video;
  final int index;
  const OfflineVideoCardWidget({super.key,required this.index, required this.video});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Zap.to(LocalVideoPlayerView(filePath: video['cachedPath']));
      },
      child: CustomContainer(
        border: Border.all(color: ColorsUtils.grey),
        borderRadius: 10,
        height: 13.h,

        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.transparent,
              
              child: CustomText((index+1).toString()),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    video['title'],
                    fontWeight: FontWeight.w700,
                    color: ColorsUtils.primary,
                    fontSize: 15,
                  ),

                  const Spacer(),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      'Downloaded',
                      textAlign: TextAlign.end,
                      color: ColorsUtils.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
