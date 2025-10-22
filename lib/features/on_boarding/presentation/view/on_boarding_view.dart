import 'package:flutter/material.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        height: 100.h,
        fullPadding: EdgeInsets.only(top: 20.dp),
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            Stack(
              children: [
                CustomImage(
                  AssetUtils.bubblesImage,
                  fit: BoxFit.cover,
                  width: 100.w,
                ),
                const Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CustomImage(AssetUtils.personOnboardingImage),
                  ),
                ),
              ],
            ),
            const CustomText(
              'Welcome To\n Alpha Learn',
              fontSize: 26,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              color: ColorsUtils.primary,
            ),
            const CustomText(
              'Your companion through every lecture,  every quiz, and every late-night study.',
              fontSize: 16,
              textAlign: TextAlign.center,
              color: Colors.grey,
            ),
            SizedBox(height: 3.h),
            CustomButton.icon(
              icon: const Icon(Icons.arrow_forward_ios),
              title: 'Get Started',
              onPressed: () => Zap.toNamed(Routes.login),
            ),
          ],
        ),
      ),
    );
  }
}
