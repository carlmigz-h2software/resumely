import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/profile/presentation/widgets/guide_step_card.dart';

class ExportGuidePage extends StatelessWidget {
  static const path = '/help/export-guide';
  const ExportGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: 'How to export to PDF?',
      subtitle: 'Help & Guides',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Overview Card
          CardContainer(
            isGradient: true,
            child: Row(
              children: [
                AppIcon(
                  icon: AppIcons.fileText,
                  size: 28.r,
                  color: AppColors.primaryForeground,
                  containerSize: 52.r,
                  backgroundGradient: AppColors.primaryGradient,
                  boxShadow: AppColors.primaryGlow,
                ),
                AppSpacing.h16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Crisp, Vector PDF Export',
                        style: AppTextStyles.h4,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Generate standard A4 documents that look flawless on any recruiter’s screen or print.',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.v20,

          Text(
            'STEP-BY-STEP WORKFLOW',
            style: AppTextStyles.overline,
          ),
          AppSpacing.v10,

          // Step 1
          const GuideStepCard(
            stepNumber: 1,
            title: 'Complete your resume details',
            description: 'Make sure your personal info, experience, and education sections are filled in and saved.',
            icon: AppIcons.fileUser,
          ),
          AppSpacing.v10,

          // Step 2
          const GuideStepCard(
            stepNumber: 2,
            title: 'Open Document Preview',
            description: 'Tap the "Preview" button in the top navigation bar of the editor to inspect the layout.',
            icon: Icons.visibility_outlined,
          ),
          AppSpacing.v10,

          // Step 3
          const GuideStepCard(
            stepNumber: 3,
            title: 'Tap Export PDF',
            description: 'Press the "Export PDF" button at the top right of the preview page to launch the print preview.',
            icon: Icons.download_rounded,
          ),
          AppSpacing.v10,

          // Step 4
          const GuideStepCard(
            stepNumber: 4,
            title: 'Save or Share',
            description: 'In the system print dialog, select "Save as PDF" to store the file or share directly via Email, AirDrop, or WhatsApp.',
            icon: Icons.share_rounded,
          ),
          AppSpacing.v20,

          // Pro Tip Banner
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: AppSpacing.borderRadiusLg,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppIcon(
                  icon: AppIcons.sparkles,
                  size: 16.r,
                  color: AppColors.primary,
                ),
                AppSpacing.h10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pro Tip for ATS Format',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.foreground,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Resumely produces pure vector text so Applicant Tracking Systems (ATS) can parse your keywords with 100% accuracy.',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.v24,

          // Action Button
          GradientButton(
            onPressed: () => context.push('/preview'),
            text: 'Preview & Export Now',
            icon: Icon(Icons.description_outlined, size: 18.r, color: AppColors.primaryForeground),
          ),
          AppSpacing.v20,
        ],
      ),
    );
  }
}
