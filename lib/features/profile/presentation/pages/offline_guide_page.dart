import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class OfflineGuidePage extends StatelessWidget {
  static const path = '/help/offline-guide';
  const OfflineGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: 'Offline editing support',
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
                  icon: Icons.devices_rounded,
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
                        'Local-First Architecture',
                        style: AppTextStyles.h4,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Edit your resumes on planes, trains, or with zero internet connection. Your data never gets lost.',
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

          // Key Offline Capabilities
          Text(
            'HOW OFFLINE MODE WORKS',
            style: AppTextStyles.overline,
          ),
          AppSpacing.v10,

          const _FeatureItem(
            icon: Icons.flash_on_rounded,
            title: 'Instant Local Storage (Hive)',
            description: 'Every keystroke and section update is instantly saved to your phone\'s local encrypted storage box.',
          ),
          AppSpacing.v8,
          const _FeatureItem(
            icon: AppIcons.fileText,
            title: 'On-Device PDF Generation',
            description: 'Resumely runs its vector PDF compilation engine directly inside the app, so exports require zero internet connectivity.',
          ),
          AppSpacing.v8,
          const _FeatureItem(
            icon: Icons.cloud_done_rounded,
            title: 'Seamless Background Sync',
            description: 'Whenever your device reconnects to Wi-Fi or mobile data, your latest edits automatically synchronize with your cloud account.',
          ),
          AppSpacing.v20,

          // Storage Status Card
          Text(
            'LOCAL STORAGE STATUS',
            style: AppTextStyles.overline,
          ),
          AppSpacing.v10,

          CardContainer(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8.r,
                          height: 8.r,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        AppSpacing.h8,
                        Text('Hive Box Engine', style: AppTextStyles.bodyMedium),
                      ],
                    ),
                    Text(
                      'ACTIVE & HEALTHY',
                      style: AppTextStyles.overline.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                AppSpacing.v12,
                const Divider(color: AppColors.border, height: 1),
                AppSpacing.v12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Storage Type', style: AppTextStyles.caption),
                    Text('On-Device Binary Cache', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Offline Export Ready', style: AppTextStyles.caption),
                    Text('Yes (100% On-Device)', style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.v24,

          // Best practices
          Text(
            'BEST PRACTICES',
            style: AppTextStyles.overline,
          ),
          AppSpacing.v10,

          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: AppSpacing.borderRadiusLg,
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💡 Tips for Offline Use',
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 6.h),
                Text(
                  '• You can freely create, duplicate, and delete resumes offline.\n• All PDF exports are saved to your device download folder.\n• Ensure the app remains installed to retain local databases.',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.v20,
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final dynamic icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      padding: EdgeInsets.all(12.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIcon(
            icon: icon,
            size: 16.r,
            color: AppColors.primary,
            containerSize: 32.r,
            backgroundColor: AppColors.secondary,
            borderRadius: AppSpacing.borderRadiusSm,
          ),
          AppSpacing.h12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  description,
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
    );
  }
}
