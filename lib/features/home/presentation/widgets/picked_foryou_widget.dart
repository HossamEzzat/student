import 'package:flutter/material.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/network/api_service.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/home/model/home_model.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class PickedForyouWidget extends StatelessWidget {
  final List<ModuleItem> modules;

  const PickedForyouWidget({super.key, required this.modules});

  @override
  Widget build(BuildContext context) {
    if (modules.isEmpty) {
      return const Center(
        child: CustomText(
          'No courses available',
          color: ColorsUtils.grey,
        ),
      );
    }

    return CustomContainer(
      height: 30.h,
      child: ListView.separated(
        itemCount: modules.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 30),
        itemBuilder: (context, index) {
          final module = modules[index];
          final imageUrl = module.coverImageUrl.startsWith('http')
              ? module.coverImageUrl
              : module.coverImageUrl.isEmpty?null:'${ApiService.baseUrl.replaceAll('/api', '')}${module.coverImageUrl}';

          return CustomContainer(
            width: 70.w,
            padding: 8,
            border: Border.all(color: ColorsUtils.grey),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                CustomImage(
            imageUrl??AssetUtils.logo,
                  height: 18.h,
                  width: 75.w,
                  fit: BoxFit.fill,
                  radius: 6,
                ),
                CustomText(
                  module.name,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: ColorsUtils.primary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                CustomText(
                  module.instructorName??'',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: ColorsUtils.grey,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Zap.toNamed(Routes.course, arguments: module),
                      child: const CustomText(
                        'View Course',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorsUtils.main,
                      ),
                    ),
                    CustomText(
                      '${module.price.toStringAsFixed(0)} EGP',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: ColorsUtils.primary,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
