import 'package:app_factory/core/utils/app_colors.dart';
import 'package:app_factory/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    required this.onTap,
  });
  final String text;
  final Color? color;
  final Color? textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: color ?? AppColors.blueColor,
        ),
        child: Center(
          child: Text(
            text,
            style: AppStyles.bold16white.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
