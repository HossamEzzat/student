import 'package:flutter/material.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:zap_sizer/zap_sizer.dart';

class SubscribeDownloadWidget extends StatelessWidget {
  const SubscribeDownloadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,spacing: 5,
        children: [
          const CustomImage(AssetUtils.offlineDownloadSubscribeIcon),
          const CustomText(
            'Offline Downloads Locked',
            color: ColorsUtils.primary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          const CustomText(
            'This feature is available for subscribed users only.  Upgrade your access to download videos offline anytime.',
            color: ColorsUtils.grey,
            fontSize: 14,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          CustomButton(title: 'Subscribe Now',width: 45.w, onPressed: () {}),
        ],
      ),
    );
  }
}
