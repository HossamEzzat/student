import 'package:flutter/material.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_text.dart';

class AboutTabSection extends StatelessWidget {
  const AboutTabSection(this.about,{super.key});
final String about;
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: CustomText(
      about,
        color: ColorsUtils.grey,
        fontSize: 13,
        height: 1.6,
      ),
    );
  }
}
