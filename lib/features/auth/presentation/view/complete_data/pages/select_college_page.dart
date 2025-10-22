import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_field.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/auth/cubit/auth_cubit.dart';

class SelectCollegePage extends StatefulWidget {
  final VoidCallback onNext;

  const SelectCollegePage({super.key, required this.onNext});

  @override
  State<SelectCollegePage> createState() => _SelectCollegePageState();
}

class _SelectCollegePageState extends State<SelectCollegePage> {
  @override
  void initState() {
    super.initState();
    final authCubit = context.read<AuthCubit>();
    if (authCubit.selectedUniversityId != null) {
      authCubit.getFacultiesByUniversityId(authCubit.selectedUniversityId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading && authCubit.faculties.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            const CustomText('Select your faculty'),
            CustomField(
              hintText: 'Select your faculty',
              fieldType: FieldType.dropdown,
              value: authCubit.selectedFacultyId,
              dropdownItems: authCubit.faculties.map((faculty) {
                return DropdownMenuItem<String>(
                  value: faculty.id,
                  child: CustomText(faculty.name),
                );
              }).toList(),
              onChanged: (v) {
                setState(() {
                  authCubit.selectedFacultyId = v;
                });
              },
            ),
            const Spacer(),
            Center(
              child: CustomButton(
                title: 'Next',
                onPressed: authCubit.selectedFacultyId != null
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
