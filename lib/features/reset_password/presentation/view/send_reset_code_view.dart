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

class SendResetCodeView extends StatefulWidget {
  const SendResetCodeView({super.key});

  @override
  State<SendResetCodeView> createState() => _SendResetCodeViewState();
}

class _SendResetCodeViewState extends State<SendResetCodeView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendCode() {
    if (_formKey.currentState!.validate()) {
      context.read<ResetPasswordCubit>().sendResetCode(_emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'Reset Password',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is SendResetCodeSuccess) {
            ToastUtils.showSuccess(context, state.message);
            Zap.toNamed(Routes.verifyCode);
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
                    'Enter Your Email',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorsUtils.main,
                  ),
                  SizedBox(height: 2.h),
                  const CustomText(
                    'We will send you a verification code to reset your password',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 4.h),
                  CustomField(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    perfixIcon: const Icon(Icons.email_outlined),
                    validator: context.read<ResetPasswordCubit>().validateEmail,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _handleSendCode(),
                  ),
                  SizedBox(height: 4.h),
                  Center(
                    child: CustomButton(
                      title: isLoading ? 'Sending...' : 'Send Code',
                      onPressed: isLoading ? null : _handleSendCode,
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
}
