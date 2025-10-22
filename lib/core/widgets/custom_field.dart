import 'package:flutter/material.dart';

enum FieldType { text, dropdown }

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    this.hintText,
    this.onChanged,
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.perfixIcon,
    this.textInputAction,
    this.onFieldSubmitted,
    this.color,
    this.autofocus = false,
    this.keyboardType,
    this.validator,
    this.fieldType = FieldType.text,
    this.dropdownItems,
    this.onDateSelected,
    this.maxLines = 1,
    this.minLines,
    this.onTimeChanged,
    this.borderColor,
    this.value,
  });
  final FieldType fieldType;
  final String? hintText;
  final void Function(String? v)? onChanged, onFieldSubmitted;
  final TextEditingController? controller;
  final Widget? suffixIcon, perfixIcon;
  final TextInputAction? textInputAction;
  final bool autofocus, obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Color? color, borderColor;
  final List<DropdownMenuItem<String>>? dropdownItems;
  final void Function(DateTime)? onDateSelected;
  final void Function(TimeOfDay)? onTimeChanged;
  final int? minLines, maxLines;
  final String? value;
  @override
  Widget build(BuildContext context) {
    final color = this.color ?? const Color(0xffF0F1F2);
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: borderColor != null
          ? BorderSide(color: borderColor!)
          : BorderSide.none,
    );
    var decoration = InputDecoration(
      hintText: hintText,
      border: border,
      suffixIcon: suffixIcon,
      prefixIcon: perfixIcon,
      enabledBorder: border,
      filled: true,
      fillColor: color,
      focusedBorder: border,
    );
    bool isText = fieldType == FieldType.text;
    if (fieldType == FieldType.dropdown) {
      return DropdownButtonFormField<String>(
        value: value,
        items: dropdownItems,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        validator: validator,
        decoration: decoration,
        onChanged: onChanged,
        isExpanded: true,
        isDense: true,
      );
    }
    return TextFormField(
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      enabled: isText,
      textInputAction: textInputAction,
      decoration: decoration,
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
