import 'package:flutter/material.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_text.dart';

class CustomProgressBar extends StatelessWidget {
  final double value;
  final Color progressColor;
  final double height;
  final double borderRadius;

  const CustomProgressBar({
    super.key,
    required this.value,
    this.progressColor = ColorsUtils.main,
    this.height = 10,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (value * 100).toInt();

    return LayoutBuilder(
      builder: (context, constraints) {
        final progressWidth = constraints.maxWidth * value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.centerLeft,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: ColorsUtils.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                Positioned(
                  left: progressWidth - height / 1.5,
                  bottom: 10,
                  child: CustomText(
                    '$percentage%',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: progressWidth,
                      height: height,
                      decoration: BoxDecoration(
                        color: progressColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    Positioned(
                      left: progressWidth - height / 1.5,
                      top: -(height / 4),
                      child: Container(
                        width: height * 1.4,
                        height: height * 1.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: progressColor, width: 2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
