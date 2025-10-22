import 'package:flutter/material.dart';
import 'package:student/core/app/globals.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/services/storage_service.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:zapx/zapx.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    // Load user data from storage
    userData = await storageService.getUser();

    if (!mounted) return;

    // Navigate based on whether user data exists
    if (userData != null) {
      Zap.offAllNamed(Routes.navigationBottom);
    } else {
      Zap.offAllNamed(Routes.onBoarding);
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomImage(AssetUtils.logo)
      ),
    );
  }
}

