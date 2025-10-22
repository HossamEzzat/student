import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/auth/cubit/auth_cubit.dart';

class CompleteRegistrationPage extends StatelessWidget {
  final VoidCallback onNext;

  const CompleteRegistrationPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          onNext();
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15,
          children: [
            const CustomText(
              'Ready to create your account?',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (state is AuthLoading)
              const CircularProgressIndicator()
            else
              CustomButton(
                title: 'Create Account',
                onPressed: () async {
                  await authCubit.registerStudent();
                },
              ),
            if (state is AuthError)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  state.message,
                  color: Colors.red,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        );
      },
    );
  }
}
