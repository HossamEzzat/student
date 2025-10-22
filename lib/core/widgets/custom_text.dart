import 'package:flutter/material.dart';
import 'package:zap_sizer/zap_sizer.dart';

class CustomText extends StatelessWidget {
  final String data;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final Color? color;
  final FontWeight? fontWeight;
  final double fontSize;
  final double? letterSpacing, wordSpacing, height;
  final TextDecoration? decoration;
  const CustomText(
    this.data, {
    super.key,
    this.color,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.wordSpacing,
    this.textScaleFactor,
    this.height,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.fontSize = 14,
    this.fontWeight,
    this.decoration,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    double? getFontSize() {
      if (context.findAncestorWidgetOfExactType<AppBar>() != null &&
          fontSize == 14) {
        return 18;
      }

      return fontSize;
    }

    FontWeight? getFontWeight() {
      if (context.findAncestorWidgetOfExactType<AppBar>() != null) {
        return fontWeight??FontWeight.w700;
      }
      // else if (context.findAncestorWidgetOfExactType<CustomButton>() !=
      //     null) {
      //   return FontWeight.w600;
      // }
      return fontWeight;
    }

    Color? getColor() {
      if (context.findAncestorWidgetOfExactType<AppBar>() != null) {
        return color?? Colors.white;
      }
      // else  if (context.findAncestorWidgetOfExactType<CustomButton>() != null&&color==null) {
      //   return Colors.white;
      // }
      return color;
    }

    return Text(
      data,
      key: key,
      style: TextStyle(
        fontFamily: 'Plus_Jakarta_Sans',

        color: getColor(),
        height: height,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        fontSize: getFontSize()?.sp,
        decoration: decoration,
        fontWeight: getFontWeight(),
      ),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
    );
  }
}
