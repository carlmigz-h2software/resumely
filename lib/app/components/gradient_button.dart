import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Widget? icon;
  final bool isLoading;
  final double? width;
  final double? height;
  final bool isGlow;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
    this.isGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? 48.h;
    final borderRadius = AppSpacing.borderRadiusMd;

    return Container(
      width: width ?? double.infinity,
      height: effectiveHeight,
      decoration: BoxDecoration(
        gradient: onPressed != null ? AppColors.primaryGradient : null,
        color: onPressed == null ? AppColors.muted : null,
        borderRadius: borderRadius,
        boxShadow: isGlow && onPressed != null ? AppColors.primaryGlow : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: borderRadius,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryForeground,
                      ),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        icon!,
                        SizedBox(width: 8.w),
                      ],
                      Text(
                        text,
                        style: AppTextStyles.buttonText,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
