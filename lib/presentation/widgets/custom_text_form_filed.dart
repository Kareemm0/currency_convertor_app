import 'package:currency_convertor_app/core/core.dart';
import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    this.hintText,
    required this.controller,
  });
  final String? hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey98),
          borderRadius: BorderRadius.circular(16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey98),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
