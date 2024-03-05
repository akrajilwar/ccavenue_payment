import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../style/font.dart';

class AppTextFieldHome extends StatelessWidget {
  const AppTextFieldHome(
      {required this.hintText,
      this.suffix,
      this.key,
      required this.controller,
      this.textInputType = TextInputType.name,
      this.filled = true,
      this.style = const TextStyle(
          color: AppColors.blackLight, fontSize: FontSize.title),
      this.textAlign = TextAlign.start,
      this.fillColor,
      this.borderSide = const BorderSide(color: AppColors.white),
      this.errorBorderSide = const BorderSide(color: Colors.red),
      this.borderRadius = 1.0,
      this.focusNode,
      required this.onChanged,
      this.errorText,
      this.validator,
      this.prefix});
  final Widget? suffix;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Function? validator;
  final Key? key;
  final TextStyle style;
  final TextAlign textAlign;
  final Color? fillColor;
  final bool filled;
  final BorderSide borderSide;
  final double borderRadius;
  final Function(String) onChanged;
  final FocusNode? focusNode;
  final String? errorText;
  final BorderSide errorBorderSide;
  final Widget? prefix;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: TextFormField(
        style: style,
        controller: controller,
        // validator: validator,
        keyboardType: textInputType,
        textAlign: textAlign,
        focusNode: focusNode,
        cursorWidth: 1.40,
        cursorHeight: 20.0,
        onChanged: (e) => onChanged(e),
        decoration: InputDecoration(
            fillColor: fillColor,
            filled: filled,
            // hintText: hintText,
            labelText: hintText,
            suffixIcon: suffix,
            hintStyle: TextStyle(
              color: AppColors.grey400,
              fontSize: FontSize.subtitle,
            ),
            prefix: prefix,
            errorText: errorText,
            contentPadding: const EdgeInsets.only(left: 10.0),
            errorBorder: OutlineInputBorder(
              borderSide: errorBorderSide,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: errorBorderSide,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: borderSide,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: AppColors.grey200))),
      ),
    );
  }
}
