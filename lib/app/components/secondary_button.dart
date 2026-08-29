import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? 48.h;
    final borderRadius = AppSpacing.borderRadiusMd;

    return Container(
      width: width ?? double.infinity,
      height: effectiveHeight,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceElevated,
        borderRadius: borderRadius,
        border: Border.all(
          color: borderColor ?? AppColors.border,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  SizedBox(width: 10.w),
                ],
                Text(
                  text,
                  style: textStyle ?? AppTextStyles.secondaryButtonText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
