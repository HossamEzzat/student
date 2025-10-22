import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/utils/toast_utils.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_field.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/reset_password/cubit/reset_password_cubit.dart';
import 'package:zapx/zapx.dart';
import 'package:zap_sizer/zap_sizer.dart';

class SetNewPasswordView extends StatefulWidget {
  const SetNewPasswordView({super.key});

  @override
  State<SetNewPasswordView> createState() => _SetNewPasswordViewState();
}

class _SetNewPasswordViewState extends State<SetNewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _handleSetNewPassword() {
    if (_formKey.currentState!.validate()) {
      context.read<ResetPasswordCubit>().setNewPassword(_passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'Set New Password',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is SetNewPasswordSuccess) {
            ToastUtils.showSuccess(context, state.message);
            context.read<ResetPasswordCubit>().reset();
            Zap.offAllNamed(Routes.login);
          } else if (state is ResetPasswordError) {
            ToastUtils.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is ResetPasswordLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.all(5.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.h),
                  const CustomText(
                    'Create New Password',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorsUtils.main,
                  ),
                  SizedBox(height: 2.h),
                  const CustomText(
                    'Your new password must be different from previously used passwords',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 4.h),
                  CustomField(
                    controller: _passwordController,
                    hintText: 'New Password',
                    obscureText: _obscurePassword,
                    perfixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: context.read<ResetPasswordCubit>().validatePassword,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 2.h),
                  CustomField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: _obscureConfirmPassword,
                    perfixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    validator: _validateConfirmPassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _handleSetNewPassword(),
                  ),
                  SizedBox(height: 2.h),
                  _buildPasswordRequirements(),
                  SizedBox(height: 4.h),
                  Center(
                    child: CustomButton(
                      title: isLoading ? 'Setting Password...' : 'Set New Password',
                      onPressed: isLoading ? null : _handleSetNewPassword,
                      backgroundColor: ColorsUtils.main,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPasswordRequirements() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            'Password must contain:',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          SizedBox(height: 1.h),
          _buildRequirementItem('At least 8 characters'),
          _buildRequirementItem('At least one uppercase letter'),
          _buildRequirementItem('At least one lowercase letter'),
          _buildRequirementItem('At least one digit'),
          _buildRequirementItem('At least one special character (!@#\$%^&*...)'),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.3.h),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: Colors.grey[600]),
          SizedBox(width: 2.w),
          Expanded(
            child: CustomText(
              text,
              fontSize: 11,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
