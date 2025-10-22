import 'package:flutter/material.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_text.dart';

class ChooseUserTypePage extends StatelessWidget {
  final int? selectedType;
  final ValueChanged<int> onSelected;
  final VoidCallback onNext;

  const ChooseUserTypePage({
    super.key,
    required this.selectedType,
    required this.onSelected,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildOption({
      required int value,
      required String label,
      required String icon,
    }) {
      final isSelected = selectedType == value;
      final color = isSelected ? ColorsUtils.main : ColorsUtils.grey;

      return GestureDetector(
        onTap: () => onSelected(value),
        child: CustomContainer(
          border: Border.all(color: color, width: 2),
          borderRadius: 12,
          padding: 10,
          child: Column(
            spacing: 8,
            children: [
              CustomImage(icon, color: color),
              CustomText(label,
                  color: color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
            ],
          ),
        ),
      );
    }

    return Column(
      spacing: 15,
      children: [
        const CustomText('Select your type'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            buildOption(
              value: 1,
              label: 'University Student',
              icon: AssetUtils.universityStudentIcon,
            ),
            buildOption(
              value: 2,
              label: 'High School Student',
              icon: AssetUtils.highSchoolIcon,
            ),
          ],
        ),
        const Spacer(),
        CustomButton(title: 'Next', onPressed: onNext),
      ],
    );
  }
}
