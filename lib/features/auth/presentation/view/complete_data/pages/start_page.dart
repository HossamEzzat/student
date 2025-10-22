import 'package:flutter/material.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_text.dart';

class StartPage extends StatelessWidget {
  final VoidCallback onNext;

  const StartPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        const Center(
          child: CustomText(
            'Just 4 questions before you start!',
            color: ColorsUtils.primary,
            fontSize: 24,
            textAlign: TextAlign.center,
          ),
        ),
        const CustomImage(AssetUtils.launchingRafikiImage),
        CustomButton(title: 'I\'m Ready', onPressed: onNext),
      ],
    );
  }
}
