import 'package:flutter/material.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:zapx/zapx.dart';

class SuccessMessagePage extends StatelessWidget {
  const SuccessMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
  const Spacer(),
        const CustomImage(AssetUtils.congratsIcon),
        const CustomText('Congrats!', fontSize: 24, fontWeight: FontWeight.w700),
        const CustomText(
          'Your account has been created successfully!  You’re all set, start learning now.',
          textAlign: TextAlign.center,
          color: Colors.grey,
        ),
  const Spacer(),
        CustomButton.icon(
          icon: const Icon(Icons.arrow_forward_ios),
          title: 'Login now',
          onPressed: () => Zap.offAllNamed(Routes.login),
        ),
      ],
    );
  }
}
