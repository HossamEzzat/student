import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_field.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/auth/cubit/auth_cubit.dart';
import 'package:zapx/zapx.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);

  @override
  void dispose() {
    _fullNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleCreateAccount() {
    if (_formKey.currentState?.validate() ?? false) {
      final authCubit = context.read<AuthCubit>();
      authCubit.fullName = _fullNameController.text.trim();
      authCubit.userName = _userNameController.text.trim();
      authCubit.email = _emailController.text.trim();
      authCubit.password = _passwordController.text;
      Zap.toNamed(Routes.completeData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                      'Let\'s You In',
                      fontWeight: FontWeight.w700,
                      color: ColorsUtils.primary,
                      fontSize: 20,
                    ),
                  ),
                  const Center(
                    child: CustomText(
                      'Create your account',
                      color: ColorsUtils.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomField(
                    controller: _fullNameController,
                    hintText: 'Your Name',
                    fieldType: FieldType.text,
                    validator: authCubit.validateFullName,
                  ),
                  CustomField(
                    controller: _userNameController,
                    hintText: 'Username',
                    fieldType: FieldType.text,
                    validator: authCubit.validateUserName,
                  ),
                  CustomField(
                    controller: _emailController,
                    hintText: 'Email',
                    fieldType: FieldType.text,
                    keyboardType: TextInputType.emailAddress,
                    validator: authCubit.validateEmail,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isPasswordVisible,
                    builder: (context, value, child) => CustomField(
                      controller: _passwordController,
                      hintText: 'Password',
                      fieldType: FieldType.text,
                      obscureText: !value,
                      validator: authCubit.validatePassword,
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

                  const SizedBox(height: 20),
                  CustomButton(
                    title: 'Create Account',
                    onPressed: _handleCreateAccount,
                  ),
                  CustomButton.text(
                    onPressed: () => Zap.back(),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have account? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Sign in',
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
      ),
    );
  }
}
