import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resumely/app/constants/app_colors.dart';

class AppSvgIcon extends StatelessWidget {
  final String assetPath;
  final double? size;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  const AppSvgIcon(
    this.assetPath, {
    super.key,
    this.size,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = width ?? (size != null ? size!.r : 20.r);
    final effectiveHeight = height ?? (size != null ? size!.r : 20.r);
    final effectiveColor = color ?? IconTheme.of(context).color ?? AppColors.foreground;

    return SvgPicture.asset(
      assetPath,
      width: effectiveWidth,
      height: effectiveHeight,
      fit: fit,
      colorFilter: ColorFilter.mode(effectiveColor, BlendMode.srcIn),
    );
  }
}
