import 'package:flutter/material.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/services/storage_service.dart';
import 'package:student/core/shared/widgets/default_appbar.dart';
import 'package:student/core/utils/asset_utils.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_image.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:zapx/zapx.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  Future<void> _showSignOutDialog(BuildContext context) async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomText(
            'Sign Out',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          content: const CustomText(
            'Are you sure you want to sign out? All your local data and progress will be cleared.',
            fontSize: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const CustomText(
                'Cancel',
                color: ColorsUtils.grey,
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const CustomText(
                'Sign Out',
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );

    if (shouldSignOut == true && context.mounted) {
      await _handleSignOut(context);
    }
  }

  Future<void> _handleSignOut(BuildContext context) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: ColorsUtils.main,
        ),
      ),
    );

    try {
      // Clear all cached data
      await storageService.clearAll();

      if (context.mounted) {
        // Close loading dialog
        Navigator.of(context).pop();

        // Navigate to login screen and remove all previous routes
        Zap.offAllNamed(Routes.login);
      }
    } catch (e) {
      if (context.mounted) {
        // Close loading dialog
        Navigator.of(context).pop();

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText(
              'Failed to sign out: ${e.toString()}',
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          const CustomText(
            'Settings',
            color: ColorsUtils.primary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 10),
          settingItem(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            color: const Color(0xff398DFF),
            onTap: () => Zap.toNamed(Routes.notifications),
          ),
          settingItem(
            icon: AssetUtils.appSettingsIcon,
            title: 'App Settings',
            color: const Color(0xff49C19C),
          ),
          settingItem(
            icon: Icons.info_outline,
            title: 'About',
            color: const Color(0xffA89EFC),
          ),
          settingItem(
            icon: AssetUtils.supportIcon,
            title: 'Technical Support',
            color: const Color(0xff398DFF),
          ),
          const Spacer(),
          // Sign Out Button
          settingItem(
            icon: Icons.logout,
            title: 'Sign Out',
            color: Colors.red,
            onTap: () => _showSignOutDialog(context),
          ),
          const SizedBox(height: 20),
        ],
      ).paddingAll(15),
    );
  }

  Widget settingItem({
    // String image path or Icon
    required dynamic icon,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    final isSignOut = title == 'Sign Out';

    return InkWell(
      onTap: onTap,
      child: CustomContainer(
        border: Border.all(
          color: isSignOut ? Colors.red.withValues(alpha: 0.3) : ColorsUtils.grey2,
        ),
        borderRadius: 12,
        child: Row(
          spacing: 10,
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.2),
              child: icon is String
                  ? CustomImage(icon, color: color)
                  : Icon(icon as IconData, color: color),
            ),
            Expanded(
              child: CustomText(
                title,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isSignOut ? Colors.red : ColorsUtils.primary,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: isSignOut ? Colors.red : ColorsUtils.primary,
            ),
          ],
        ),
      ),
    );
  }
}
