import 'package:flutter/material.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:zap_sizer/zap_sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton.icon({
    super.key,
    this.title,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.radius,
    this.width,
    this.height,
    this.style,
    this.hasSahdow,
    this.removeWidth = false,
    this.padding,
    this.textColor,
    this.border,
    this.borderColor,
    this.iconAlignment,
    this.isLink = false,
    this.child,
  }) : withIcon = true,
       withText = false;
  const CustomButton({
    super.key,
    this.title,
    required this.onPressed,
    this.backgroundColor,
    this.radius,
    this.width,
    this.height,
    this.style,
    this.hasSahdow,
    this.border,
    this.removeWidth = false,
    this.padding,
    this.borderColor,
    this.textColor,
    this.isLink = false,
    this.child,
  }) : withIcon = false,
       icon = null,
       iconAlignment = IconAlignment.end,
       withText = false;
  const CustomButton.text({
    super.key,
    this.title,
    required this.onPressed,
    this.backgroundColor,
    this.radius,
    this.width,
    this.height,
    this.style,
    this.hasSahdow,
    this.border,
    this.removeWidth = false,
    this.padding,
    this.borderColor,
    this.textColor=Colors.black,
    this.isLink = false,
    this.child,
  }) : withIcon = false,
       icon = null,
       iconAlignment = IconAlignment.end,
       withText = true;
  final Widget? icon, child;
  final bool withIcon, withText;
  final String? title;
  final Color? textColor;
  final VoidCallback? onPressed;
  final bool isLink;
  final Color? backgroundColor, borderColor;
  final BorderSide? border;
  final double? radius;
  final double? width;
  final double? height;
  final TextStyle? style;
  final bool? hasSahdow;
  final EdgeInsets? padding;
  final bool removeWidth;
  final IconAlignment? iconAlignment;
  @override
  Widget build(BuildContext context) {
    final double? width =removeWidth?null: this.width ?? 70.w;

    final EdgeInsets padding =
        this.padding ??
        const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
    final _child = CustomContainer(
      width: width,
      fullPadding: padding,
      child:
          child ??
          CustomText(
            title!,
            color:
                textColor ??
                style?.color ??
                (isLink ? Colors.blueAccent : Colors.white),
            fontSize: style?.fontSize ?? 14,
            fontWeight: style?.fontWeight ?? FontWeight.w500,
            letterSpacing: style?.letterSpacing,
            height: style?.height,
            decoration: style?.decoration,
            textAlign: TextAlign.center,
          ),
    );
    if (withText) {
      return TextButton(onPressed: onPressed, child: _child);
    }
    if (withIcon) {
      return ElevatedButton.icon(
        icon: icon is Icon
            ? Icon(
                (icon as Icon).icon,
                color: textColor ?? style?.color ?? Colors.white,
                size: (style?.fontSize ?? 14) + 4,
              )
            : icon,
        iconAlignment: iconAlignment ?? IconAlignment.end,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(padding),
          elevation: WidgetStatePropertyAll(hasSahdow == true ? 2 : 0),
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? ColorsUtils.main,
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 12),
              side: borderColor == null && border == null
                  ? BorderSide.none
                  : border ??
                        BorderSide(
                          color: borderColor ?? Colors.transparent,
                          width: 1,
                        ),
            ),
          ),
        ),
        onPressed: onPressed,
        label: _child,
      );
    }
    return MaterialButton(
      padding: padding,
      // padding: EdgeInsets.symmetric(vertical: context.propHeight(15)),
      minWidth: removeWidth ? null : width,
      height: height,
      elevation: hasSahdow == true ? 2 : 0,

      color: backgroundColor ?? ColorsUtils.main,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 12),
        side: borderColor == null && border == null
            ? BorderSide.none
            : border ??
                  BorderSide(
                    color: borderColor ?? Colors.transparent,
                    width: 1,
                  ),
      ),
      onPressed: onPressed,
      child: _child,
    );
  }
}
