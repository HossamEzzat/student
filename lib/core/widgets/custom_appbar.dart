import 'package:flutter/material.dart';
import 'package:student/core/utils/colors_utils.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final VoidCallback? onBack;

  const CustomAppbar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation = 0,
    this.bottom,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorsUtils.main,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: AppBar(
        title: title,
        actions: actions,
        leading: onBack != null
            ? IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_ios_new),
              )
            : leading,
        centerTitle: centerTitle,
        backgroundColor: Colors.transparent,
        elevation: elevation,
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
