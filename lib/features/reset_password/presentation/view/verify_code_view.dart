import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/utils/toast_utils.dart';
import 'package:student/core/widgets/custom_button.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/reset_password/cubit/reset_password_cubit.dart';
import 'package:zapx/zapx.dart';
import 'package:zap_sizer/zap_sizer.dart';

class VerifyCodeView extends StatefulWidget {
  const VerifyCodeView({super.key});

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String _getCode() {
    return _controllers.map((controller) => controller.text).join();
  }

  void _handleVerifyCode() {
    if (_formKey.currentState!.validate()) {
      final code = _getCode();
      context.read<ResetPasswordCubit>().verifyCode(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'Verify Code',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is VerifyCodeSuccess) {
            ToastUtils.showSuccess(context, state.message);
            Zap.toNamed(Routes.setNewPassword);
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
                    'Enter Verification Code',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorsUtils.main,
                  ),
                  SizedBox(height: 2.h),
                  const CustomText(
                    'Please enter the 6-digit code sent to your email',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                      (index) => _buildCodeInputField(index),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Center(
                    child: CustomButton(
                      title: isLoading ? 'Verifying...' : 'Verify Code',
                      onPressed: isLoading ? null : _handleVerifyCode,
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

  Widget _buildCodeInputField(int index) {
    return SizedBox(
      width: 12.w,
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ColorsUtils.main),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ColorsUtils.main, width: 2),
          ),
          filled: true,
          fillColor: const Color(0xffF0F1F2),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
      ),
    );
  }
}
