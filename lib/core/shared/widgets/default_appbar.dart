import 'package:flutter/material.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/widgets/custom_appbar.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:zapx/zapx.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      title: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Welcome Back!',
            fontSize: 12,
            color: Color.fromARGB(255, 228, 225, 225),
            fontWeight: FontWeight.w400,
          ),
          CustomText('Islam Magdi'),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => Zap.toNamed(Routes.notifications),
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
