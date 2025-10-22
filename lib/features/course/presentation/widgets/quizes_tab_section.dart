import 'package:flutter/material.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_text.dart';

class QuizesTabSection extends StatelessWidget {
  const QuizesTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: CustomText(
          'No quizzes available yet',
          fontSize: 14,
          color: ColorsUtils.grey,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
