import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_svg_icon.dart';
import 'package:resumely/app/constants/app_colors.dart';

class AppIcon extends StatelessWidget {
  final dynamic icon; // Can be String (svg asset path) or IconData
  final double? size;
  final Color? color;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final double? containerSize;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;

  const AppIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
    this.backgroundColor,
    this.backgroundGradient,
    this.containerSize,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size != null ? size!.r : 18.r;
    final effectiveColor = color ?? AppColors.primary;

    Widget iconWidget;
    if (icon is String) {
      iconWidget = AppSvgIcon(
        icon as String,
        size: effectiveSize,
        color: effectiveColor,
      );
    } else if (icon is IconData) {
      iconWidget = Icon(
        icon as IconData,
        size: effectiveSize,
        color: effectiveColor,
      );
    } else if (icon is Widget) {
      iconWidget = icon as Widget;
    } else {
      iconWidget = const SizedBox.shrink();
    }

    if (containerSize != null ||
        backgroundColor != null ||
        backgroundGradient != null ||
        border != null ||
        padding != null) {
      final effContainerSize = containerSize?.r;

      return Container(
        width: effContainerSize,
        height: effContainerSize,
        padding: padding ?? (effContainerSize == null ? EdgeInsets.all(8.r) : null),
        decoration: BoxDecoration(
          color: backgroundGradient == null ? (backgroundColor ?? AppColors.secondary) : null,
          gradient: backgroundGradient,
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          border: border,
          boxShadow: boxShadow,
        ),
        child: Center(child: iconWidget),
      );
    }

    return iconWidget;
  }
}
