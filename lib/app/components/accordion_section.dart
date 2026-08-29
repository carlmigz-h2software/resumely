import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class AccordionSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isOpen;
  final VoidCallback onToggle;
  final Widget child;
  final int? count;

  const AccordionSection({
    super.key,
    required this.title,
    required this.icon,
    required this.isOpen,
    required this.onToggle,
    required this.child,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onToggle,
              borderRadius: AppSpacing.borderRadiusLg,
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: AppSpacing.borderRadiusSm,
                      ),
                      child: Icon(
                        icon,
                        size: 18.r,
                        color: AppColors.primary,
                      ),
                    ),
                    AppSpacing.h12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.h4,
                          ),
                          if (count != null) ...[
                            SizedBox(height: 2.h),
                            Text(
                              '$count ${count == 1 ? "entry" : "entries"}',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ],
                      ),
                    ),
                    Icon(
                      isOpen
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: AppColors.mutedForeground,
                      size: 22.r,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isOpen) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(16.r, 0, 16.r, 16.r),
              child: child,
            ),
          ],
        ],
      ),
    );
  }
}
