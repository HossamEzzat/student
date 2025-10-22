import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_field.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/auth/cubit/auth_cubit.dart';

class SelectLevelPage extends StatefulWidget {
  final VoidCallback onNext;

  const SelectLevelPage({super.key, required this.onNext});

  @override
  State<SelectLevelPage> createState() => _SelectLevelPageState();
}

class _SelectLevelPageState extends State<SelectLevelPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getLevels();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading && authCubit.levels.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            const CustomText('Select your level'),
            CustomField(
              hintText: 'Select your level',
              fieldType: FieldType.dropdown,
              value: authCubit.selectedLevelId,
              dropdownItems: authCubit.levels.map((level) {
                return DropdownMenuItem<String>(
                  value: level.id,
                  child: CustomText(level.name),
                );
              }).toList(),
              onChanged: (v) {
                setState(() {
                  authCubit.selectedLevelId = v;
                });
              },
            ),
            const Spacer(),
            Center(
              child: CustomButton(
                title: 'Create Account',
                onPressed: authCubit.selectedLevelId != null
                    ? () async {
                        await authCubit.registerStudent();
                        if (context.mounted && state is! AuthError) {
                          widget.onNext();
                        }
                      }
                    : null,
              ),
            ),
            if (state is AuthError)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  state.message,
                  color: Colors.red,
                ),
              ),
          ],
        );
      },
    );
  }
}
