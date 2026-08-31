import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/constants/app_colors.dart';

class PreviewContactItem extends StatelessWidget {
  final dynamic icon;
  final String text;

  const PreviewContactItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(
          icon: icon,
          size: 11.r,
          color: AppColors.docTextSecondary,
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 9.5.sp,
            color: AppColors.docTextSecondary,
          ),
        ),
      ],
    );
  }
}
