import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_field.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/auth/cubit/auth_cubit.dart';

class SelectUniversityPage extends StatefulWidget {
  final VoidCallback onNext;

  const SelectUniversityPage({
    super.key,
    required this.onNext,
  });

  @override
  State<SelectUniversityPage> createState() => _SelectUniversityPageState();
}

class _SelectUniversityPageState extends State<SelectUniversityPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUniversities();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading && authCubit.universities.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            const CustomText('Select your university'),
            CustomField(
              hintText: 'Select your university',
              fieldType: FieldType.dropdown,
              value: authCubit.selectedUniversityId,
              dropdownItems: authCubit.universities.map((university) {
                return DropdownMenuItem(
                  value: university.id,
                  child: CustomText(university.name),
                );
              }).toList(),
              onChanged: (v) {
                setState(() {
                  authCubit.selectedUniversityId = v;
                  authCubit.selectedFacultyId = null;
                });
              },
            ),
            const Spacer(),
            Center(
              child: CustomButton(
                title: 'Next',
                onPressed: authCubit.selectedUniversityId != null
                    ? widget.onNext
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
