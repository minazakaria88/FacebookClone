import 'package:app_factory/core/utils/app_colors.dart';
import 'package:app_factory/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  const MyTextForm({
    super.key,
    required this.hint,
    required this.controller,
    this.validator, this.maxLines,
  });
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int ? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines:maxLines,
      controller: controller,
      validator: validator,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        fillColor: AppColors.greyColor,
        filled: true,
        hintText: hint,
        hintStyle: AppStyles.regular16textgreyColor,
      ),
    );
  }
}
