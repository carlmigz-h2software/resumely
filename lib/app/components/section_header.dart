import 'package:flutter/material.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final TextStyle? titleStyle;
  final VoidCallback? onTrailingTap;
  final String? trailingText;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.titleStyle,
    this.onTrailingTap,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle ?? AppTextStyles.h4,
            ),
            if (subtitle != null) ...[
              Text(
                subtitle!,
                style: AppTextStyles.caption,
              ),
            ],
          ],
        ),
        if (trailing != null)
          trailing!
        else if (trailingText != null)
          GestureDetector(
            onTap: onTrailingTap,
            child: Text(
              trailingText!,
              style: AppTextStyles.caption.copyWith(
                color: onTrailingTap != null ? AppColors.primary : AppColors.mutedForeground,
                fontWeight: onTrailingTap != null ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}
