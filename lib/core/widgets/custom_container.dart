import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child,
    this.borderRadius,
    this.color,
    this.padding,
    this.isCircle = false,
    this.margin,
    this.height,
    this.width,
    this.constraints,
    this.border,
    this.boxShadow,
    this.radius,
    this.image,
    this.gradient,
    this.fullPadding,
  });
  final Widget? child;
  final double? padding, borderRadius, width, height;
  final Color? color;
  final bool isCircle;
  final EdgeInsets? margin, fullPadding;
  final BoxConstraints? constraints;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final BorderRadiusGeometry? radius;
  final DecorationImage? image;
  final Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      padding: fullPadding ??
          EdgeInsets.all(
            padding ?? 10,
          ),
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        image: image,
        gradient: gradient,
        borderRadius: !isCircle
            ? radius ?? BorderRadius.circular(borderRadius ?? 12)
            : null,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        color: color,
        border: border,
      ),
      child: child,
    );
  }
}
