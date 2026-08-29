import 'package:flutter/material.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isGradient;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? borderColor;

  const CardContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.isGradient = false,
    this.onTap,
    this.borderRadius,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? AppSpacing.borderRadiusLg;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: isGradient ? null : AppColors.card,
        gradient: isGradient ? AppColors.cardGradient : null,
        borderRadius: effectiveRadius,
        border: Border.all(
          color: borderColor ?? AppColors.border,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: effectiveRadius,
          child: Padding(
            padding: padding ?? AppSpacing.cardPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}
