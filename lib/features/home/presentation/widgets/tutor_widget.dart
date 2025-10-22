import 'package:flutter/material.dart';
import 'package:student/core/network/api_service.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:zap_sizer/zap_sizer.dart';

class TutorWidget extends StatelessWidget {
  final String tutorName;
  final String tutorImage;

  const TutorWidget({
    super.key,
    required this.tutorName,
    required this.tutorImage,
  });

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = tutorImage.startsWith('http')
        ? tutorImage
        :tutorImage.isEmpty?null: '${ApiService.baseUrl.replaceAll('/api', '')}$tutorImage';

    return CustomContainer(
      height: 10.h,
      padding: 0,
      color: ColorsUtils.grey2,
      radius: BorderRadius.circular(12),
      child: Row(
        spacing: 10,
        children: [
          CustomImage(
            imageUrl??AssetUtils.logo,
            height: 10.h,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                CustomText(
                  tutorName,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: ColorsUtils.primary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 5,
                  children: [
                    CustomImage(AssetUtils.graduationCapIcon),
                    CustomText('Medicine College'),
                  ],
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 5,
                  children: [
                    CustomImage(AssetUtils.openBookIcon),
                    CustomText('Zagazig University'),
                  ],
                ),
                const Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: CustomText(
                    'View Profile',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: ColorsUtils.main,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
