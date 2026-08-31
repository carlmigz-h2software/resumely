import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/constants/app_colors.dart';

class AppIconButton extends StatelessWidget {
  final dynamic icon;
  final VoidCallback? onTap;
  final double? size;
  final double? iconSize;
  final Color? color;
  final Color? backgroundColor;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final ShapeBorder? shape;
  final BorderRadius? borderRadius;
  final String? tooltip;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size,
    this.iconSize,
    this.color,
    this.backgroundColor,
    this.gradient,
    this.boxShadow,
    this.shape,
    this.borderRadius,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size != null ? size!.r : 36.r;
    final effectiveIconSize = iconSize != null ? iconSize!.r : 18.r;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(effectiveSize / 2);

    Widget content = Container(
      width: effectiveSize,
      height: effectiveSize,
      decoration: BoxDecoration(
        color: gradient == null ? (backgroundColor ?? AppColors.secondary) : null,
        gradient: gradient,
        borderRadius: effectiveRadius,
        boxShadow: boxShadow,
      ),
      child: Center(
        child: AppIcon(
          icon: icon,
          size: effectiveIconSize,
          color: color ?? AppColors.foreground,
        ),
      ),
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        borderRadius: effectiveRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: effectiveRadius,
          child: content,
        ),
      );
    }

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: content,
      );
    }

    return content;
  }
}
