import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/utils/toast_utils.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_field.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/auth/cubit/auth_cubit.dart';
import 'package:zapx/zapx.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ToastUtils.showSuccess(context, state.message);
          Zap.toNamed(Routes.navigationBottom);
        } else if (state is AuthError) {
          ToastUtils.showError(context, state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        final isLoading = state is AuthLoading;

        return Scaffold(
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  Column(
                    spacing: 12,
                    children: [
                      const CustomImage(AssetUtils.logoSecond),
                      const SizedBox(height: 20),
                      const Center(
                        child: CustomText(
                          'Welcome Back!',
                          fontWeight: FontWeight.w700,
                          color: ColorsUtils.primary,
                          fontSize: 20,
                        ),
                      ),
                      const Center(
                        child: CustomText(
                          'Sign In to your account',
                          color: ColorsUtils.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      IgnorePointer(
                        ignoring: isLoading,
                        child: CustomField(
                          hintText: 'Username',
                          fieldType: FieldType.text,
                          controller: userNameController,
                        ),
                      ),
                      IgnorePointer(
                        ignoring: isLoading,
                        child: ValueListenableBuilder(
                          valueListenable: isPasswordVisible,
                          builder: (context, value, child) => CustomField(
                            hintText: 'Password',
                            fieldType: FieldType.text,
                            controller: passwordController,
                            obscureText: !value,
                            suffixIcon: IconButton(
                              icon: Icon(
                                value ? Icons.visibility : Icons.visibility_off,
                                color: ColorsUtils.primary,
                              ),
                              onPressed: () {
                                isPasswordVisible.value = !isPasswordVisible.value;
                              },
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: isLoading ? null : () {
                            Zap.toNamed(Routes.sendResetCode);
                          },
                          child: const CustomText(
                            'Forgot Password?',
                            color: ColorsUtils.main,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        title: isLoading ? 'Signing In...' : 'Sign In',
                        onPressed: isLoading
                            ? null
                            : () {
                                final userName = userNameController.text.trim();
                                final password = passwordController.text.trim();

                                if (userName.isEmpty) {
                                  ToastUtils.showError(context, 'Username is required');
                                  return;
                                }

                                if (password.isEmpty) {
                                  ToastUtils.showError(context, 'Password is required');
                                  return;
                                }

                                cubit.loginStudent(userName, password);
                              },
                      ),
                      CustomButton.text(
                        onPressed: isLoading ? null : () => Zap.toNamed(Routes.register),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: ColorsUtils.main,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      
    );
  }
}
